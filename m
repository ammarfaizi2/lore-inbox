Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262049AbREPSg6>; Wed, 16 May 2001 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262053AbREPSgs>; Wed, 16 May 2001 14:36:48 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:54264 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S262049AbREPSgc>; Wed, 16 May 2001 14:36:32 -0400
X-Mailer: Windows Eudora Light Version 1.5.2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
From: Heikki Tuuri <Heikki.Tuuri@innobase.inet.fi>
Subject: Why O_SYNC and fsync are slow in Linux?
Message-Id: <20010516183630.FZOA13813.fep07.tmt.tele.fi@omnibook>
Date: Wed, 16 May 2001 21:36:30 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC your replies to me because I am not on the list.)

Hi!

Does anyone happen to know who is responsible for the file cache and
disk management in Linux?

On different systems I have measured strange differences in
performance depending on whether I open a file with O_SYNC and
let the operating system do the flushing of the file to disk
after each write, or if I open without O_SYNC, and call
fsync myself.

Some observations:

On Red Hat 6.2 and 7.? Intel big block writes are very slow if
I open the file with O_SYNC. I call pwrite to write 1 MB chunks to
the file, and I get only 1 MB/s write speed. If I open without O_SYNC
and call fsync only after writing the whole 100 MB file,
I get 5 MB/s. I got the same adequate speed 5 MB/s with 16 MB writes
after which I called fdatasync.

On a Linux-Compaq Alpha I measured the following: if I open with O_SYNC,
I can flush the end of my file (it is a log file) to
disk 170 times / second. If I do not open with O_SYNC,
but call fsync or fdatasync after each write, I get only 50
writes/second.

On the Red Hat 7.? I get 500 writes per second if I open with O_SYNC.
That is too much because the disk does not rotate
500 rotations/second. Does the disk fool the operating
system to believe a write has ended while it has not?

On Windows NT I have not noticed such performance problems if
I use non-buffered i/o to a file.

I have written a database engine InnoDB under MySQL and bumped into
these problems on Linux.

Regards,

Heikki Tuuri
Innobase Oy
http://www.innobase.fi

