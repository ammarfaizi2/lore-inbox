Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268176AbUHFP5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268176AbUHFP5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268161AbUHFPt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:49:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15247 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268147AbUHFPlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:41:11 -0400
Message-ID: <4113A684.8050302@pobox.com>
Date: Fri, 06 Aug 2004 11:40:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Paul Jakma <paul@clubi.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org> <1091795565.16307.14.camel@localhost.localdomain>
In-Reply-To: <1091795565.16307.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-08-06 at 11:29, Paul Jakma wrote:
> 
>>scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 02 05 d0 06 00 00 10 00
>>Current sda: sense key Medium Error
> 
> 
> Disk error
> 
> 
>>Additional sense: Unrecovered read error - auto reallocate failed
> 
> 
> Bad block, and sufficiently bad that it couldn't then recover the block
> and rewrite it. When a drive sees a marginal read (lot of forward error
> correction recovery needed) it will try and rewrite or move the block.
> 
> In this case it couldn't read the block enough to move it.


Unfortunately, in libata all it means at this point is
(a) the error occurred on a read command, and
(b) we did not attempt to retry the command

So, a generic non-specific error you see on all errors.

libata does not (yet) retry cable errors, for example.  Paul, don't 
automatically assume the disk is bad, try swapping cables.

	Jeff


