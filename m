Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSEENRm>; Sun, 5 May 2002 09:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSEENRl>; Sun, 5 May 2002 09:17:41 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:38048 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S311885AbSEENRe>; Sun, 5 May 2002 09:17:34 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200205051317.g45DHIU0000750@twopit.underworld>
Subject: Linux 2.4.18 floppy driver EATS floppies
To: linux-kernel@vger.kernel.org, paul@paulbristow.net,
        chaffee@cs.berkeley.edu
Date: Sun, 5 May 2002 14:17:18 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am discovering that any floppy disks that I try to use under Linux
don't last very long. This seems to be true with both my UP and SMP 
machines, neither of which has ever used its floppy drive enough for
me to believe that the hardware is reaching the end of its life.

For example, today I tried to create some floppy disks from a DOS
image file. I was able to "dd" the original image without
problems. (It was the mini.ima file from the latest Matrox Unified
BIOS update, freely downloadable from Matrox for many months without
incident, which makes me suspect that there's nothing wrong with
it...)

The command I used on my 2.4.18 SMP machine was:

dd bs=1k if=mini.ima of=/dev/fd0

This worked OK, and I was able to mount the disk. Then I tried writing
another file to the disk and was told that the disk was full, which
was quite impossible. I then tried running "df" and received the
following output:

