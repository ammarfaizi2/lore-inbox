Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTJJXkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTJJXkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:40:55 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:51337
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263201AbTJJXkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:40:52 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: slab corruption of hpsb_packet from ohci1394 + sbp2 on 2.6.0-test7
Message-Id: <E1A86t4-0001rj-00@penngrove.fdns.net>
Date: Fri, 10 Oct 2003 16:41:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've also reproduced a problem noted by Alastair Tse in 2.6.0-test5-mm3
on a Sony R505EL laptop with 2.6.0-test7, as documented in Bugzilla at:

    http://bugzilla.kernel.org/show_bug.cgi?id=1258

For me, this has been a longstanding problem, with 2.4.19 being the only 
kernel that i've found which with i can write data CD's.  I can make this
happen by logging in as 'root' immediately after booting and request the
loading of 'ohci1394'.  About 3-10 seconds later, it fails as shown below:

    tvr-vaio:~# modprobe ohci1394
    ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
    ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[e0205000-e02057ff]  Max
Packet=[2048]
    tvr-vaio:~# sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
    scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
    ieee1394: sbp2: Logged into SBP-2 device
    Slab corruption: start=cd594718, expend=cd594777, problemat=cd594748
    Last user: [<d0b7314c>](free_hpsb_packet+0x2c/0x40 [ieee1394])
    Data: ************************************************D5 D6 D6 D6 01 00 00
00 ***************************************A5
    Next: 71 F0 2C .4C 31 B7 D0 71 F0 2C .....................
    slab error in check_poison_obj(): cache `hpsb_packet': object was modified
after freeing
    Call Trace:
     [<c013abfb>] check_poison_obj+0x10b/0x1a0
     [<c013ae3d>] slab_destroy+0x1ad/0x1c0
     [<c013d498>] reap_timer_fnc+0x148/0x220
     [<c013d350>] reap_timer_fnc+0x0/0x220
     [<c01225c0>] run_timer_softirq+0xb0/0x170
     [<c011e465>] do_softirq+0xa5/0xb0
     [<c010bd45>] do_IRQ+0xe5/0x120
     [<c010a35c>] common_interrupt+0x18/0x20
     [<c01bc0f6>] acpi_processor_idle+0xe8/0x1e3
     [<c0105000>] _stext+0x0/0x30
     [<c01080f4>] cpu_idle+0x34/0x40
     [<c0312765>] start_kernel+0x145/0x150
     [<c03124e0>] unknown_bootoption+0x0/0x110


    tvr-vaio:~# cat > /tmp/console.log

Details are also available via bugzilla, as noted above.  Here are quick 
links to my attachments therein:

    dmsg:	http://bugzilla.kernel.org/attachment.cgi?id=1023
    .config:	http://bugzilla.kernel.org/attachment.cgi?id=1024

(And yes, if you look carefully, you'll see i'm still trying to sort out
the forking of suspend to disk. *sigh*)

Any clues on how to track this problem down would be greatly appreciated!
(Please CC: such replies, as i'm reading via WWW rather than subscribing.)

			         -- JM
