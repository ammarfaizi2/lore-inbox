Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281062AbRKOVL3>; Thu, 15 Nov 2001 16:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281061AbRKOVLV>; Thu, 15 Nov 2001 16:11:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22794 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281062AbRKOVLE>; Thu, 15 Nov 2001 16:11:04 -0500
Message-ID: <3BF42F47.FA3B7657@zip.com.au>
Date: Thu, 15 Nov 2001 13:10:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au>,
		<3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> 
> Seems it does have the field set. I guess the bug is then that if there
> is no journal, then it shoudl fail to mount it, so ext2 will take over.
> Is there any reason to mount a partition as ext3 if there is no journal
> to be found?
> 
> Filesystem volume name:   <none>
> Last mounted on:          <not available>
> Filesystem UUID:          <none>
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal filetype sparse_super
> Filesystem state:         not clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              1015808
> Block count:              2028288
> Reserved block count:     101414
> Free blocks:              372624
> Free inodes:              690438
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         16384
> Inode blocks per group:   512
> Last mount time:          Thu Nov 15 10:07:12 2001
> Last write time:          Thu Nov 15 15:55:23 2001
> Mount count:              2
> Maximum mount count:      20
> Last checked:             Thu Nov 15 08:48:40 2001
> Check interval:           15552000 (6 months)
> Next check after:         Tue May 14 09:48:40 2002
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               128

Are you running a current version of e2fsprogs?  1.25?

If you are, then this indicates that the filesystem has has_journal
set, but it doesn't have a journal inode.  That is certainly something
which e2fsck should detect and fix.  This may be a fsck bug.

You should be able to fix this with `tune2fs -O ^has-journal' on
the unmounted or readonly fs.
