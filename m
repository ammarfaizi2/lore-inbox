Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132809AbRC2Spo>; Thu, 29 Mar 2001 13:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRC2SpY>; Thu, 29 Mar 2001 13:45:24 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:1781 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132809AbRC2SpR>; Thu, 29 Mar 2001 13:45:17 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103291844.f2TIiSK09176@webber.adilger.int>
Subject: Re: Bug in the file attributes ?
In-Reply-To: <Pine.LNX.4.21.0103292011480.20805-100000@ilaws.aurora-linux.net>
 from Xavier Ordoquy at "Mar 29, 2001 08:20:32 pm"
To: Xavier Ordoquy <xordoquy@aurora-linux.com>
Date: Thu, 29 Mar 2001 11:44:27 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Ordoquy writes:
> I just made a manipulation that disturbs me. So I'm asking whether it's a
> bug or a features.
> 
> user> su
> root> echo "test" > test
> root> ls -l
> -rw-r--r--   1 root     root            5 Mar 29 19:14 test
> root> exit
> user> rm test
> rm: remove write-protected file `test'? y
> user> ls test
> ls: test: No such file or directory
> 
> This is in the user home directory.
> Since the file is read only for the user, it should not be able to remove
> it. Moreover, the user can't write to test.

This is definitely not a bug.  Deleting a file (under *nix) does not
"modify" the file at all, it is modifying the directory where the file
resides.  In this case, a user _will_ have permission to write into
their home directory, so they can delete the file, but not modify it.

Why do such a thing?  If you have group/world write permission on a
directory, then people who have write permission to the _directory_
should be able to delete files even if they don't own them.  However,
if you set the "sticky" bit on the directory (chmod +t /dir), then only
the owner of the file can delete it, like in /tmp.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
