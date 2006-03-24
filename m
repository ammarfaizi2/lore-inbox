Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWCXWBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWCXWBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWCXWBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:01:06 -0500
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:12210 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S1751469AbWCXWBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:01:05 -0500
Message-ID: <44246C0E.3080306@cogweb.net>
Date: Fri, 24 Mar 2006 14:00:46 -0800
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [2.6.16] saa7134 disable_ir oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.16 mainline, I get an oops when inserting the saa7134 module with 
the option "disable_ir=1", whether for a single card or several.

Gigabyte K8NS Ultra-939, LifeView FlyVideo-3000FM NTSC, athlon64 x2 
3800+, Debian sid. All four cards work great otherwise. The new 
saa7134-alsa does not appear to be involved in the oops.

Issued:

sudo modprobe saa7134 card=2,2,2,2 tuner=43,43,43,43 video_nr=1,2,3,4
vbi_nr=1,2,3,4 radio_nr=1,2,3,4 alsa=1,1,1,1 disable_ir=1,1,1,1
sudo modprobe saa7134-alsa index=1,2,3,4

Got in dmesg:

Unable to handle kernel NULL pointer dereference at 0000000000000260 RIP:
<ffffffff880d5a95>{:saa7134:saa7134_initdev+1452}
PGD 3e607067 PUD 3b0b6067 PMD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in: saa7134 video_buf compat_ioctl32 v4l2_common
v4l1_compat ir_kbd_i2c ir_common videodev xfs exportfs snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore sk98lin
snd_page_alloc psmouse pcspkr evdev parport_pc parport ehci_hcd
i2c_nforce2 ohci_hcd i2c_core unix
Pid: 7134, comm: modprobe Not tainted 2.6.16 #1
RIP: 0010:[<ffffffff880d5a95>]
<ffffffff880d5a95>{:saa7134:saa7134_initdev+1452}
RSP: 0018:ffff810036fd3de8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81003cb84000 RCX: 000000000000083f
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff81003cb84000
RBP: 0000000000000000 R08: ffff81003cb84aa8 R09: ffffffff880ee496
R10: ffff810008030000 R11: ffff810008030000 R12: ffff81003cb84158
R13: ffff81003ff12000 R14: 0000000000000000 R15: 0000000000000003
FS:  00002b96383df6d0(0000) GS:ffffffff803ee000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000260 CR3: 000000003d86d000 CR4: 00000000000006e0
Process modprobe (pid: 7134, threadinfo ffff810036fd2000, task
ffff810001f149f0)
Stack: ffff81003ff12070 0000000100000001 ffff81003ff12070 ffffffff880e8460
       ffff81003ff12000 ffffffff880ee7c0 0000000000000000 ffffffff801d860c
       ffffffff8036c6c8 ffff81003ff12070
Call Trace: <ffffffff801d860c>{pci_device_probe+221}
       <ffffffff8022db0d>{driver_probe_device+82}
<ffffffff8022dbc2>{__driver_attach+0}
       <ffffffff8022dc18>{__driver_attach+86}
<ffffffff8022d142>{bus_for_each_dev+67}
       <ffffffff8022d442>{bus_add_driver+116}
<ffffffff801d8182>{__pci_register_driver+128}
       <ffffffff80141655>{sys_init_module+240}
<ffffffff8010a82a>{system_call+126}

Code: 8b 96 60 02 00 00 89 d0 25 00 00 01 00 85 c0 75 20 81 e2 00
RIP <ffffffff880d5a95>{:saa7134:saa7134_initdev+1452} RSP <ffff810036fd3de8>
CR2: 0000000000000260

Dave

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
