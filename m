Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTJITeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJITeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:34:46 -0400
Received: from flock1.newmail.ru ([212.48.140.157]:17082 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S262418AbTJITej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:34:39 -0400
From: Sinelnikov Evgeny <linux4sin@mail.ru>
Organization: Saratov State University
Date: Thu, 9 Oct 2003 23:39:04 +0400
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Subject: PROBLEM: 2.6.0-test5: ioctl.h: _IOC_TYPECHECK: Is it a bug?
To: linux-kernel@vger.kernel.org
Message-Id: <200310090253.01449.sin@info.sgu.ru>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I have problem with linux-utils.2.12 compile on 2.6.0-test5 headers. From this 
version instead 2.6.0-test4 was changed next file where added next string:

include/asm-i386/ioctl.h:
#define _IOC_TYPECHECK(t) \
        ((sizeof(t) == sizeof(t[1]) && \
          sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
          sizeof(t) : __invalid_size_argument_for_IOC)

This string have problems with compiling files using _IOR macros from ioctl.h
Here is example from util-linux-2.12:
#define BLKBSZGET  _IOR(0x12,112,sizeof(int))
ioctl (fd, BLKBSZGET, &bsz) == 0
After precompiling looking like this:
ioctl (fd, (((2U) << (((0 +8)+8)+14)) | (((0x12)) << (0 +8)) | (((112)) << 0) 
| (((((sizeof(sizeof(int)) == size
of(sizeof(int)[1]) && sizeof(sizeof(int)) < (1 << 14)) ? sizeof(sizeof(int)) : 
__invalid_size_argument_for_IOC))) << ((0 +8)
+8))), &bsz) == 0

Is it a bug or new feature? May be this is a bug of package?

PS:
Output of scripts/ver_linux on native ALT Linux:
lfs@localhost src]$ [lfs@localhost linux-2.6.0]$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.20-alt7-up #1 Fri Mar 14 14:57:05 MSK 2003 
i686 unknown unknown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.25
e2fsprogs              1.32
reiserfsprogs          3.6.4
pcmcia-cs              3.2.4
quota-tools            3.09.
PPP                    2.4.2b3
nfs-utils              1.0.3
Linux C Library        2.2.6
Dynamic linker (ldd)   2.2.6
Procps                 2.0.10
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         sr_mod ide-scsi ide-cd scsi_mod cdrom ppp_deflate 
zlib_inflate zlib_deflate bsd_comp ppp_async ppp_generic slhc appletalk ipx 
nvidia autofs4 snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer 
snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore 
floppy serial isa-pnp ntfs nls_koi8-r nls_cp866 vfat fat ext3 jbd ext2 rtc 
reiserfs


Output of scripts/ver_linux on chrooted LFS, where compiled util-linux-2.12 
where was the problem:
root:/usr/src/linux-2.6.0$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.20-alt7-up #1 Fri Mar 14 14:57:05 MSK 2003 
i686 GenuineIntel unknown GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
scripts/ver_linux: line 27: fdformat: command not found
mount                  2.12
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         sr_mod ide-scsi ide-cd scsi_mod cdrom ppp_deflate 
zlib_inflate zlib_deflate bsd_comp ppp_async ppp_generic slhc appletalk ipx 
nvidia autofs4 snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer 
snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore 
floppy serial isa-pnp ntfs nls_koi8-r nls_cp866 vfat fat ext3 jbd ext2 rtc 
reiserfs

test.sh:
tar -xzf util-linux-2.12.tar.gz &&
cd util-linux-2.12 &&
./configure &&
make

Sinelnikov Evgeny

