Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUCIPPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUCIPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:15:45 -0500
Received: from mout1.freenet.de ([194.97.50.132]:58604 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261991AbUCIPPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:15:22 -0500
Message-ID: <404DDF99.3080408@gmx.net>
Date: Tue, 09 Mar 2004 16:15:37 +0100
From: Otto Meier <gf435@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031028 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dl2k driver in 2.6.4
Content-Type: multipart/mixed;
 boundary="------------000103040706070107030802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000103040706070107030802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The kernel driver has release Nr. 1.17a. On the dlink ftp server
exists a newer release 1.18b. which has a modified TX Path.

I need this because the 1.17a version stops working under heavy load the
1.18b version works under 2.4

Unfortuatly it is for kernel 2.4. But by good luck the attached diff against
kernel 2.6.4-rc2 is compilable. when loaded it spit out a lot of  
messages like
this:
Mar  9 15:12:07 gate2 kernel: handlers:
Mar  9 15:12:07 gate2 kernel: [__crc_dev_getfirstbyhwtype+78192/2170958] 
(rio_interrupt+0x0/0x110 [dl2k])
Mar  9 15:12:07 gate2 kernel: [<e13b0460>] (rio_interrupt+0x0/0x110 [dl2k])
Mar  9 15:12:07 gate2 kernel: irq event 16: bogus return value 1388
Mar  9 15:12:07 gate2 kernel: Call Trace:
Mar  9 15:12:07 gate2 kernel:  [__report_bad_irq+42/144] 
__report_bad_irq+0x2a/0x90
Mar  9 15:12:07 gate2 kernel:  [<c010acea>] __report_bad_irq+0x2a/0x90
Mar  9 15:12:07 gate2 kernel:  [note_interrupt+131/192] 
note_interrupt+0x83/0xc0
Mar  9 15:12:07 gate2 kernel:  [<c010adf3>] note_interrupt+0x83/0xc0
Mar  9 15:12:07 gate2 kernel:  [do_IRQ+278/320] do_IRQ+0x116/0x140
Mar  9 15:12:07 gate2 kernel:  [<c010b0b6>] do_IRQ+0x116/0x140
Mar  9 15:12:07 gate2 kernel:  [rest_init+0/80] _stext+0x0/0x50
Mar  9 15:12:07 gate2 kernel:  [<c0103000>] _stext+0x0/0x50
Mar  9 15:12:07 gate2 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Mar  9 15:12:07 gate2 kernel:  [<c032922c>] common_interrupt+0x18/0x20
Mar  9 15:12:07 gate2 kernel:  [default_idle+0/64] default_idle+0x0/0x40
Mar  9 15:12:07 gate2 kernel:  [<c0107030>] default_idle+0x0/0x40
Mar  9 15:12:07 gate2 kernel:  [rest_init+0/80] _stext+0x0/0x50
Mar  9 15:12:07 gate2 kernel:  [<c0103000>] _stext+0x0/0x50
Mar  9 15:12:07 gate2 kernel:  [default_idle+44/64] default_idle+0x2c/0x40
Mar  9 15:12:07 gate2 kernel:  [<c010705c>] default_idle+0x2c/0x40
Mar  9 15:12:07 gate2 kernel:  [cpu_idle+52/80] cpu_idle+0x34/0x50
Mar  9 15:12:07 gate2 kernel:  [<c01070e4>] cpu_idle+0x34/0x50
Mar  9 15:12:07 gate2 kernel:  [start_kernel+451/528] 
start_kernel+0x1c3/0x210
Mar  9 15:12:07 gate2 kernel:  [<c0408973>] start_kernel+0x1c3/0x210
Mar  9 15:12:07 gate2 kernel:  [unknown_bootoption+0/304] 
unknown_bootoption+0x0/0x130
Mar  9 15:12:07 gate2 kernel:  [<c0408480>] unknown_bootoption+0x0/0x130
Mar  9 15:12:07 gate2 kernel:
Mar  9 15:12:07 gate2 kernel: handlers:
Mar  9 15:12:07 gate2 kernel: [__crc_dev_getfirstbyhwtype+78192/2170958] 
(rio_interrupt+0x0/0x110 [dl2k])
Mar  9 15:12:07 gate2 kernel: [<e13b0460>] (rio_interrupt+0x0/0x110 
[dl2k])Mar  9 15:32:13 gate2 kernel: irq event 16: bogus return value 1388
Mar  9 15:12:08 gate2 kernel: eth0: Link up
Mar  9 15:12:08 gate2 kernel: Auto 1000 Mbps, Full duplex
Mar  9 15:12:08 gate2 kernel: Enable Tx Flow Control
Mar  9 15:12:08 gate2 kernel: Enable Rx Flow Control

but it starts working

after a while it stops to operate with following messages:

Mar  9 15:32:13 gate2 kernel: irq event 16: bogus return value 1388
Mar  9 15:32:13 gate2 kernel: Call Trace:
Mar  9 15:32:13 gate2 kernel:  [__report_bad_irq+42/144] 
__report_bad_irq+0x2a/0x90
Mar  9 15:32:13 gate2 kernel:  [<c010acea>] __report_bad_irq+0x2a/0x90
Mar  9 15:32:13 gate2 kernel:  [note_interrupt+149/192] 
note_interrupt+0x95/0xc0
Mar  9 15:32:13 gate2 kernel:  [<c010ae05>] note_interrupt+0x95/0xc0
Mar  9 15:32:13 gate2 kernel:  [do_IRQ+278/320] do_IRQ+0x116/0x140
Mar  9 15:32:13 gate2 kernel:  [<c010b0b6>] do_IRQ+0x116/0x140
Mar  9 15:32:13 gate2 kernel:  [rest_init+0/80] _stext+0x0/0x50
Mar  9 15:32:13 gate2 kernel:  [<c0103000>] _stext+0x0/0x50
Mar  9 15:32:13 gate2 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Mar  9 15:32:13 gate2 kernel:  [<c032922c>] common_interrupt+0x18/0x20
Mar  9 15:32:13 gate2 kernel:  [default_idle+0/64] default_idle+0x0/0x40
Mar  9 15:32:13 gate2 kernel:  [<c0107030>] default_idle+0x0/0x40
Mar  9 15:32:13 gate2 kernel:  [rest_init+0/80] _stext+0x0/0x50
Mar  9 15:32:13 gate2 kernel:  [<c0103000>] _stext+0x0/0x50
Mar  9 15:32:13 gate2 kernel:  [default_idle+44/64] default_idle+0x2c/0x40
Mar  9 15:32:13 gate2 kernel:  [<c010705c>] default_idle+0x2c/0x40
Mar  9 15:32:13 gate2 kernel:  [cpu_idle+52/80] cpu_idle+0x34/0x50
Mar  9 15:32:13 gate2 kernel:  [<c01070e4>] cpu_idle+0x34/0x50
Mar  9 15:32:13 gate2 kernel:  [start_kernel+451/528] 
start_kernel+0x1c3/0x210
Mar  9 15:32:13 gate2 kernel:  [<c0408973>] start_kernel+0x1c3/0x210
Mar  9 15:32:13 gate2 kernel:  [unknown_bootoption+0/304] 
unknown_bootoption+0x0/0x130
Mar  9 15:32:13 gate2 kernel:  [<c0408480>] unknown_bootoption+0x0/0x130
Mar  9 15:32:13 gate2 kernel:
Mar  9 15:32:13 gate2 kernel: handlers:
Mar  9 15:32:13 gate2 kernel: [__crc_dev_getfirstbyhwtype+78192/2170958] 
(rio_interrupt+0x0/0x110 [dl2k])
Mar  9 15:32:13 gate2 kernel: [<e13b0460>] (rio_interrupt+0x0/0x110 [dl2k])
Mar  9 15:32:13 gate2 kernel: Disabling IRQ #16

I have not the skills to migrate the 1.18b version to kernel 2.6. It 
would be very nice if someone
could review the patch and give the needed guidance.




--------------000103040706070107030802
Content-Type: application/x-gunzip;
 name="dl-1.18b.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dl-1.18b.diff.gz"

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
--------------000103040706070107030802--
