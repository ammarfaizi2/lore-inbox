Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSEXWQN>; Fri, 24 May 2002 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSEXWQM>; Fri, 24 May 2002 18:16:12 -0400
Received: from jalon.able.es ([212.97.163.2]:38363 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S311025AbSEXWQK>;
	Fri, 24 May 2002 18:16:10 -0400
Date: Sat, 25 May 2002 00:16:05 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: floppy broken in 2.4.19-pre8
Message-ID: <20020524221605.GA1756@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Since some pres ago (do not remember exactly when), using the floppy leads
my box to a total hang. Finally I decided to get some info on it.

For 2.4.19-pre8 (plan pre, no line of code touched), when I try to mount
a floppy (msdos format), the system just hangs. Same happens when trying
to do an fdisk, or a mkfs. Mounting -oloop anso blocks. I got no error
trying with -t ext2, so the mount command does not even reach the point
to check if the filesystem is what I requested.

/etc/fstab:
/dev/fd0 /mnt/floppy msdos user,noauto 0 0

If I eject manually the floppy, while the light is on:

May 24 23:47:00 werewolf kernel: floppy0: disk removed during i/o
May 24 23:47:00 werewolf kernel: end_request: I/O error, dev 02:00 (floppy), sector 0
May 24 23:47:00 werewolf last message repeated 2 times
May 24 23:47:00 werewolf kernel: floppy0: disk absent or changed during operation
May 24 23:47:00 werewolf kernel: end_request: I/O error, dev 02:00 (floppy), sector 0
May 24 23:47:00 werewolf kernel: FAT: unable to read boot sector
May 24 23:47:00 werewolf kernel: end_request: I/O error, dev 02:00 (floppy), sector 0

Output of 'strace mount /dev/fd0':

mount("/dev/fd0", "/mnt/floppy", "msdos",
MS_NOSUID|MS_NODEV|MS_NOEXEC|0xc0ed0000, 0x805eee0) = -1 ENOSYS (Function not
implemented)
(repeated several times)

SysRQ-P, the part I can think it has any relation, decoded:

Proc;  mount

>>EIP; 00000012 Before first symbol   <=====

Trace; c0143e3e <__wait_on_buffer+6e/a0>
Trace; c01afed1 <floppy_revalidate+1e1/230>
Trace; c014a11e <check_disk_change+8e/a0>
Trace; c01af9d0 <floppy_open+260/440>
Trace; c014a303 <do_open+163/1a0>
Trace; c014a3b8 <blkdev_get+78/90>
Trace; c0149de4 <bd_acquire+54/c0>
Trace; c0148b03 <get_sb_bdev+e3/290>
Trace; c0148208 <get_fs_type+98/b0>
Trace; e09ad7a0 <[msdos]msdos_fs_type+0/1b>
Trace; c0148f61 <do_kern_mount+121/140>
Trace; e09ad7a0 <[msdos]msdos_fs_type+0/1b>
Trace; c015d433 <do_add_mount+93/190>
Trace; c015d760 <do_mount+160/1c0>
Trace; c015d5a9 <copy_mount_options+79/d0>
Trace; c015dc5f <sys_mount+df/140>
Trace; c0109477 <tracesys+1f/23>

Any idea ?? Nobody else has errors ? Is it my hardware ?

Hard (from dmesg):

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #1 SMP vie may 24 18:09:39 CEST 2002 i686
