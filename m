Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267489AbUHPJan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267489AbUHPJan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUHPJan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:30:43 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:23696 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S267489AbUHPJal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:30:41 -0400
From: Hubert Tonneau <hubert.tonneau@heliogroup.fr>
To: linux-kernel@vger.kernel.org
Subject: USB storage crash report in 2.6
Date: Mon, 16 Aug 2004 09:11:48 GMT
Message-ID: <04BQXJO12@server5.heliogroup.fr>
X-Mailer: Pliant 92
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to copy large amount of datas (more than 100 GB) between USB
attached disks, I get a crash with Linux 2.6

Here are the extra details I can provide:

At crash time, the machine completely freezes, so I can only report what I can
see on the screen, mainly the stack trace report:
scan_async
ehci_watchlog
ehci_work
ehci_watchlog
run_timer_softirq
__do_softirq
do_softirq
smp_apic_timer_interrupt
apic_timer_interrupt
default_idle
call_console_driver
printk

The machine is running a Dell sx270 (P4 hyperthreading) running Linux 2.6.8.1

What I do is try to copy roughly 60 GB from disk sdc to sda (EXT3 to EXT3),
and then another 60 GB from sdc to sdb
The crash appends after copying roughly 100 GB.
It can be reproduced.
I had no problem when I first copied from sda to sdc and sdb to sdc (it was
XFS to EXT3).

I tried the following, without success:
. downgrade to 2.6.7
. desable kernel preempting
. change target filesystem from EXT3 to EXT2 then to XFS

What did success is downgrade to 2.4.27

Anyway, I got no crash on all our various machines running 2.6.6 and 2.6.7,
including some busy ones, unless some USB device is attached (once reading
a deffective DVD, and this time copying between USB disks).

Just in case, I also remember that I also had a server repetingly freezing
in early 2.6, and it was related to a bad cable generating tiny error on the
SCSI bus (MTP fusion controler) and it was properly handled by 2.4, not by 2.6
so the problem might be related to handling tiny problems in the SCSI layer
as well (assuming it was not an MTP fusion driver problem).

