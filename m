Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTEVO6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbTEVO6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:58:31 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:41979 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261918AbTEVO60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:58:26 -0400
Date: Thu, 22 May 2003 09:09:12 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: corrupt ext3 that even debugfs refuses to repair
Message-ID: <20030522090912.J4198@schatzie.adilger.int>
Mail-Followup-To: Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20030522132646.GB1506@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030522132646.GB1506@codeblau.de>; from felix-kernel@fefe.de on Thu, May 22, 2003 at 03:26:46PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 22, 2003  15:26 +0200, Felix von Leitner wrote:
> I just found out that my CVS ext3 file system is corrupted.
> The symptom is that du complains about "file not found", i.e. getdents64
> returns the files but stat says they aren't there.
> 
> e2fsck finds nothing wrong with the filesystem.
> 
> I isolated the files into one directory which I moved to /broken.  This
> is what debugfs says:
> 
> # debugfs -w /dev/discs/disc0/part5
> debugfs 1.33 (21-Apr-2003)
> debugfs:  cd /broken
> debugfs:  ls
>  6243596  (12) .    2  (4084) ..    0  (4096) nsISO88592ToUnicode.cpp
>  0  (4096) nsKOI8UToUnicode.o    0  (4096) nsUnicodeToMacDevanagari.h
>  0  (4096) nsUnicodeToZapfDingbat.h    0  (620) nsCP1258ToUnicode.h
>  6243907  (3476) .cvsignore    0  (4096) nsMacUkrainianToUnicode.cpp
> debugfs:  rm foo
> rm: File not found by ext2_lookup while trying to resolve filename
> debugfs:  ls
> ls: invalid option -- o
> zsh: 5846 segmentation fault  debugfs -w /dev/discs/disc0/part5
> 
> 
> Huh?  debugfs does not appear to be a very stable tool ;)

Patches are welcome, since you are probably the only person with a
filesystem corrupted in exactly the right way...  At least run "e2image"
on this partition before throwing it away...

> Once again, with nsCP1258ToUnicode.h this time:
> 
> debugfs:  rm nsCP1258ToUnicode.h
> rm: File not found by ext2_lookup while trying to resolve filename
> debugfs:  unlink nsCP1258ToUnicode.h
> unlink_file_by_name: No free space in the directory

These files are already deleted according to the debugfs output above
(ino == 0 means they are deleted).  Only "." and ".cvsignore" have
valid inode numbers.

> What can I do now (besides backup and restore, obviously)

It is possible that these inodes are in lost+found, but that is only
a guess.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

