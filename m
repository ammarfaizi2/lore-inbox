Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132125AbQKZC43>; Sat, 25 Nov 2000 21:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132110AbQKZC4T>; Sat, 25 Nov 2000 21:56:19 -0500
Received: from www.hr.vc-graz.ac.at ([193.171.240.3]:45066 "EHLO
        www.hr.vc-graz.ac.at") by vger.kernel.org with ESMTP
        id <S131959AbQKZC4K>; Sat, 25 Nov 2000 21:56:10 -0500
Message-ID: <3A2074CC.8219AB99@fl.priv.at>
Date: Sun, 26 Nov 2000 03:26:20 +0100
From: Friedrich Lobenstock <fl@fl.priv.at>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [BUG] 2.4.0-test11-ac3 breaks raid autodetect (was Re: [BUG] raid5 link 
 error? (was [PATCH] raid5 fix after xor.c cleanup))
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl>
                <20001118123536.A5674@spaans.ds9a.nl>
                <20001118235352.D2226@spaans.ds9a.nl> <14872.29479.901021.472890@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
>
> The following patch changes the link order in the Makefile so that xor
> is initiailised before md tries to autostart anything.
> It also takes the theme a bit further and uses module_init/module_exit
> to init and shutdown the raid personalities.  This allows us to remove
> the explicit calls to raidXX_init from md.c, which is nice.
> 
> I have tested this patch both
>    1/ monolithic kernel and autodetecting an array
>    2/ md and all personalities modules
> 
> and it works fine.

Sorry to tell you that I just tried linux-2.4.0-test11-ac3 (which has this
patch) and I couldn't boot because the kernel detects the raid1 devices
but kicks the shortly after. I had to back out this code.

Here how the messages look like:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa400-0xa407,0xa002 on irq 9
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63, UDMA(33)
hdc: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63, UDMA(33)
hde: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
Partition check:
 hda: hda1 hda2
 hdc: hdc1 hdc2 hdc3
 hde: hde1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
LVM version 0.8final  by Heinz Mauelshagen  (15/02/2000)
lvm -- Driver successfully initialized
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 640k freed
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
(read) hda1's sb offset: 51264 [events: 00000056]
(read) hda2's sb offset: 9970560 [events: 00000051]
(read) hde1's sb offset: 29316544 [events: 00000080]
autorun ...
considering hde1 ...
  adding hde1 ...
created md2
bind<hde1,1>
running: <hde1>
now!
hde1's event counter: 00000080
md: device name has changed from [dev 22:01] to hde1 since last import!
md2: former device hde1 is unavailable, removing from array!
request_module[md-personality-3]: Root fs not mounted
do_md_run() returned -22
md2 stopped.
unbind<hde1,0>
export_rdev(hde1)
considering hda2 ...
  adding hda2 ...
created md1
bind<hda2,1>
running: <hda2>
now!
hda2's event counter: 00000051
md1: former device hdc2 is unavailable, removing from array!
request_module[md-personality-3]: Root fs not mounted
do_md_run() returned -22
md1 stopped.
unbind<hda2,0>
export_rdev(hda2)
considering hda1 ...
  adding hda1 ...
created md0
bind<hda1,1>
running: <hda1>
now!
hda1's event counter: 00000056
md0: former device hdc1 is unavailable, removing from array!
request_module[md-personality-3]: Root fs not mounted
do_md_run() returned -22
md0 stopped.
unbind<hda1,0>
export_rdev(hda1)
... autorun DONE.
raid1 personality registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=3


MfG / Regards
Friedrich Lobenstock
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
