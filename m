Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314281AbSDVRJZ>; Mon, 22 Apr 2002 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314287AbSDVRJY>; Mon, 22 Apr 2002 13:09:24 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:2809 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314281AbSDVRJY>; Mon, 22 Apr 2002 13:09:24 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 22 Apr 2002 11:07:46 -0600
To: Libor Vanlk <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adding snapshot capability to Linux
Message-ID: <20020422170745.GD3017@turbolinux.com>
Mail-Followup-To: Libor Vanlk <libor@conet.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CC3ECD2.9000205@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 22, 2002  12:58 +0200, Libor Vanlk wrote:
> I'm going to start my dissertation work which is "Adding snapshop 
> capability to Linux kernel with copy-on-write support". My idea is add 
> it as another VFS - I know that there is some snapshot support in LVM 
> but it's working on "device-level" and I'd like/have to do it on fs level.
> 
> My idea is to use it this way:
> - I have running system with some "/foo" dir
> - I want to make snapshot of "/foo/bar" to "/foo/snap1"
> - I run "mount -t snapshot /foo/bar /foo/snap1"
> - This creates virtual image of "/foo/bar" to the "/foo/snap1" with 
> hidden file (something like journal) in "/foo/snap1" - all files are 
> linked to "/foo/bar"
> - Whenever is some file/dir changed in "/foo/bar" there is created 
> physical copy of it to the snapshot(s) before writing changes (for 
> making records about this will be used the hidden file)
> - Of course that one directory can be snapshoted more times
> - Probably the hidden file with records about all snapshots and details 
> should be stored in "/foo/bar"
> - Question is how to handle ACLs and EA for XFS/JFS/... and if it won't 
> collide with journal
> 
> I'd like to do it not only because I have to but I want people to use it 
> (I want to make it GPL) and maybe it will be one nice day part of Linux 
> kernel ;-)
> 
> So I'd like if you can send me any suggestions/tips/warnings/links etc. 
> before I start coding so I know what should I avoid/use.

Please see:
http://www-mddsp.enel.ucalgary.ca/People/adilger/snapfs/

What you describe is exactly what snapfs does.  The Sourceforge project
is currently inactive, but the code itself is GPL and only needs some
polishing up and maintenance to be useful (probably also some work to
get it all OK under 2.4 again).  There is already ext2 and ext3 support
for snapfs, and it would probably still be a worthwhile project to add
snapfs support for reiserfs.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