May  5 13:28:00 twopit kernel: inserting floppy driver for 2.4.18
May  5 13:28:00 twopit kernel: Floppy drive(s): fd0 is 1.44M
May  5 13:28:00 twopit kernel: FDC 0 is a post-1991 82077
May  5 13:28:00 twopit kernel: VFS: Disk change detected on device fd(2,0)
May  5 13:30:26 twopit kernel: VFS: Disk change detected on device fd(2,0)
May  5 13:32:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:32:37 twopit kernel: 2nd bread in fat_access failed
May  5 13:32:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:32:37 twopit kernel: 2nd bread in fat_access failed
May  5 13:32:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:38 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:32:38 twopit kernel: bread in fat_access failed
May  5 13:32:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:39 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:32:39 twopit kernel: bread in fat_access failed
May  5 13:32:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:32:40 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:32:40 twopit kernel: 2nd bread in fat_access failed
May  5 13:32:40 twopit kernel: Filesystem panic (dev 02:00).
May  5 13:32:40 twopit kernel:   File without EOF
May  5 13:32:40 twopit kernel:   File system has been set read-only
May  5 13:33:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:41 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:41 twopit kernel: 2nd bread in fat_access failed
May  5 13:33:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:42 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:42 twopit kernel: bread in fat_access failed
May  5 13:33:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:42 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:42 twopit kernel: bread in fat_access failed
May  5 13:33:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:43 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:43 twopit kernel: bread in fat_access failed
May  5 13:33:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:44 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:44 twopit kernel: bread in fat_access failed
May  5 13:33:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:45 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:45 twopit kernel: bread in fat_access failed
May  5 13:33:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:46 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:46 twopit kernel: bread in fat_access failed
May  5 13:33:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:46 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:46 twopit kernel: bread in fat_access failed
May  5 13:33:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:47 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:47 twopit kernel: bread in fat_access failed
May  5 13:33:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:48 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:48 twopit kernel: bread in fat_access failed
May  5 13:33:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:49 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:49 twopit kernel: bread in fat_access failed
May  5 13:33:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:50 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:50 twopit kernel: bread in fat_access failed
May  5 13:33:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:50 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:50 twopit kernel: bread in fat_access failed
May  5 13:33:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:51 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:51 twopit kernel: bread in fat_access failed
May  5 13:33:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:52 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:52 twopit kernel: bread in fat_access failed
May  5 13:33:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:53 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:53 twopit kernel: bread in fat_access failed
May  5 13:33:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:54 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:54 twopit kernel: bread in fat_access failed
May  5 13:33:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:54 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:54 twopit kernel: bread in fat_access failed
May  5 13:33:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:55 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:55 twopit kernel: bread in fat_access failed
May  5 13:33:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:56 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:56 twopit kernel: bread in fat_access failed
May  5 13:33:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:57 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:57 twopit kernel: bread in fat_access failed
May  5 13:33:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:58 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:58 twopit kernel: bread in fat_access failed
May  5 13:33:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:58 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:58 twopit kernel: bread in fat_access failed
May  5 13:33:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:33:59 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:33:59 twopit kernel: bread in fat_access failed
May  5 13:34:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:00 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:00 twopit kernel: bread in fat_access failed
May  5 13:34:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:01 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:01 twopit kernel: bread in fat_access failed
May  5 13:34:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:02 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:02 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:02 twopit kernel: bread in fat_access failed
May  5 13:34:02 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:02 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:02 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:02 twopit kernel: bread in fat_access failed
May  5 13:34:03 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:03 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:03 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:03 twopit kernel: bread in fat_access failed
May  5 13:34:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:04 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:04 twopit kernel: bread in fat_access failed
May  5 13:34:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:05 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:05 twopit kernel: bread in fat_access failed
May  5 13:34:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:06 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:06 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:06 twopit kernel: bread in fat_access failed
May  5 13:34:06 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:06 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:06 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:06 twopit kernel: bread in fat_access failed
May  5 13:34:07 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:07 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:07 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:07 twopit kernel: bread in fat_access failed
May  5 13:34:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:08 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:08 twopit kernel: bread in fat_access failed
May  5 13:34:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:09 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:09 twopit kernel: bread in fat_access failed
May  5 13:34:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:10 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:10 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:10 twopit kernel: bread in fat_access failed
May  5 13:34:10 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:10 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:10 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:10 twopit kernel: bread in fat_access failed
May  5 13:34:11 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:11 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:11 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:11 twopit kernel: bread in fat_access failed
May  5 13:34:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:12 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:12 twopit kernel: bread in fat_access failed
May  5 13:34:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:13 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:13 twopit kernel: bread in fat_access failed
May  5 13:34:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:14 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:14 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:14 twopit kernel: bread in fat_access failed
May  5 13:34:14 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:14 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:14 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:14 twopit kernel: bread in fat_access failed
May  5 13:34:15 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:15 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:15 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:15 twopit kernel: bread in fat_access failed
May  5 13:34:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:16 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:16 twopit kernel: bread in fat_access failed
May  5 13:34:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:17 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:17 twopit kernel: bread in fat_access failed
May  5 13:34:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:18 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:18 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:18 twopit kernel: bread in fat_access failed
May  5 13:34:18 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:18 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:18 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:18 twopit kernel: bread in fat_access failed
May  5 13:34:19 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:19 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:19 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:19 twopit kernel: bread in fat_access failed
May  5 13:34:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:20 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:20 twopit kernel: bread in fat_access failed
May  5 13:34:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:21 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:21 twopit kernel: bread in fat_access failed
May  5 13:34:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:22 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:22 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:22 twopit kernel: bread in fat_access failed
May  5 13:34:22 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:22 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:22 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:22 twopit kernel: bread in fat_access failed
May  5 13:34:23 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:23 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:23 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:23 twopit kernel: bread in fat_access failed
May  5 13:34:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:24 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:24 twopit kernel: bread in fat_access failed
May  5 13:34:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:25 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:25 twopit kernel: bread in fat_access failed
May  5 13:34:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:26 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:26 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:26 twopit kernel: bread in fat_access failed
May  5 13:34:26 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:26 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:26 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:26 twopit kernel: bread in fat_access failed
May  5 13:34:27 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:27 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:27 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:27 twopit kernel: bread in fat_access failed
May  5 13:34:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:28 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:28 twopit kernel: bread in fat_access failed
May  5 13:34:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:29 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:29 twopit kernel: bread in fat_access failed
May  5 13:34:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:30 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:30 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:30 twopit kernel: bread in fat_access failed
May  5 13:34:30 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:30 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:30 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:30 twopit kernel: bread in fat_access failed
May  5 13:34:31 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:31 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:31 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:31 twopit kernel: bread in fat_access failed
May  5 13:34:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:32 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:32 twopit kernel: bread in fat_access failed
May  5 13:34:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:33 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:33 twopit kernel: bread in fat_access failed
May  5 13:34:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:33 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:33 twopit kernel: bread in fat_access failed
May  5 13:34:34 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:34 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:34 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:34 twopit kernel: bread in fat_access failed
May  5 13:34:35 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:35 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:35 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:35 twopit kernel: bread in fat_access failed
May  5 13:34:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:36 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:36 twopit kernel: bread in fat_access failed
May  5 13:34:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:37 twopit kernel: bread in fat_access failed
May  5 13:34:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:37 twopit kernel: bread in fat_access failed
May  5 13:34:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:38 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:38 twopit kernel: bread in fat_access failed
May  5 13:34:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:39 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:39 twopit kernel: bread in fat_access failed
May  5 13:34:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:40 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:40 twopit kernel: bread in fat_access failed
May  5 13:34:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:41 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:41 twopit kernel: bread in fat_access failed
May  5 13:34:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:41 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:41 twopit kernel: bread in fat_access failed
May  5 13:34:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:42 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:42 twopit kernel: bread in fat_access failed
May  5 13:34:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:43 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:43 twopit kernel: bread in fat_access failed
May  5 13:34:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:44 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:44 twopit kernel: bread in fat_access failed
May  5 13:34:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:45 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:45 twopit kernel: bread in fat_access failed
May  5 13:34:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:45 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:45 twopit kernel: bread in fat_access failed
May  5 13:34:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:46 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:46 twopit kernel: bread in fat_access failed
May  5 13:34:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:47 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:47 twopit kernel: bread in fat_access failed
May  5 13:34:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:48 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:48 twopit kernel: bread in fat_access failed
May  5 13:34:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:49 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:49 twopit kernel: bread in fat_access failed
May  5 13:34:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:49 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:49 twopit kernel: bread in fat_access failed
May  5 13:34:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:50 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:50 twopit kernel: bread in fat_access failed
May  5 13:34:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:51 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:51 twopit kernel: bread in fat_access failed
May  5 13:34:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:52 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:52 twopit kernel: bread in fat_access failed
May  5 13:34:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:53 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:53 twopit kernel: bread in fat_access failed
May  5 13:34:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:53 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:53 twopit kernel: bread in fat_access failed
May  5 13:34:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:54 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:54 twopit kernel: bread in fat_access failed
May  5 13:34:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:55 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:55 twopit kernel: bread in fat_access failed
May  5 13:34:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:56 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:56 twopit kernel: bread in fat_access failed
May  5 13:34:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:57 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:57 twopit kernel: bread in fat_access failed
May  5 13:34:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:57 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:57 twopit kernel: bread in fat_access failed
May  5 13:34:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:58 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:58 twopit kernel: bread in fat_access failed
May  5 13:34:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:34:59 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:34:59 twopit kernel: bread in fat_access failed
May  5 13:35:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:00 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:00 twopit kernel: bread in fat_access failed
May  5 13:35:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:01 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:01 twopit kernel: bread in fat_access failed
May  5 13:35:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:01 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:01 twopit kernel: bread in fat_access failed
May  5 13:35:02 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:02 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:02 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:02 twopit kernel: bread in fat_access failed
May  5 13:35:03 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:03 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:03 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:03 twopit kernel: bread in fat_access failed
May  5 13:35:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:04 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:04 twopit kernel: bread in fat_access failed
May  5 13:35:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:05 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:05 twopit kernel: bread in fat_access failed
May  5 13:35:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:05 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:05 twopit kernel: bread in fat_access failed
May  5 13:35:06 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:06 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:06 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:06 twopit kernel: bread in fat_access failed
May  5 13:35:07 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:07 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:07 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:07 twopit kernel: bread in fat_access failed
May  5 13:35:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:08 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:08 twopit kernel: bread in fat_access failed
May  5 13:35:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:09 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:09 twopit kernel: bread in fat_access failed
May  5 13:35:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:09 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:09 twopit kernel: bread in fat_access failed
May  5 13:35:10 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:10 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:10 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:10 twopit kernel: bread in fat_access failed
May  5 13:35:11 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:11 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:11 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:11 twopit kernel: bread in fat_access failed
May  5 13:35:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:12 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:12 twopit kernel: bread in fat_access failed
May  5 13:35:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:13 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:13 twopit kernel: bread in fat_access failed
May  5 13:35:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:13 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:13 twopit kernel: bread in fat_access failed
May  5 13:35:14 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:14 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:14 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:14 twopit kernel: bread in fat_access failed
May  5 13:35:15 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:15 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:15 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:15 twopit kernel: bread in fat_access failed
May  5 13:35:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:16 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:16 twopit kernel: bread in fat_access failed
May  5 13:35:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:17 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:17 twopit kernel: bread in fat_access failed
May  5 13:35:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:17 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:17 twopit kernel: bread in fat_access failed
May  5 13:35:18 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:18 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:18 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:18 twopit kernel: bread in fat_access failed
May  5 13:35:19 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:19 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:19 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:19 twopit kernel: bread in fat_access failed
May  5 13:35:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:20 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:20 twopit kernel: bread in fat_access failed
May  5 13:35:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:21 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:21 twopit kernel: bread in fat_access failed
May  5 13:35:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:21 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:21 twopit kernel: bread in fat_access failed
May  5 13:35:22 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:22 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:22 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:22 twopit kernel: bread in fat_access failed
May  5 13:35:23 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:23 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:23 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:23 twopit kernel: bread in fat_access failed
May  5 13:35:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:24 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:24 twopit kernel: bread in fat_access failed
May  5 13:35:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:25 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:25 twopit kernel: bread in fat_access failed
May  5 13:35:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:25 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:25 twopit kernel: bread in fat_access failed
May  5 13:35:26 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:26 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:26 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:26 twopit kernel: bread in fat_access failed
May  5 13:35:27 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:27 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:27 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:27 twopit kernel: bread in fat_access failed
May  5 13:35:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:28 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:28 twopit kernel: bread in fat_access failed
May  5 13:35:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:29 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:29 twopit kernel: bread in fat_access failed
May  5 13:35:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:29 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:29 twopit kernel: bread in fat_access failed
May  5 13:35:30 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:30 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:30 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:30 twopit kernel: bread in fat_access failed
May  5 13:35:31 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:31 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:31 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:31 twopit kernel: bread in fat_access failed
May  5 13:35:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:32 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:32 twopit kernel: bread in fat_access failed
May  5 13:35:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:33 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:33 twopit kernel: bread in fat_access failed
May  5 13:35:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:33 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:33 twopit kernel: bread in fat_access failed
May  5 13:35:34 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:34 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:34 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:34 twopit kernel: bread in fat_access failed
May  5 13:35:35 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:35 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:35 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:35 twopit kernel: bread in fat_access failed
May  5 13:35:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:36 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:36 twopit kernel: bread in fat_access failed
May  5 13:35:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:37 twopit kernel: bread in fat_access failed
May  5 13:35:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:37 twopit kernel: bread in fat_access failed
May  5 13:35:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:38 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:38 twopit kernel: bread in fat_access failed
May  5 13:35:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:39 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:39 twopit kernel: bread in fat_access failed
May  5 13:35:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:40 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:40 twopit kernel: bread in fat_access failed
May  5 13:35:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:41 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:41 twopit kernel: bread in fat_access failed
May  5 13:35:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:41 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:41 twopit kernel: bread in fat_access failed
May  5 13:35:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:42 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:42 twopit kernel: bread in fat_access failed
May  5 13:35:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:43 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:43 twopit kernel: bread in fat_access failed
May  5 13:35:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:44 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:44 twopit kernel: bread in fat_access failed
May  5 13:35:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:45 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:45 twopit kernel: bread in fat_access failed
May  5 13:35:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:45 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:45 twopit kernel: bread in fat_access failed
May  5 13:35:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:46 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:46 twopit kernel: bread in fat_access failed
May  5 13:35:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:47 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:47 twopit kernel: bread in fat_access failed
May  5 13:35:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:48 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:48 twopit kernel: bread in fat_access failed
May  5 13:35:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:48 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:48 twopit kernel: bread in fat_access failed
May  5 13:35:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:49 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:49 twopit kernel: bread in fat_access failed
May  5 13:35:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:50 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:50 twopit kernel: bread in fat_access failed
May  5 13:35:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:51 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:51 twopit kernel: bread in fat_access failed
May  5 13:35:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:52 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:52 twopit kernel: bread in fat_access failed
May  5 13:35:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:52 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:52 twopit kernel: bread in fat_access failed
May  5 13:35:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:53 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:53 twopit kernel: bread in fat_access failed
May  5 13:35:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:54 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:54 twopit kernel: bread in fat_access failed
May  5 13:35:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:55 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:55 twopit kernel: bread in fat_access failed
May  5 13:35:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:56 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:56 twopit kernel: bread in fat_access failed
May  5 13:35:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:56 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:56 twopit kernel: bread in fat_access failed
May  5 13:35:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:57 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:57 twopit kernel: bread in fat_access failed
May  5 13:35:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:58 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:58 twopit kernel: bread in fat_access failed
May  5 13:35:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:35:59 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:35:59 twopit kernel: bread in fat_access failed
May  5 13:35:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:00 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:00 twopit kernel: bread in fat_access failed
May  5 13:36:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:00 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:00 twopit kernel: bread in fat_access failed
May  5 13:36:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:01 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:01 twopit kernel: bread in fat_access failed
May  5 13:36:02 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:02 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:02 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:02 twopit kernel: bread in fat_access failed
May  5 13:36:03 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:03 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:03 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:03 twopit kernel: bread in fat_access failed
May  5 13:36:03 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:04 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:04 twopit kernel: bread in fat_access failed
May  5 13:36:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:04 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:04 twopit kernel: bread in fat_access failed
May  5 13:36:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:05 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:05 twopit kernel: bread in fat_access failed
May  5 13:36:06 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:06 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:06 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:06 twopit kernel: bread in fat_access failed
May  5 13:36:07 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:07 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:07 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:07 twopit kernel: bread in fat_access failed
May  5 13:36:07 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:08 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:08 twopit kernel: bread in fat_access failed
May  5 13:36:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:08 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:08 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:08 twopit kernel: bread in fat_access failed
May  5 13:36:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:09 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:09 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:09 twopit kernel: bread in fat_access failed
May  5 13:36:10 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:10 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:10 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:10 twopit kernel: bread in fat_access failed
May  5 13:36:11 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:11 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:11 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:11 twopit kernel: bread in fat_access failed
May  5 13:36:11 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:12 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:12 twopit kernel: bread in fat_access failed
May  5 13:36:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:12 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:12 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:12 twopit kernel: bread in fat_access failed
May  5 13:36:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:13 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:13 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:13 twopit kernel: bread in fat_access failed
May  5 13:36:14 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:14 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:14 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:14 twopit kernel: bread in fat_access failed
May  5 13:36:15 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:15 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:15 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:15 twopit kernel: bread in fat_access failed
May  5 13:36:15 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:16 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:16 twopit kernel: bread in fat_access failed
May  5 13:36:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:16 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:16 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:16 twopit kernel: bread in fat_access failed
May  5 13:36:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:17 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:17 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:17 twopit kernel: bread in fat_access failed
May  5 13:36:18 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:18 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:18 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:18 twopit kernel: bread in fat_access failed
May  5 13:36:19 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:19 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:19 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:19 twopit kernel: bread in fat_access failed
May  5 13:36:19 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:20 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:20 twopit kernel: bread in fat_access failed
May  5 13:36:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:20 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:20 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:20 twopit kernel: bread in fat_access failed
May  5 13:36:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:21 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:21 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:21 twopit kernel: bread in fat_access failed
May  5 13:36:22 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:22 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:22 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:22 twopit kernel: bread in fat_access failed
May  5 13:36:23 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:23 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:23 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:23 twopit kernel: bread in fat_access failed
May  5 13:36:23 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:24 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:24 twopit kernel: bread in fat_access failed
May  5 13:36:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:24 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:24 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:24 twopit kernel: bread in fat_access failed
May  5 13:36:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:25 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:25 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:25 twopit kernel: bread in fat_access failed
May  5 13:36:26 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:26 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:26 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:26 twopit kernel: bread in fat_access failed
May  5 13:36:27 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:27 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:27 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:27 twopit kernel: bread in fat_access failed
May  5 13:36:27 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:28 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:28 twopit kernel: bread in fat_access failed
May  5 13:36:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:28 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:28 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:28 twopit kernel: bread in fat_access failed
May  5 13:36:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:29 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:29 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:29 twopit kernel: bread in fat_access failed
May  5 13:36:30 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:30 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:30 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:30 twopit kernel: bread in fat_access failed
May  5 13:36:31 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:31 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:31 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:31 twopit kernel: bread in fat_access failed
May  5 13:36:31 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:32 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:32 twopit kernel: bread in fat_access failed
May  5 13:36:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:32 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:32 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:32 twopit kernel: bread in fat_access failed
May  5 13:36:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:33 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:33 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:33 twopit kernel: bread in fat_access failed
May  5 13:36:34 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:34 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:34 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:34 twopit kernel: bread in fat_access failed
May  5 13:36:35 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:35 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:35 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:35 twopit kernel: bread in fat_access failed
May  5 13:36:35 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:36 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:36 twopit kernel: bread in fat_access failed
May  5 13:36:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:36 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:36 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:36 twopit kernel: bread in fat_access failed
May  5 13:36:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:37 twopit kernel: bread in fat_access failed
May  5 13:36:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:38 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:38 twopit kernel: bread in fat_access failed
May  5 13:36:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:39 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:39 twopit kernel: bread in fat_access failed
May  5 13:36:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:40 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:40 twopit kernel: bread in fat_access failed
May  5 13:36:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:40 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:40 twopit kernel: bread in fat_access failed
May  5 13:36:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:41 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:41 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:41 twopit kernel: bread in fat_access failed
May  5 13:36:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:42 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:42 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:42 twopit kernel: bread in fat_access failed
May  5 13:36:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:43 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:43 twopit kernel: bread in fat_access failed
May  5 13:36:43 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:44 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:44 twopit kernel: bread in fat_access failed
May  5 13:36:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:44 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:44 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:44 twopit kernel: bread in fat_access failed
May  5 13:36:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:45 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:45 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:45 twopit kernel: bread in fat_access failed
May  5 13:36:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:46 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:46 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:46 twopit kernel: bread in fat_access failed
May  5 13:36:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:47 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:47 twopit kernel: bread in fat_access failed
May  5 13:36:47 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:48 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:48 twopit kernel: bread in fat_access failed
May  5 13:36:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:48 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:48 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:48 twopit kernel: bread in fat_access failed
May  5 13:36:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:49 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:49 twopit kernel: bread in fat_access failed
May  5 13:36:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:50 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:50 twopit kernel: bread in fat_access failed
May  5 13:36:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:51 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:51 twopit kernel: bread in fat_access failed
May  5 13:36:51 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:52 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:52 twopit kernel: bread in fat_access failed
May  5 13:36:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:52 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:52 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:52 twopit kernel: bread in fat_access failed
May  5 13:36:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:53 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:53 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:53 twopit kernel: bread in fat_access failed
May  5 13:36:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:54 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:54 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:54 twopit kernel: bread in fat_access failed
May  5 13:36:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:55 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:55 twopit kernel: bread in fat_access failed
May  5 13:36:55 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:56 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:56 twopit kernel: bread in fat_access failed
May  5 13:36:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:56 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:56 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:56 twopit kernel: bread in fat_access failed
May  5 13:36:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:57 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:57 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:57 twopit kernel: bread in fat_access failed
May  5 13:36:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:58 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:58 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:58 twopit kernel: bread in fat_access failed
May  5 13:36:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:36:59 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:36:59 twopit kernel: bread in fat_access failed
May  5 13:36:59 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:37:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:37:00 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:37:00 twopit kernel: bread in fat_access failed
May  5 13:37:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:37:00 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:37:00 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:37:00 twopit kernel: bread in fat_access failed
May  5 13:37:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:37:01 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:37:01 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:37:01 twopit kernel: bread in fat_access failed

I was unable to kill the df process and so had to reboot the
machine. The floppy is now unusable; I tried to re-dd the image using
the command:

dd if=mini.ima of=/dev/fd0

but was told:

May  5 13:55:03 twopit kernel: VFS: Disk change detected on device fd(2,0)
May  5 13:55:04 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:55:05 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:55:05 twopit kernel: end_request: I/O error, dev 02:00
(floppy), sector 5

I was similarly unable to create a new VFAT filesystem:

# mkfs -t vfat /dev/fd0
mkfs.vfat 0.4.1, 1st September 1998 for MS-DOS/FAT/FAT32 FS


May  5 13:55:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:55:49 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:55:49 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
May  5 13:55:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:55:50 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
May  5 13:55:50 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5

This does NOT bode well for the creation of bootdisks or disks for
other firmware updates.

Does anyone have any ideas what going wrong?

Cheers,
Chris

