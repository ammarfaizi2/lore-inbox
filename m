Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSIZFSA>; Thu, 26 Sep 2002 01:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262189AbSIZFSA>; Thu, 26 Sep 2002 01:18:00 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:7552 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262187AbSIZFR7>;
	Thu, 26 Sep 2002 01:17:59 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Wed, 25 Sep 2002 22:23:11 -0700
User-Agent: KMail/1.4.7-cool
Cc: linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209251645.40575.ryan@completely.kicks-ass.org> <20020926032756.GA4072@think.thunk.org>
In-Reply-To: <20020926032756.GA4072@think.thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209252223.13758.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 25, 2002 20:27, Theodore Ts'o wrote:
> Are you sure you upgraded to the latest version of e2fsprogs (version
> 1.29, released yesterday?). 
Yes, I compiled from source explicitly for this purpose.

I made a second attempt at getting dir_index to work, with make clean in linux 
and e2fsprogs.
1) I ran 'tune2fs -O dir_index /dev/hda2". So good so far.
2) Upon rebooting in to single user mode, I ran 'man fsck' to figure out how 
to get those nifty progressbars ;)
3) While starting man(1), EXT3 began spewing messages in the form:
"EXT3-fs error (device (ide0(3,2)): ext3_readdir: directory #4243459 contains 
a hole at offset xxxxxx"
The directory number stayed constant, but the offset was variable. fsck -fD 
had -not- been run at this point.
4) On reboot, fsck reported:
"Directory inode has unallocated block #xx"
multiple times. fsck seemed to fully recover the filesystem. I rebooted again 
for good measure.
5) Not set back, I tried 'man fsck' again. It worked as expected this time.
6) Next, I executed 'e2fsck -CfD /dev/hda2". When it completed, I rebooted.
7) While KDE was trying to start, EXT3 dumped the following to the console:
"EXT3-fs error (device ide(3,2)) in start_transaction: Journal has aborted"
8) I rebooted, and fsck said:
"Directory inode 131073,block3,offset 528: Directory corrupted"
I wasn't so lucky this time, and a good portion of my home directory got 
eaten.
9) I tried to start KDE again, and the filesystem went read-only halfway 
through composing an email. I didn't catch the error on the console that 
time.
10) fsck reported more 'Directory corrupted' errors, and more of my home 
directory ended up in /lost+found
11) I ran 'tune2fs -O ^dir_index', rebooted, and fsck cleaned up all the index 
blocks

It seems to be running stable now. Linux 2.4.19, UP Athlon, GCC 3.2.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9kpnBLGMzRzbJfbQRAhlfAKCPiz7J6EWNyk/hlFsMbXjeeT7D7QCeI10u
k0yuUW2maTuHhhDMsKRjO5c=
=jOkd
-----END PGP SIGNATURE-----
