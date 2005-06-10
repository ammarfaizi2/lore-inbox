Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVFJOBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVFJOBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVFJOBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:01:20 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:14009 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262525AbVFJOAx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:00:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TYwfsdibRGcpWCNGHBdsy6YG94HzszaGj20atRlJdBtPvF5qHcn3WcBGzVKQS3tNPz2LbwO3OKAx4w3/u/A0Mg7ZTPaILf9AgPMtFV028t54stduasc7AUFZXp72qyvXiff7OCvpbkRaF4trIOpH+0e4kRagvm7SLh3MQHsPhLY=
Message-ID: <a728f9f90506100700107976f0@mail.gmail.com>
Date: Fri, 10 Jun 2005 10:00:51 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: jfs-discussion@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fsck.jfs segfaults on x86_64
Cc: ag@m-cam.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a large lvm2 logical volume (6.91T) which contains a JFS
filesystem. The volumes accessed via emulex FC HBAs connected to a
nexsan SAN.  There was a bug in the SAN firmware that caused the
primary controller to lose sync with the other controller and go down.
 Normally when this happens we are able to reboot the SAN and the
server and then run fsck on the volume, and everything is fine (on a
side note, we have updated the SAN firmware to fix the sync problem). 
however, fsck now segfaults and the volume is dirty so it can't be
mounted. lvdisplay and vgdisplay seem to work fine displaying the
correct info.  Does anyone know what may be causing the problem or how
we can fix it?  If possible I'd like to save the data on the volumes.

#> time fsck.jfs /dev/vg00/lvol0 
fsck.jfs version 1.1.4, 30-Oct-2003
processing started: 6/8/2005 18.1.19
Using default parameter: -p
The current device is:  /dev/vg00/lvol0
Block size in bytes:  4096
Filesystem size in blocks:  1855561728
**Phase 0 - Replay Journal Log
Segmentation fault

real    1m40.396s
user    0m0.038s
sys     0m0.297s

strace:

<snip>
lseek(3, 7600357904384, SEEK_SET)       = 7600357904384
read(3, "8h\36\0\0\0t\17\0\206\1\0\0\0\0\0\0\10\204\0\0\0\0\0\1"...,
4096) = 4096
lseek(3, 4679075332096, SEEK_SET)       = 4679075332096
read(3, "\301\v\201B\20\0\0\0
\357\20\0\336\\\24\0\4\0\0\0\370\351"..., 4096) = 4096
lseek(3, 4677018386432, SEEK_SET)       = 4677018386432
read(3, "\0\0\0D\0\0\0\0\16\1\0\0\377\377\377\377\377\377\377\377"...,
4096) = 4096
lseek(3, 7600347168768, SEEK_SET)       = 7600347168768
write(3, "D\0LOGREDO:  Allocating for IMap:"..., 8192) = 8192
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

/var/log/messages
Jun  8 17:34:11 nutcracker fsck.jfs[12223]: segfault at 0000000000000490 rip
00000000004178f1 rsp 00007fffff996f40 error 6

mount /mnt/san
mount: wrong fs type, bad option, bad superblock on /dev/vg00/lvol0,
       or too many mounted file systems

Additional info:

Linux nutcracker 2.6.12-rc6 #1 SMP Wed Jun 8 16:46:17 EDT 2005 x86_64 AMD
Opteron(tm) Processor 244 AuthenticAMD GNU/Linux

That's the only kernel version (2.6.12) that has support for a fiber channel
Emulex card (lpfc).

Thanks in advance for any help or advice.

Alex
