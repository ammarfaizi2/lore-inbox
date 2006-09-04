Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWIDO2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWIDO2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWIDO2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:28:15 -0400
Received: from web36714.mail.mud.yahoo.com ([209.191.85.48]:26959 "HELO
	web36714.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751392AbWIDO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cmHQB9VkNNceg3eZzmAD00qwFBsHhgS3qq+Z3G1T3MXKZhdcEfUZaIEnQti9J5Z8iQp5bVQuexl/+kOHu5+zfHRDGA7dE5zYzT/1aGo9TTY5g3La5gyPuKT9nVuB65AB2gvrp+/tmMdaomuCjd7tMBsxeI+P9wQFkB0Ntis6PCY=  ;
Message-ID: <20060904142811.21367.qmail@web36714.mail.mud.yahoo.com>
Date: Mon, 4 Sep 2006 07:28:11 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <44FAAF4D.70404@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> Russell King wrote:
> > It's really the bus we care about at this stage, since the errors we
> > receive are along the lines of "the card reported that the last data
> > block had a CRC error", "we encountered an underrun condition during
> > the last data block", or "the card didn't request data before we
> > timed out", etc.
> >
> > Basically, the transfer of the next block confirms that the previous
> > block was successfully received by the card.
> >
> >   
> 
> Ehm... Now I'm a bit confused. At the point of a bus error, there
> difference between the data sent to the bus and the data successfully
> received by the card should amount to one block (as the last block got
> NACK:ed for whatever reason). If we expect host drivers to report the
> bytes sent to the bus, we need to subtract one block from the value
> reported to the block layer.
> 
> Rgds
> Pierre
> 
If I understand correctly, there should be two different ways to report bytes_xfered:
1. for read operations, the current block/byte counter reporting is sufficient
2. for write operation, error-less BUSY assert/de-assert pairs shall be counted instead
Currently I only look at the last BUSY de-assert to verify that command is completed successfully.
As mmc_block always issues single block writes it is sufficient. If this will ever change, more
sophisticated scheme can be devised.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
