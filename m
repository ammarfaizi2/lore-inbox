Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTEaQ2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTEaQ2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:28:43 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:11272 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264377AbTEaQ2l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:28:41 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: pdflush -> noflushd related question
Date: Sat, 31 May 2003 18:41:59 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305311841.59599.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I want to fix the userspace noflushd daemon to run on 2.5 kernels,
but it seems to get *very* tricky, because bdflush, kupdated have been
replaced by pdflush.

I've grepped through the lkml-archives and I found a post from you, Andrew,
that sayed:

[SNIP]
Subject: [patch] replace kupdate and bdflush with pdflush

- - use a timer to kick off a pdflush thread every five seconds
  to run the kupdate code. 

- - wakeup_bdflush() kicks off a pdflush thread to run the current
  bdflush function.

There's some loss of functionality here - the ability to tune
the writeback periods.  The numbers are hardwired at present.
But the intent is that buffer-based writeback disappears
altogether.  New mechanisms for tuning the writeback will
need to be introduced.
[SNIP]


Yea, but it seems, that I need exactly this lost functionality. :)
noflushd, on 2.4 kernels, prevents the disks to spin up by spinning
them down an stopping the kupdated daemon through putting
the update-interval to 0 via syscall bdflush().
That's the code to do so:
bdflush(2 + (1 << 3) + 1, interval);

So, how to set the interval, or better sayed, how to _stop_
buffer flushing in 2.5?
Has this lost functionality already been re-implemented?
Are there new syscalls?

Thanks for your help.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 18:29:24 up  4:01,  2 users,  load average: 1.11, 1.09, 1.05

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2NtXoxoigfggmSgRArisAJ9KTnvSW51e4OnLvkvjI/D/bUF19ACeK9Yw
xOVOelmYmHd9eC7Unuys8pM=
=t+79
-----END PGP SIGNATURE-----

