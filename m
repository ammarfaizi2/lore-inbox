Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKTPSc>; Mon, 20 Nov 2000 10:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129187AbQKTPSW>; Mon, 20 Nov 2000 10:18:22 -0500
Received: from www.heime.net ([194.234.65.222]:260 "EHLO mustard.heime.net")
	by vger.kernel.org with ESMTP id <S129166AbQKTPSL>;
	Mon, 20 Nov 2000 10:18:11 -0500
Message-ID: <3A193A12.9B384B61@karlsbakk.net>
Date: Mon, 20 Nov 2000 15:49:55 +0100
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Frank Ronny Larsen <frankrl@nhn.no>, Frank Ronny Larsen <gobo@gimle.nu>,
        Jannik Rasmussen <jannik@east.no>,
        "Lars Christian Nygård" <lars@snart.com>
Subject: ext2 compression: How about using the Netware principle?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With some years of practice with Novell NetWare, I've been wandering why
the (unused?) file system compression mechanism in ext2 is based on
doing realtime compression. To make compression efficient, it can't be
made this simple. Let's look at the type of volume (file system)
compression introduced with Novell NetWare 4.0 around '94:

- A file is saved to disk
- If the file isn't touched (read or written to) within <n> days
(default 14), the file is compressed.
- If the file isn't compressed more than <n> percent (default 20), the
file is flagged "can't compress".
- All file compression is done on low traffic times (default between
00:00 and 06:00 hours)
- The first time a file is read or written to within the <n> days
interval mentioned above, the file is addressed using realtime
compression. The second time, the file is decompressed and commited to
disk (uncompressed).

Results:
A minimum of CPU time is wasted compressing/decompressing files.
The average server I've been out working with have an effective
compression of somewhere between 30 and 100 per cent.

PS: This functionality was even scheduled for Win2k, but was somewhere
lost... I don't know where...

Questions:
I'm really not a kernel hacker, but really...
- The daily (or nightly) compression job can run as a cron job. This can
be a normal user process running as root. Am I right?
- The decompress-and-perhaps-commit-decompressed-to-disk process should
be done by a kernel process within (or beside) the file system.
- The M$ folks will get even more problems braging about a less useful
product.

Please CC: to me, as I'm not on the list

Regards

Roy Sigurd Karlsbakk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
