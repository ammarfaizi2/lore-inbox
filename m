Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWFXPxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWFXPxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWFXPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:53:21 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:422 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750846AbWFXPxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:53:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
Date: Sat, 24 Jun 2006 17:53:44 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060624061914.202fbfb5.akpm@osdl.org>
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606241753.44937.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 June 2006 15:19, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/

The box seems to work, although I have some "interesting" stuff in dmesg:

int3: 0000 [1] PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:0a.0/0000:02:00.0/subsystem_device
CPU 0
Modules linked in: acpi_cpufreq usbserial asus_acpi thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_seq snd_seqd
Pid: 4839, comm: modprobe Not tainted 2.6.17-mm2 #4
RIP: 0010:[<ffffffff806b0401>] <ffffffff806b0401>{cpufreq_register_driver+1}
RSP: 0018:ffff810052c59e40  EFLAGS: 00000292
RAX: 00000000ffffffea RBX: ffffffff8832a340 RCX: 00000000ffffffff
RDX: ffff8100567e3810 RSI: ffffffff883092cf RDI: ffffffff8832a2a0
RBP: ffff810052c59e48 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8100545f4de0
R13: ffffffff8832a340 R14: ffffc20000af49b0 R15: ffff8100545f53a0
FS:  00002ae4d623db00(0000) GS:ffffffff80689000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000051a680 CR3: 0000000054243000 CR4: 00000000000006e0
Process modprobe (pid: 4839, threadinfo ffff810052c58000, task ffff8100567e3810)
Stack: ffffffff880c808f ffff810052c59f78 ffffffff8024f14a ffffffff8832a390
       ffffffff8832a358 ffffffff8830e340 ffffc20000af4970 ffffc20000af43b0
       ffffc20000af4930 ffff8100531a5490
Call Trace: [<ffff810052c59f78>]

Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
RIP <ffffffff806b0401>{cpufreq_register_driver+1} RSP <ffff810052c59e40>
 <6>note: modprobe[4839] exited with preempt_count 1
eth0: no IPv6 routers present
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Slab corruption: start=ffff810041e09810, len=1936
060: 81 20 71 93 90 90 90 50 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=ffff810041e09080, len=1936
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=ffff810042e86080, len=1936
060: 3d d4 14 92 90 90 90 50 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff810042e86810, len=1936
000: 01 00 00 00 00 00 00 00 00 e0 3a 4a 00 81 ff ff
010: 02 00 00 00 00 00 00 00 40 20 40 00 00 00 00 00

and later, after a resume from disk:

drivers/usb/core/inode.c: creating file '003'
Slab corruption: start=ffff810041e05040, len=1936
060: cf f5 5f 9c 90 90 90 50 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff810041e057d0, len=1936
000: 01 00 00 00 00 00 00 00 00 00 4f 3c 00 81 ff ff
010: 02 00 00 00 00 00 00 00 00 01 40 00 00 00 00 00
Slab corruption: start=ffff810041e09080, len=1936
060: 7f 4f 01 95 90 90 90 50 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff810041e09810, len=1936
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=ffff810042e86810, len=1936
060: 68 06 7f 9c 90 90 90 50 6b 6b 6b 6b 6b 6b 6b 6b
090: 6b 6b 6b 6b 6b 6b 6b 6b 01 00 00 00 6b 6b 6b 6b
Prev obj: start=ffff810042e86080, len=1936
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

Greetings,
Rafael
