Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280856AbRKOOZO>; Thu, 15 Nov 2001 09:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280845AbRKOOZF>; Thu, 15 Nov 2001 09:25:05 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:48122 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S280856AbRKOOYz>; Thu, 15 Nov 2001 09:24:55 -0500
Date: Thu, 15 Nov 2001 09:24:52 -0500
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Bug in ext3
Message-ID: <20011115092452.Z329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently compiled support for ext3 into the kernel (2.4.15-pre4) and
booted that kernel onto a system that didn't have any ext3 partitions.
On boot I got these messages:

JBD: no valid journal superblock found
JBD: no valid journal superblock found
EXT3-fs: error loading journal.

This was when it mounted the root filesystem. After several minutes of
disk activity on /, I got this:

EXT2-fs error (device sd(8,20)): ext2_free_blocks: Freeing blocks not in datazone - block = 4294965248, count = 6872

Then it was mounted ro. Nothing happened to any of the other partitions
(including the 250gig RAID partition, just the root partition. I am
assuming that even though it was not an ext3 partition, that the ext3
driver took control of it. I tried fsck and remount,rw, but the problem
kept occuring (although with a different message about when removing a
file that the bit was already cleared).

Rebuilding without ext3 solves the symptoms, but of course not the real
problem.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
