Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbRFFJXp>; Wed, 6 Jun 2001 05:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbRFFJXf>; Wed, 6 Jun 2001 05:23:35 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:19717 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261454AbRFFJX0>;
	Wed, 6 Jun 2001 05:23:26 -0400
Message-ID: <20010605144302.A8058@bug.ucw.cz>
Date: Tue, 5 Jun 2001 14:43:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>, Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <UTC200106031053.MAA185287.aeb@vlet.cwi.nl> <Pine.GSO.4.21.0106030703590.27673-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0106030703590.27673-100000@weyl.math.psu.edu>; from Alexander Viro on Sun, Jun 03, 2001 at 07:25:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What I did was: add a field  `char *mnt_symlink_prefix;'  to the
> > struct vfsmount, fill it in super.c:add_vfsmnt(), use it in
> > namei.c:vfs_follow_link(). Pick the value up by recognizing
> > in super.c:do_mount() the option "symlink_prefix=" before
> > giving the options to the separate filesystems.
> > 
> > [One could start a subdiscussion about that part. The mount(2)
> > system call needs to transport vfs information and per-fs information.
> > So far, the vfs information used flag bits only, but sooner or later
> > we'll want to have strings, and need a vfs_parse_mount_options().
> > Indeed, many filesystems today have uid= and gid= and umask= options
> > that might be removed from the individual filesystems and put into vfs.
> > After all, such options are also useful for (foreign) ext2 filesystems.]
> 
> _Please_, if we do anything of that kind - let's use a new syscall.
> Ideally, I'd say
> 	fs_fd = open("/fs/ext2", O_RDWR);
> 	/* error -> no such filesystem */
> 	write(fs_fd. "/dev/sda1", strlen("/dev/sda1"));
> 	/* error handling */
> 	write(fs_fd, "reserve=5", strlen(....));
> 	...
> 	dir = open("/usr/local", O_DIRECTORY);
> 	/* error handling */
> 	new_mount(dir, MNT_SET, fs_fd);	/* closes dir and fs_fd */
> 	/* error handling */
> 
> First open gives you a new channel. Preferably - wit datagram semantics (i.e.
> write() boundaries are preserved). Then you convince fs driver to give you
> fs. Then you mount it.

Looks good. Will it be possible to emulate old mount in libc in
(distant) future.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
