Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTKFH6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 02:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTKFH6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 02:58:37 -0500
Received: from dhcp065-024-082-073.columbus.rr.com ([65.24.82.73]:41736 "EHLO
	www.cencula.com") by vger.kernel.org with ESMTP id S263408AbTKFH6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 02:58:30 -0500
From: "Michael D. Cencula" <junk3@cencula.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: mounting UDF CDs (from Sony Mavica Camera)
Date: Thu, 6 Nov 2003 02:58:23 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311060258.23652.junk3@cencula.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Basically, the problem is that mounting these udf CDs only works after a 
failed vfat (or msdos) mount attempt.  Following a successful udf mount 
attempt, the CD can be umounted and re-mounted without problem until it is 
ejected and reinserted.  Then it's necessary to try a vfat mount again before 
the udf mount succeeds.

This workaround of trying vfat then udf only seems to work in a CDRW drive.  
Normal CDROM drives give a "mount: No medium found" error.  However, if I 
finalize the disc, it becomes an iso9660 filesystem, and I can mount it just 
fine regardless of whether I'm using a CDRW or plain old CDROM drive.

Using RH9.0 with a (nearly) stock .config used to compile 2.4.22 for an Athlon 
T-bird 1Ghz on a Gigabyte GA-7ZXR v.2.2 motherboard with 512MB PC133.

Here's an example of the problem:

[root@mike root]# mount -t udf /dev/scd0 /mnt/cdrom
mount: block device /dev/scd0 is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/scd0,
       or too many mounted file systems
[root@mike root]# mount -t vfat /dev/scd0 /mnt/cdrom
mount: block device /dev/scd0 is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/scd0,
       or too many mounted file systems
[root@mike root]# mount -t udf /dev/scd0 /mnt/cdrom
mount: block device /dev/scd0 is write-protected, mounting read-only
[root@mike root]#


Output from /var/log/messages shows a bunch of error lines for the initial udf 
mount attempt, two error lines for the failed vfat mount attempt, and finally 
the successful udf mount attempt:

Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=34, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=1100, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=588, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=476, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=1096, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=584, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=472, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=800, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=288, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=176, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=796, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=284, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=172, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=904, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=392, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=280, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=900, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=388, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=276, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=604, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=92, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=600, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=88, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=626, limit=2
Nov  6 00:35:09 mike kernel: attempt to access beyond end of device
Nov  6 00:35:09 mike kernel: 0b:00: rw=0, want=514, limit=2
Nov  6 00:35:09 mike kernel: UDF-fs: No partition found (1)
Nov  6 00:35:12 mike kernel:  I/O error: dev 0b:00, sector 0
Nov  6 00:35:12 mike kernel: FAT: unable to read boot sector
Nov  6 00:35:18 mike kernel:  I/O error: dev 0b:00, sector 64
Nov  6 00:35:18 mike kernel: UDF-fs INFO UDF 0.9.6-rw (2002/03/11) Mounting 
volume 'MV_20031015', timestamp 2003/10/15 18:23 (1ed4)

Here's output from the ver_linux script:

[root@mike root]# . /usr/src/linux-2.4/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mike 2.4.22 #4 Wed Oct 8 00:22:39 EDT 2003 i686 athlon i386 GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         vfat fat udf lp nfs lockd sunrpc tuner tvaudio bttv 
btaudio i2c-algo-bit videodev i2c-core snd-pcm-oss snd-mixer-oss snd-ens1371 
snd-pcm snd-page-alloc snd-timer snd-rawmidi snd-seq-device gameport 
snd-ac97-codec snd soundcore autofs parport_pc plip parport iptable_filter 
ip_tables 3c59x sg sr_mod ide-scsi scsi_mod ide-cd cdrom loop lvm-mod keybdev 
mousedev input hid uhci usbcore reiserfs


Please let me know if more information is necessary.  Also, please cc: me with 
any responses as I'm not a LKML subscriber.

Thanks for your attention,

Mike

P.S. I'd be happy to mail a CD to anyone that's interested in reproducing the 
problem.  I tried using dd to create an image that could be downloaded, but dd 
wouldn't copy the image.
