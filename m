Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279103AbRKOBAn>; Wed, 14 Nov 2001 20:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279454AbRKOBAe>; Wed, 14 Nov 2001 20:00:34 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:8074 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S279103AbRKOBAX>; Wed, 14 Nov 2001 20:00:23 -0500
Date: Thu, 15 Nov 2001 01:00:20 +0000
From: Alex Walker <alex@x3ja.co.uk>
To: linux-kernel@vger.kernel.org
Cc: huggie@earth.li
Subject: VFAT problems in 2.4.14
Message-ID: <20011115010020.B510@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me in any replies - I am not subscribed to the list]

I was copying some files from a reiserfs partition to a FAT32 partition
with the simple command `sudo cp -a Docs/mywork My\ Documents\Work`.
Where "My\ Documents" is a symlink to a directory on my windows
partition.  I did this as sudo since I had no set up permissions on my
FAT32 partition for my normal user.  I then rebooted into Windows, only
to discover that it had gone badly wrong.

The original directory had only 3 subdirectories.  2 of these
transferred across without any errors.  The final one was created, but
the contents corrupted.  It originally had 1.4M of data in 6 document
files.  Instead of these files, files and directories with spurious
names (lots of symbols I can't type in my editor) were created.

Not only this, but the contents of this directory claimed to total 74G
(on a 20G disk!).  None of the files were readable in Windows.

I rebooted again into linux and investigated some more.
- The files names were all 12 characters long. 
- There are 72 of these files.
- When listing the directories you get "Directory sread (sector
  0xd12a66d, limit 6136798" "attempt to access beyond end of device"
  errrors.
- Again, linux thinks the directory is 72G big (but df disagrees on
  partition size)
- Even though the partition is mounted read-only, any attempt to re-copy
  is met with a "creating `file`: Read-only file system" error

Fortunately it was a copy, not a move!

Hope this is helpful.  Any advice appreciated.

aLeX

-- 
-----------------------------
Alex Walker   alex@x3ja.co.uk 
        x3ja|alex
-----------------------------
