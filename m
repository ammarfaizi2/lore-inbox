Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVACXJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVACXJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVACXJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:09:19 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:14408 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261940AbVACXH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:07:27 -0500
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
From: Mark_H_Johnson@raytheon.com
Subject: Re: 2.6.10-mm1
Date: Mon, 3 Jan 2005 17:07:08 -0600
Message-ID: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/03/2005 05:07:09 PM
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking to compare RT latency between this kernel and the latest from
Ingo and I had the following warnings / errors building 2.6.10-mm1:

[no apparent compile / link errors]
*** Warning: "snd_ac97_restore_iec958" [sound/pci/ac97/snd-ac97-codec.ko]
undefined!
*** Warning: "snd_ac97_restore_status" [sound/pci/ac97/snd-ac97-codec.ko]
undefined!
*** Warning: "del_mtd_partitions" [drivers/mtd/maps/scx200_docflash.ko]
undefined!
*** Warning: "add_mtd_partitions" [drivers/mtd/maps/scx200_docflash.ko]
undefined!
...
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/var/tmp/kernel-2.6.10mm1-root -r 2.6.10-mm1; fi
WARNING: /var/tmp/kernel-2.6.10
mm1-root/lib/modules/2.6.10-mm1/kernel/sound/pci/ac97/snd-ac97-codec.ko
needs unknown sy
mbol snd_ac97_restore_status
WARNING: /var/tmp/kernel-2.6.10
mm1-root/lib/modules/2.6.10-mm1/kernel/sound/pci/ac97/snd-ac97-codec.ko
needs unknown sy
mbol snd_ac97_restore_iec958
WARNING: /var/tmp/kernel-2.6.10
mm1-root/lib/modules/2.6.10-mm1/kernel/drivers/mtd/maps/scx200_docflash.ko
needs unknown
 symbol del_mtd_partitions
WARNING: /var/tmp/kernel-2.6.10
mm1-root/lib/modules/2.6.10-mm1/kernel/drivers/mtd/maps/scx200_docflash.ko
needs unknown
 symbol add_mtd_partitions
...

The following messages after rebooting...

...
Jan  3 16:42:00 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_status
Jan  3 16:42:00 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_iec958
Jan  3 16:42:00 dws77 modprobe: WARNING: Error inserting snd_ac97_codec
(/lib/modules/2.6.10-mm1/kernel/sound/pci/ac97/
snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see
dmesg)
Jan  3 16:42:01 dws77 modprobe: FATAL: Error inserting snd_ens1371
(/lib/modules/2.6.10-mm1/kernel/sound/pci/snd-ens137
1.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_mixer
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_bus
Jan  3 16:42:01 dws77 modprobe: WARNING: Error inserting snd_ac97_codec
(/lib/modules/2.6.10-mm1/kernel/sound/pci/ac97/
snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see
dmesg)
Jan  3 16:42:01 dws77 modprobe: FATAL: Error inserting snd_ens1371
(/lib/modules/2.6.10-mm1/kernel/sound/pci/snd-ens137
1.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jan  3 16:42:01 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_status
Jan  3 16:42:01 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_iec958
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_mixer
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_bus
Jan  3 16:42:01 dws77 modprobe: WARNING: Error inserting snd_ac97_codec
(/lib/modules/2.6.10-mm1/kernel/sound/pci/ac97/
snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see
dmesg)
Jan  3 16:42:01 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_status
Jan  3 16:42:01 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_iec958
Jan  3 16:42:01 dws77 modprobe: FATAL: Error inserting snd_ens1371
(/lib/modules/2.6.10-mm1/kernel/sound/pci/snd-ens137
1.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_mixer
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_bus
Jan  3 16:42:01 dws77 modprobe: WARNING: Error inserting snd_ac97_codec
(/lib/modules/2.6.10-mm1/kernel/sound/pci/ac97/
snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see
dmesg)
Jan  3 16:42:01 dws77 modprobe: FATAL: Error inserting snd_ens1371
(/lib/modules/2.6.10-mm1/kernel/sound/pci/snd-ens137
1.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jan  3 16:42:01 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_status
Jan  3 16:42:01 dws77 kernel: snd_ac97_codec: Unknown symbol
snd_ac97_restore_iec958
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_mixer
Jan  3 16:42:01 dws77 kernel: snd_ens1371: Unknown symbol snd_ac97_bus
...

and in dmesg, the following repeated a few times:
snd_ac97_codec: Unknown symbol snd_ac97_restore_status
snd_ac97_codec: Unknown symbol snd_ac97_restore_iec958
snd_ens1371: Unknown symbol snd_ac97_mixer
snd_ens1371: Unknown symbol snd_ac97_bus

At this point, the system fails to work with my sound card.
The .config is basically the same as used previously with
2.6.10-rc3-mm1-V0.7.33-04 (Ingo's realtime patches) without problems.
[though I expected & saw plenty of unused symbols when I did
make mrproper / xconfig for 2.6.10-mm1]

To fix this, should I just add the EXPORT_SYMBOL lines for these symbols
  snd_ac97_restore_status  snd_ac97_restore_iec958
or is something more needed?

Thanks.
  --Mark Johnson <mailto:Mark_H_Johnson@Raytheon.com>

