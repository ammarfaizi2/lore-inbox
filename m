Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933328AbWKNJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328AbWKNJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWKNJKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:10:24 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:55834 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S933316AbWKNJKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:10:22 -0500
Message-ID: <4559879D.8090105@sw.ru>
Date: Tue, 14 Nov 2006 12:08:45 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, devel@openvz.org
Subject: [Q] PCI Express and ide (native) leads to irq storm?
References: <453DC2A9.8000507@sw.ru> <453DC65C.8000408@sw.ru>	 <454206EE.9080206@sw.ru> <1161958862.16839.26.camel@localhost.localdomain>
In-Reply-To: <1161958862.16839.26.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-10-27 am 17:17 +0400, ysgrifennodd Vasily Averin:
>> Could somebody please help me to troubleshoot this issue? I've seen this issue
>> on the customer nodes and would like to know how I can work-around this issue
>> without any changes inside motherboard BIOS.
> 
> If its an IRQ routing triggered problem you probably can't, at least not
> the IDE error. The oops wants debugging further because it shouldn't
> have oopsed on that error merely given up.

Alan,
I've reproduced this issue on linux 2.6.19-rc5 kernel.

As far as I see if IDE controller is switched into native mode it shares irq
together with one of PCI Express Ports. It seems for me the last device is
guilty in this issue, becuase of it shares IDE irq on all the checked nodes.
and I do not know the ways to change their irq number or disable this device at all.

I means the following devices:

on Intel 915G-based nodes
0000:00:1c.2 Class 0604: 8086:2664 (rev 03)
0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 3 (rev 03)

on Intel E7520 node:
00:04.0 0604: 8086:3597 (rev 0a)
00:05.0 0604: 8086:3598 (rev 0a)
00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0a)
00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 0a)

I've checked Intel chipset spec updates but do not found any related issues.

Please see http://bugzilla.kernel.org/show_bug.cgi?id=7518 for details

thank you,
	Vasily Averin
