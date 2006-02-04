Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946099AbWBDKXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946099AbWBDKXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946102AbWBDKXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:23:47 -0500
Received: from host2092.kph.uni-mainz.de ([134.93.134.92]:9867 "EHLO
	a1i15.kph.uni-mainz.de") by vger.kernel.org with ESMTP
	id S1946099AbWBDKXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:23:47 -0500
From: Ulrich Mueller <ulm@kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17380.32919.359949.861318@a1i15.kph.uni-mainz.de>
Date: Sat, 4 Feb 2006 11:23:19 +0100
To: Mark Lord <lkml@rtr.ca>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
In-Reply-To: <43E3DB99.9020604@rtr.ca>
References: <20060110132957.GA28666@elte.hu>
	<20060110133728.GB3389@suse.de>
	<Pine.LNX.4.63.0601100840400.9511@winds.org>
	<20060110143931.GM3389@suse.de>
	<Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	<43C3E9C2.1000309@rtr.ca>
	<20060110173217.GU3389@suse.de>
	<43C3F0CA.10205@rtr.ca>
	<43C403BA.1050106@pobox.com>
	<43C40803.2000106@rtr.ca>
	<20060201222314.GA26081@MAIL.13thfloor.at>
	<uhd7irpi7@a1i15.kph.uni-mainz.de>
	<Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
	<43E3DB99.9020604@rtr.ca>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 03 Feb 2006, Mark Lord wrote:

>>> Hm, I wonder if we could have a more fine-grained choice of the
>>> boundary? There are also systems around with e.g. 1.25G or 1.5G of
>>> main memory.

>> Maybe something like:
>>	   config VMSPLIT_1G
>>		   bool "1G/3G user/kernel split"
>>	   config VMSPLIT_X
>>		   bool "Manual split"
>> endchoice
> ...

> Yes, that looks like a good idea.

Couldn't this still be implemented entirely in Kconfig, without
modifying page.h? Like in the following example:

	[...]
	config VMSPLIT_1G
		bool "1G/3G user/kernel split"
	config VMSPLIT_X
		bool "Manual split"
endchoice

config PAGE_OFFSET
	hex
	range 0x40000000 0xC0000000    
	prompt "Memory split address (must be aligned to 4096)" if VMSPLIT_X
	[...]
	default 0x40000000 if VMSPLIT_1G
	default 0xC0000000

Cheers
Uli
