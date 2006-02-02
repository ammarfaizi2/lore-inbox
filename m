Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWBBUzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBBUzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWBBUzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:55:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1480 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932240AbWBBUzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:55:54 -0500
Date: Thu, 2 Feb 2006 21:55:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ulrich Mueller <ulm@kph.uni-mainz.de>
cc: Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
In-Reply-To: <uhd7irpi7@a1i15.kph.uni-mainz.de>
Message-ID: <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de>
 <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de>
 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca>
 <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com>
 <43C40803.2000106@rtr.ca> <20060201222314.GA26081@MAIL.13thfloor.at>
 <uhd7irpi7@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> glad to see that the linux kernel is now ready for the 'idea'
>> I submitted a patch[1] for, more than a year ago -- which
>> unfortunately went unnoticed back then ...

BTW, I patched my local 2.6.16-rc1 with that patch and I run off 
VMSPLIT_3G_OPT quite well without problems. (Well, VMware gets it wrong, as 
usual, but nothing that I could not solved.) Even though I do not even have 
1 G but just 768 ;-)

This sort of testing reminds me of Linus's 100->1000 Hz change
("I chose 1000 originally partly as a way to make sure that people that
    assumed HZ was 100 would get a swift kick in the pants.")

Could we also do that with VMSPLIT?
("Let's choose VMSPLIT_2G to make sure that i386-people that assumed
PAGE_OFFSET was 0xC0000000 would get...")

>Hm, I wonder if we could have a more fine-grained choice of the
>boundary? There are also systems around with e.g. 1.25G or 1.5G of
>main memory.
>

Maybe something like:

        config VMSPLIT_1G
                bool "1G/3G user/kernel split"
        config VMSPLIT_X
                bool "Manual split"
endchoice

config VMSPLIT_MANUAL
    depends on VMSPLIT_X
    hex
    default 0xC0000000
    prompt "Memory split address (must be aligned to 4096)"


And in include/asm/page.h:

	#ifdef CONFIG_VMSPLIT_MANUAL
	#define __PAGE_OFFSET ((unsigned long)CONFIG_VMSPLIT_MANUAL)
	#else
	#define __PAGE_OFFSET ((unsigned long)CONFIG_PAGE_OFFSET)
	#endif

Not perfect, but a start.



Jan Engelhardt
-- 
