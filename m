Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135246AbRDZJec>; Thu, 26 Apr 2001 05:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135251AbRDZJeX>; Thu, 26 Apr 2001 05:34:23 -0400
Received: from sh-home.de ([212.60.1.17]:56080 "HELO sh-home.de")
	by vger.kernel.org with SMTP id <S135246AbRDZJeF>;
	Thu, 26 Apr 2001 05:34:05 -0400
Message-ID: <3AE7EB3D.3C9DA6A0@enter.de>
Date: Thu, 26 Apr 2001 11:32:45 +0200
From: Christian Knoke <ChrisK@enter.de>
Organization: Pretty Good Privacy
X-Mailer: Mozilla 4.74 [de] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Remounting write-protected floppy
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SHLINK: Mail autoscanned by SHLINK-VirusScan
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is this a bug or am I missing something? I'm
not at all a kernel hacker.

1. Remounting write-protected floppy

2. It is possible to remount a write-protected,
   read-only mounted floppy disk as read-writeable,
   and write and remove files on it. The result
   is weird, depends on what you're doing

3. floppy, mount, filesystem, VFS

4. Kernel: 2.2.19 and 2.2.18 (unpatched)
   mount 2.10m (NFS patched, and unpatched originating SuSE 7.0)

5. Kernel warnings: (a lot)
   Apr 26 10:25:07 max kernel: floppy0: Drive is write protected
   Apr 26 10:25:07 max kernel: end_request: I/O error, dev 02:00\
   (floppy), sector 82

6. Procedure:
-------------------------------------------------------------------
Using an ext2-formatted, write-protected HD (1.44) floppy:

max:~ # mount /dev/fd0 /floppy -t ext2
mount: block device /dev/fd0 is write-protected, mounting read-only
max:~ # mount /dev/fd0 /floppy -t ext2 -o remount,rw
max:~ # ls -l /floppy
total 765
drwxr-xr-x   3 root     root         1024 Apr 26 08:35 .
drwxr-xr-x  20 root     root         4096 Jan 16 23:42 ..
-rw-r--r--   1 root     root       761016 Apr 26 08:35 bzImage
drwxr-xr-x   2 root     root        12288 Apr 26 08:33 lost+found
max:~ # echo empty > /floppy/bzImage
max:~ # ls -l /floppy
total 18
drwxr-xr-x   3 root     root         1024 Apr 26 08:35 .
drwxr-xr-x  20 root     root         4096 Jan 16 23:42 ..
-rw-r--r--   1 root     root            6 Apr 26 10:57 bzImage
drwxr-xr-x   2 root     root        12288 Apr 26 08:33 lost+found
max:~ # cat /floppy/bzImage
¸À?Ø¸max:~ # 

The last command sometimes writes "empty" instead of the old
content of bzImage as above.
-------------------------------------------------------------------

7. Environment
-------------------------------------------------------------------
Linux max 2.2.18 #2 Sun Mar 4 13:56:26 CET 2001 i586 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root    \
  4070534 Sep  5  2000 /lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         snd-seq-midi snd-seq-midi-event\
 snd-seq snd-card-cs4232 isapnp snd-mpu401-uart snd-rawmidi\
 snd-seq-device snd-cs4231 snd-mixer snd-pcm snd-opl3\
 snd-hwdep snd-timer snd
-------------------------------------------------------------------

Regards,

Christian

P.S.: If you answer, please CC: me, I'm not on the list.

-- 
* Christian Knoke                           +49 4852 92248 *
* D-25541 Brunsbuettel                  Wurtleutetweute 49 *
* * * * * * * * *  Ceterum censeo Microsoft esse dividendum.

