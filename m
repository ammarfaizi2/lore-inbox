Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278633AbRKMTkQ>; Tue, 13 Nov 2001 14:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278615AbRKMTkG>; Tue, 13 Nov 2001 14:40:06 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:24817 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S278604AbRKMTju>; Tue, 13 Nov 2001 14:39:50 -0500
Date: Tue, 13 Nov 2001 14:39:48 -0500
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Differences between 2.2.x and 2.4.x initrd
Message-ID: <20011113143947.F329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've come across a difference in how initrd is handled in 2.2.x and
2.4.x. This related directly to TILO (sparc TFTP image with ramdisk).

Basically what we have is a kernel image with ramdisk and initrd
enabled, and a root disk image slapped on the end that is loaded via
initrd.

On 2.2.x, this works without problems; the ramdisk is loaded, and
/sbin/init is executed. However, with 2.4.x, it's quite different.

It loads the initial ramdisk, mounts it fine, tries to execute /linuxrc
(same as in 2.2.x, but it isn't there, so it continues), and then
complains with this:

VFS: Mounted root (ext2 filesystem).
VFS: Cannot open root device "" or 02:00

For some reason it is trying to mount /dev/fd, and totally forgets
about /dev/ram. If I pass root=/dev/ram to the command line, it works
fine, but I don't want to have to do this :)

I can't seem to find the relevant place where this broke. Any ideas?

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
