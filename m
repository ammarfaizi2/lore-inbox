Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289201AbSAGOQk>; Mon, 7 Jan 2002 09:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSAGOQV>; Mon, 7 Jan 2002 09:16:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:62594 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289201AbSAGOQP>; Mon, 7 Jan 2002 09:16:15 -0500
Date: Mon, 7 Jan 2002 09:18:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: lseek() on an iso9660 file
Message-ID: <Pine.LNX.3.95.1020107091316.18091A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Using Linux 2.4.1 I discovered a problem with lseek on CDROM files
(iso9660). I just installed 2.4.17 and found the same problem.

The problem:

(1) A portion of the file, existing on a CDROM,  is read and its the
    contents are written to an output file on writable media.

(2) The current input file-position is obtained using
    pos = lseek(fd, 0, SEEK_CUR); The value returned is exactly
    the expected value.

(3) The rest of the CDROM file is read and written to the output file.

(4) The file-position of the CDROM file is then set back to the saved
    position using lseek(fd, pos, SEEK_SET); The value returned is
    exactly the expected value.

(5) The CDROM file is then read and its contents are observed to be
    scrambled in some strange manner in which word-length groups of
    bytes from near the end of the file are interleaved with the
    correct bytes. Basically, the file ends up being about twice
    as long as the original, with every-other two-byte interval
    being filled with bytes from near the end of the file.

If I mount the CDROM using the loop device, i.e.,

		mount -o loop /dev/cdrom /mnt

... the problem does not exist.

However, the performance is poor when mounting through the loop
device so this is not a good "fix". It takes about 5 minutes to
copy a 50 megabyte file from the CDROM through the loop device
while it normally takes about 50 seconds using the SCSI CDROM
directly.

If I am not supposed to use lseek() on a file existing on an
iso9660 file-system, how is an application to "know" that the
file is not lseek() capable? I need a "quick-fix". One at the
application-level is fine.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


