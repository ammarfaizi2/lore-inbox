Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbRLQXed>; Mon, 17 Dec 2001 18:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283080AbRLQXeX>; Mon, 17 Dec 2001 18:34:23 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:38753 "EHLO
	tsmtp6.mail.isp") by vger.kernel.org with ESMTP id <S283054AbRLQXeN>;
	Mon, 17 Dec 2001 18:34:13 -0500
Date: Tue, 18 Dec 2001 00:33:59 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: Jurgen Botz <jurgen@botz.org>
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011218003359.A555@diego>
In-Reply-To: <20011217025856.A1649@diego> <13425.1008580831@nova.botz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <13425.1008580831@nova.botz.org>; from jurgen@botz.org on Mon, Dec 17, 2001 at 10:20:31 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I've run badblocks in 2.4.16
results:


root@diego:~# badblocks -n -vv /dev/hdc5
Initializing random test data
Checking for bad blocks in non-destructive read-write mode
>From block 0 to 9671067
Checking for bad blocks (non-destructive read-write test): done
Pass completed, 0 bad blocks found.
root@diego:~#

It takes about 6 hours to check this...but perhaps I should repeat again
in 2.4.17-rc1.

It works in 2.4.16, but ls /hdc5/etc
Dec 18 00:22:32 diego kernel: reiserfs: checking transaction log (device
16:05) ...
Dec 18 00:22:32 diego kernel: Using r5 hash to sort names
Dec 18 00:22:32 diego kernel: ReiserFS version 3.6.25
Dec 18 00:22:40 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 18 00:22:40 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 18 00:22:40 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68722 0x0 SD]
Dec 18 00:22:40 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 18 00:22:40 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 18 00:22:40 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68669 0x0 SD]
Dec 18 00:22:41 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 18 00:22:41 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 18 00:22:41 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 64508 0x0 SD]
Dec 18 00:22:41 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 18 00:22:41 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 18 00:22:41 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 63049 0x0 SD]
Dec 18 00:22:41 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 18 00:22:41 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 18 00:22:41 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68673 0x0 SD]
Dec 18 00:22:41 diego kernel: is_tree_node: node level 18771 does not match
to the expected one 1
Dec 18 00:22:41 diego kernel: vs-5150: search_by_key: invalid format found
in block 10667. Fsck?
Dec 18 00:22:41 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
occurred trying to find stat data of [4160 68377 0x0 SD]

This is my opinion:
	-Something (reiserfs, anything) has caused fs corruption
	-It should be repaired by reiserfsck, but it's broken :-((
	-This corruption should NOT have happened, reiserfsck shouldn't
have to be used.
	-I'm not a kernel hacker, so I can't try anything...what I know is
that
		/etc in hc5 doesn't work. /usr, /var....works correctly.

Well, I'd like to know what's happened in my drive. Can somebody try to
give an explanation?

Diego Calleja



