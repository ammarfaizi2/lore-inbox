Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbTFVTCj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbTFVTCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:02:39 -0400
Received: from mail.consultit.no ([213.239.74.125]:45748 "EHLO
	kosat.consultit.no") by vger.kernel.org with ESMTP id S265811AbTFVTCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:02:23 -0400
Date: Sun, 22 Jun 2003 21:16:27 +0200
From: Eivind Tagseth <eivindt@multinet.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030622191626.GA1811@tagseth-trd.consultit.no>
References: <20030620081846.GB2451@tagseth-trd.consultit.no> <20030620211640.B913@flint.arm.linux.org.uk> <20030622114642.GB1785@tagseth-trd.consultit.no> <20030622141541.B16537@flint.arm.linux.org.uk> <20030622182838.GA6970@tagseth-trd.consultit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622182838.GA6970@tagseth-trd.consultit.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eivind Tagseth <eivindt@multinet.no> [030622 20:31]:
> * Russell King <rmk@arm.linux.org.uk> [030622 15:18]:
> > There appears to be something of an inconsistency in the naming (again)
> > for ide-cs.  This should fix it.
> 
> Much better.  At least I think so:
> 
> Jun 22 20:22:19 [kernel] kobject_register failed for hdc1 (-17)
> Jun 22 20:22:19 [kernel] Call Trace:

Actually, rebooting and retrying, it works:


Jun 22 20:52:37 [cardmgr] initializing socket 1
Jun 22 20:52:37 [kernel] cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jun 22 20:52:37 [cardmgr] socket 1: ATA/IDE Fixed Disk
Jun 22 20:52:37 [cardmgr] product info: "SanDisk", "SDP", "5/3 0.6"
Jun 22 20:52:37 [cardmgr] manfid: 0x0045, 0x0401  function: 4 (fixed disk)
Jun 22 20:52:37 [cardmgr] executing: 'modprobe ide-cs'
Jun 22 20:52:40 [kernel] hdc: SanDisk SDCFB-32, CFA DISK drive
Jun 22 20:52:40 [kernel] hdc: max request size: 128KiB
Jun 22 20:52:40 [kernel]  /dev/ide/host1/bus0/target0/lun0: p1
Jun 22 20:52:40 [kernel] Module ide_cs cannot be unloaded due to unsafe usage in
 include/linux/module.h:479
Jun 22 20:52:40 [cardmgr] executing: './ide start hdc'
Jun 22 20:52:40 [cardmgr] + mknod /dev/hdc b 22 0
Jun 22 20:52:40 [cardmgr] + mknod: `/dev/hdc': File exists
Jun 22 20:52:40 [cardmgr] + mknod /dev/hdc1 b 22 1
Jun 22 20:52:40 [cardmgr] + mknod: `/dev/hdc1': File exists
Jun 22 20:52:40 [cardmgr] + mknod /dev/hdc2 b 22 2
Jun 22 20:52:40 [cardmgr] + mknod /dev/hdc3 b 22 3
.
.
.
Jun 22 20:52:40 [cardmgr] + mknod /dev/hdc16 b 22 16


However, removing the card causes a kernel panic, and everything completely
freezes.  This also happened with 2.5.69, so it's not caused by a recent
change.

If I'm not _supposed_ to be able to remove the card, or if I'm doing it
the wrong way, please let me know... 

I'm unable to see the top of the panic, and I'm too lazy to type
it all down, but here's what I did see:

try_to_wake_up
default_wake_function
ide_release
update_process_times
ide_release
run_timer
do_timer
do_softirq
do_IRQ
common_interrupt
sys_ipc
apm_bios_call_simple
apm_do_idle
apm_cpu_idle
apm_cpu_idle
default_idle
cpu_idle
_stext
start_kernel
unknown_bootoption

Code: 0f 0b 4b 02 3f fd 31 c0 e9 a6 f7 ff ff 8d 74 26 00 55 31 d2
<0>Kernel panic: Fatal exception in interrupt


(beware of typos).

If providing all the info helps you, I'll do it.  I have no idea what I can
do to read the whole message though.



Eivind
