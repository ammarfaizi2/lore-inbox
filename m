Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSIBFWy>; Mon, 2 Sep 2002 01:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSIBFWy>; Mon, 2 Sep 2002 01:22:54 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:6667 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S315200AbSIBFWx>; Mon, 2 Sep 2002 01:22:53 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200209020527.g825RHd07114@sprite.physics.adelaide.edu.au>
Subject: Linux 2.4.18: short dd read from IDE cdrom
To: linux-kernel@vger.kernel.org
Date: Mon, 2 Sep 2002 14:57:17 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

For a number of years now I have duplicated cds using
  dd if=/dev/cdrom of=foo.iso
  cdrecord ... foo.iso

Here, /dev/cdrom is a symlink to an IDE CDROM (usually /dev/hdc).  This has
worked on all versions of Linux I have used to date, up to 2.2.19.

Today I tried the same trick under 2.4.18 and struck a problem: the kernel
would not read the complete CD image.  The CD I was testing this with was
64016 sectors long (1 sector = 2048 bytes): when mounted, df reported a size
of 128032 blocks and the image size created by mkisofs was 64016 extends. 
However, the above dd command would *only* read 63972 sectors - 44 sectors
at the end of the disk were unread.  If the disc was mounted, the full
contents of the CDROM could be read, so the problem seems to be associated
with reading the raw bitstream via the /dev/ device entry.

If the image created by the dd command was mounted (on a CD after burning or
via loopback) at least one file per CD was unreadable (I'm guessing it's the
files at the end of the CD occupying those last 44 sectors).

I tried this in two different 2.4.18 boxes with the same result.  A 2.2.19
box with an IDE CDROM read the 64016 sectors with no trouble.  A closing I/O
error was reported, but the full 64016 were successfully transferred to the
output file.

A *SCSI* CD writer drive under 2.4.18 also read the full 64016 sectors like
2.2.19+IDE drive did.

Thus it seems that there is a problem accessing the last few sectors (44 in
our case above) of a cdrom directly when 2.4.18 is used with an IDE CD
drive.

Is there any way around this problem?  Is it a known problem and is a fix
available?

Please CC me any replies since I read the list via a web archive which has
missed individual postings in the past.  Thanks.

Best regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
