Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130439AbRCPNwW>; Fri, 16 Mar 2001 08:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRCPNwM>; Fri, 16 Mar 2001 08:52:12 -0500
Received: from mailserver-ng.cs.umbc.edu ([130.85.100.230]:45225 "EHLO
	mailserver-ng.cs.umbc.edu") by vger.kernel.org with ESMTP
	id <S130439AbRCPNvw>; Fri, 16 Mar 2001 08:51:52 -0500
To: linux-kernel@vger.kernel.org
Subject: devfs vs. devpts
From: Ian Soboroff <ian@cs.umbc.edu>
Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: 16 Mar 2001 08:45:35 -0500
Message-ID: <87vgp9zv28.fsf@danube.cs.umbc.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.4.2ac7, and am having problems with Unix98 ptys.
Occasionally rxvt and Eterm fail to run because they can't get
permission to create their entry in /dev/pts.  So i wondered if i have
a devfs problem, which led me to the following...

In Documentation/filesystems/devfs/README, it is thus written:

        Disable devpts 
        I've had a report of devpts mounted on /dev/pts
        not working correctly. Since devfs will also manage /dev/pts,
        there is no need to mount devpts as well. You should either
        edit your /etc/fstab so devpts is not mounted, or disable
        devfs from your kernel configuration.

i don't have devpts mounted under 2.4.2 (debian checks whether you
have devfs before mounting devpts), so i tried building my kernel with
Unix 98 pty support but without the devpts filesystem.  i get the
following error at the very end of 'make bzImage':

drivers/char/char.o: In function `pty_close':
drivers/char/char.o(.text+0x6646): undefined reference to `devpts_pty_kill'
make: *** [vmlinux] Error 1

so the devfs documentation is wrong; pty_close depends on
functionality from devpts.  and secondly, has anyone else had problems
under 2.4.x creating entries in /dev/pts?

ian

-- 
----
Ian Soboroff                                       ian@cs.umbc.edu
University of MD Baltimore County      http://www.cs.umbc.edu/~ian
