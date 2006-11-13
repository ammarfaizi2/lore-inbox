Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754899AbWKMPPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbWKMPPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbWKMPPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:15:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:63112 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754899AbWKMPPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:15:05 -0500
Message-ID: <45588BF0.3000100@garzik.org>
Date: Mon, 13 Nov 2006 10:14:56 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Paul Fulghum <paulkf@microgate.com>
CC: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, khc@pm.waw.pl,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de> <4558860B.8090908@garzik.org> <45588895.7010501@microgate.com>
In-Reply-To: <45588895.7010501@microgate.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> Jeff Garzik wrote:
>> Toralf Förster wrote:
>>
>>> Hello,
>>>
>>> the build with the attached .config failed, make ends with:
>>> ... UPD     include/linux/compile.h
>>>   CC      init/version.o
>>>   LD      init/built-in.o
>>>   LD      .tmp_vmlinux1
>>> drivers/built-in.o: In function `hdlcdev_open':
>>> synclink.c:(.text+0x650d5): undefined reference to `hdlc_open'
>>> synclink.c:(.text+0x6510d): undefined reference to `hdlc_open'
>>> ...
>>> synclink_cs.c:(.text+0x7aece): undefined reference to `hdlc_ioctl'
>>> drivers/built-in.o: In function `hdlcdev_init':
>>> synclink_cs.c:(.text+0x7b336): undefined reference to `alloc_hdlcdev'
>>> drivers/built-in.o: In function `hdlcdev_exit':
>>> synclink_cs.c:(.text+0x7b434): undefined reference to 
>>> `unregister_hdlc_device'
>>> make: *** [.tmp_vmlinux1] Error 1
>>
>>
>> Does this patch work for you?
>>
>>     Jeff
> 
> No, this patch is not acceptable.
> 
> This has been beaten to death in previous threads.
> The problem is a mismatch in your kernel config between
> generic hdlc (M) and synclink (Y).
> 
> synclink drivers can *optionally* support generic hdlc.
> You *must* be able to build synclink driver without generic hdlc.
> Because of this you *can't* just put in the generic hdlc dependency.
> 
> Several alternative patches were posted (3 or 4 months) ago.
> No particular patch won the approval of all kernel developers,
> so nothing was done.


The existing build breakage is unacceptable too.  It's this bogosity

	#ifdef CONFIG_HDLC_MODULE
	#define CONFIG_HDLC 1
	#endif

which directly causes the build breakage.

Unless someone fixes it The Right Way, my patch seems like the best we 
can do.  People who complain "you must be able to build without hdlc" 
should step up and make it so.  Currently, it is not so.

	Jeff


