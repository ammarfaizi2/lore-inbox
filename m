Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVL0JaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVL0JaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 04:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVL0JaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 04:30:15 -0500
Received: from main.gmane.org ([80.91.229.2]:39138 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932278AbVL0JaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 04:30:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Help track down a freezing machine, libata?
Date: Tue, 27 Dec 2005 18:30:06 +0900
Message-ID: <dor1is$9bo$1@sea.gmane.org>
References: <dnp4t9$srl$1@sea.gmane.org> <81b0412b0512140625i7cc5779ar224de3d64c615fbc@mail.gmail.com> <dnuutm$v10$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
In-Reply-To: <dnuutm$v10$1@sea.gmane.org>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Alex Riesen wrote:
> 
>>On 12/14/05, Kalin KOZHUHAROV <kalin@thinrope.net> wrote:
>>
>>
>>>Now that I get a repetitive freeze, is there anything to debug the problem?
>>>I guess, the point when kernel is still responsive to keyboard, but I cannot login.
>>
>>
>>try to connect a serial console to it and press Alt+SysRq+t
> 
> 
> Thank you for the suggestio, Alex.
> 
> I was always trying to avoid the serial console till now (it just seems difficult, and I DO know it
> is not), and didn't even bother with the netconsole...

It is, I as have to go and buy a null modem cable... will do it.

> So until now, here is an oops, the first I saw in a few months, captured by my camera and then
> digitally enhanced: http://linux.tar.bz/reports/oopses/char/2.6.14.3-K01_char__oops1.jpg
> 
> The OCRed/handwritten text ( http://linux.tar.bz/reports/oopses/char/2.6.14.3-K01_char__oops1.txt )
> says:
> 
> Call trace:
> SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
> SCSI device sda: drive cache: write back
> [<c01ec22f>] kobject_put+0x1f/0x30
> [<c028c8fd>] scsi_end_request+0xdd/0xf0
> [<c028ccae>] scsi_io_completion+0x26e/0x570
> [<c011b623>] load_balance_newidle+0x43/0x110
> [<c028d255>] scsi_generic_done+0x35/0x50
> [<c02873ee>] scsi_finish_command+0x8e/0xd0
> [<c0318dea>] schedule+0x4da/0xd50
> [<c0318e1d>] schedule+0x50d/0xd50
> [<c028728f>] scsi_sortirq+0xdf/0x160
> [<c0125836>] __do_softirq+0xd6/0xf0
> [<c0125885>] do_softirq+0x35/0x40
> [<c0125e35>] ksoftirqd+0x95/0xe0
> [<c0125da0>] ksoftirqd+0x0/0xe0
> [<c0135b9a>] kthread+0xba/0xc0
> [<c0135ae0>] kthread+0x0/0xc0
> [<c0101245>] kernel_thread_helper+0x5/0x10
> Code: e1 08 00 89 44 24 04 89 1c 24 e8 27 b0 ff ff eb a5 90 8d 74 26 00 55 57 56
>  53 83 ec 08 8b 44 24 1c 89 44 24 04 8b 80 ec 00 00 00 <8b> 38 f6 80 79 01 00 00
>  80 0f 85 98 00 00 00 8b 47 2c 8d 6f 20
> <0>Kernel panic - not syncing: Fatal exception in interrupt
> 
> Unfortunately everything was frozen (KBD too), so I couldn't scroll up to see the beginning. As you
> may guess, it was not written to the disk.
> 
> The oops happened on boot (after a hard power-off) and is probbably related to the SATA system.

All right, the above started to be reproducible, about once every 3 boots: the system freezes when
tries to initialize the ata sybsystem. (still don't have cable for the serial console, sorry)

> The .config is available at http://linux.tar.bz/reports/oopses/char/2.6.14.3-K01_char.config

Now this is 2.6.14.4 and the new config is:
http://linux.tar.bz/reports/oopses/char/2.6.14.4-K01_char.config

I added another 250GB SATA HDD and changed the PSU, but it does not seem to be related for that bug.
Will try to tweak the IDE parameters in BIOS.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

