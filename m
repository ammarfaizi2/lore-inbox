Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030649AbWJCW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbWJCW4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030650AbWJCW4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:56:55 -0400
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:11849 "EHLO
	smtp02.lnh.mail.rcn.net") by vger.kernel.org with ESMTP
	id S1030649AbWJCW4y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:56:54 -0400
X-IronPort-AV: i="4.09,252,1157342400"; 
   d="scan'208"; a="287416609:sNHT24508610"
From: "Matthew Kirk" <mkirk01@rcn.com>
To: <linux-kernel@vger.kernel.org>
Subject: very large ramdisk works with tmpfs but not reiserfs3 or ext2
Date: Tue, 3 Oct 2006 18:57:09 -0400
Message-ID: <001201c6e73f$41556830$6600a8c0@charm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
thread-index: AcbnP0EoWv7iMtm0TJeLtAFryWYKYQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Junkmail-Status: score=10/50, host=mr02.lnh.mail.rcn.net
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090201.4522EA80.0030,ss=1,fgs=0,
	ip=207.172.4.11,
	so=2006-05-09 23:27:51,
	dmn=5.2.113/2006-07-26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A responder at fedora-list suggested this might be a better forum in which
to ask this question…

About a year ago a gent named Brandon posted a note to the fedora-list
stating that, with kernel 2.6.9, when he created a very large ram disk using
ext2 or reiserfs and filled it up his system hung.  Here's his note...
http://lists.linuxcoding.com/rhl/2005/msg58000.html   

The recommendation was to switch to using tmpfs.

I'm having the same problem.  I'm using 2.6.12.3, and I'm attempting to
mount a 2 GB ram disk (out of 8 GB of memory).  As discussed in the original
note series, tmpfs does work, where ext2 and reiserfs don't.  I'm not sure
tmpfs is actually what we want, and I'd like to understand a bit more about
why tmpfs works (and haven't been able to find explanations).

So I have several questions...

1.  When I fill my ext2 or reiserfs ram disk (but not tmpfs) to a point
slightly less than 1 GB, the system complains that it has insufficient
memory, kills some processes, and hangs.  It responds to ping, but that's
about it.  I have 5.5 GB of memory still free, at that point, and I'm not
running any of my own software.  Why does using ext2 or reiserfs result in
insufficient memory when it appears I still have memory left, and why does
tmpfs not suffer the same fate?   I’ve tried to read the code for both shm
and ext2 but my knowledge of the Linux kernel’s innards is limited and I
haven't found the answer.

2.  I understand that a ram disk built with tmpfs can have its contents
swapped.  I also understand this is not true of ext2 or reiserfs.

Is that correct?    

My primary concern with using tmpfs has to do with swapping -- I'm using a
ram disk for a variety of reasons, but one of them is to avoid having any
writes to the file system for staging files and to ensure that certain files
are present for processing and don't need to be re-loaded.  Swapping defeats
that purpose. I can't use /tmp because I also need to pre-reserve space (and
being tmpfs, that can swap too).

I could turn swapping off, but would prefer to leave it on.

3.  When I use a ram disk I have noticed that the files I write to the ram
disk also seem to appear in the file cache.  I believe this is true
primarily due to indirect observation -- when I write 100 MB to my RAM disk
I have 200 MB consumed.  Is that correct?  Is there some way to avoid the
extra caching?

Thanks!
Matt
 


-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.407 / Virus Database: 268.12.12/462 - Release Date: 10/3/2006
 
