Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752137AbWICHlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbWICHlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 03:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWICHlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 03:41:04 -0400
Received: from web36707.mail.mud.yahoo.com ([209.191.85.41]:14419 "HELO
	web36707.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752137AbWICHlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 03:41:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hphRL9vrzYtIf6QYKPmRGAsnqAXT2Aq++qfdcMwAwN9ukMDJjanGSxge16v4IWJl6mb2ZTRduWmoCp318K0+tB2u6X+nL0jGLC9ItuSdaNzkxSBKSwobvEVikjRkK4n5dsByoAobMIMNdSv6AGTGMu8gKNpBpbfzAJmcP2X7irI=  ;
Message-ID: <20060903074101.77116.qmail@web36707.mail.mud.yahoo.com>
Date: Sun, 3 Sep 2006 00:41:01 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: drzeus-list@drzeus.cx
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44F967E8.9020503@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The constants you've borrowed from OMAP, have you
> confirmed all of them?
All the constants defined in tifm_sd.c are used in
accordance to OMAP datasheet with expected effect.
Constants that I've guessed mostly reside in the
tifm.h file and marked accordingly.

> tifm_sd_fetch_resp() could be redone as a for loop
> to make it more
> obvious what's going on.
I'm not sure it's a good idea. The response value is
returned in 8 16-bit registers, which are mapped over
8 32-bit registers (so that only LS part of each
register is valid). Additionally, the fetch order is
reversed, so cmd->resp[0] is fetched from offsets 24
and 28, while cmd->resp[3] is fetched from offsets 0
and 4. To write this as a loop requires moderately
complex address calculation that may look even less
obvious.

> 
> You should probably rename tifm_sd_set_data_to(). It
> isn't obvious that
> 'to' stands for 'timeout'. Same thing with other
> instances of 'to'.
I agree, yet I wanted to retain the names of the
registers as defined in datasheet (so it's easier to
search for them; for some reason it always abbreviates
timeout as TO). Apparently TI does the same in their
drivers.

> What I'd like to see from you is to double check
> that bytes_xfered is
> set to the number of bytes successfully sent to the
> _card_, not the
> controller. This is critical for correct handling of
> bus errors.
The OMAP datasheet is somewhat unclear, but I think
that block and byte counters truly represent the
amount of data shifted out to the mmc bus. Whether
this data really reaches the flash memory I don't know
to tell.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-- 
VGER BF report: U 0.499996
