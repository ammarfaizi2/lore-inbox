Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSIZWrw>; Thu, 26 Sep 2002 18:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbSIZWrw>; Thu, 26 Sep 2002 18:47:52 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:11138 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261541AbSIZWrv>;
	Thu, 26 Sep 2002 18:47:51 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Thu, 26 Sep 2002 15:53:02 -0700
User-Agent: KMail/1.4.7-cool
Cc: linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209261208.59020.ryan@completely.kicks-ass.org> <20020926220432.GB10551@think.thunk.org>
In-Reply-To: <20020926220432.GB10551@think.thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209261553.07593.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 26, 2002 15:04, Theodore Ts'o wrote:
> Was there anything in the logs at all?  There should be, if the
> filesystem was remounted read-only.
There is nothing. grep -i "ext3" /var/log/messages returned a whole lot of the 
usual:
Sep 25 15:51:00 completely kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Sep 25 15:51:00 completely kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on 
ide0(3,2), internal journal
The one mildly interesting thing was:
Sep 26 11:49:06 (none) kernel: EXT3-fs: INFO: recovery required on readonly 
filesystem.
Sep 26 11:49:06 (none) kernel: EXT3-fs: write access will be enabled during 
recovery.
Sep 26 11:49:06 (none) kernel: EXT3-fs warning (device ide0(3,2)): 
ext3_clear_journal_err: Filesystem error recorded from previous mount: IO 
failure
Sep 26 11:49:06 (none) kernel: EXT3-fs warning (device ide0(3,2)): 
ext3_clear_journal_err: Marking fs in need of filesystem check.
Sep 26 11:49:06 (none) kernel: EXT3-fs: ide0(3,2): orphan cleanup on readonly 
fs
Sep 26 11:49:06 (none) kernel: EXT3-fs: recovery complete.
Sep 26 11:49:06 (none) kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Sep 26 11:49:06 (none) kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,2), 
internal journal

> The real question is what was the original error that caused the ext3
> filesystme to decide it needed to remount the filesystem read-only.
> That should be in your logs, since calls to ext3_error should always
> cause printk's explaining what the error was to be sent to the logs.
I've seen the printk's (although I didn't write down this one). However, they 
are never hitting the disk. I could try to log the messages to my FreeBSD 
mail server...

> The filesystem wouldn't happen to be running close to full either on
> the number of blocks or the number of inodes, would it?  
Inode count:              4767744
Block count:              9522528
Reserved block count:     476126
Free blocks:              2362117
Free inodes:              4490071

Seems to be fine.....

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9k4/TLGMzRzbJfbQRAgp6AJ9Xp7WviFP9ByQaUJ8Ak9sYVf1C4ACffemS
tS4gB+W4WE7VrPKa+tan/68=
=MhXA
-----END PGP SIGNATURE-----
