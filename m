Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292832AbSB0VBc>; Wed, 27 Feb 2002 16:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292948AbSB0VA7>; Wed, 27 Feb 2002 16:00:59 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:44852 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S292944AbSB0VA3>; Wed, 27 Feb 2002 16:00:29 -0500
Date: Wed, 27 Feb 2002 16:00:26 -0500
To: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: ext3 and undeletion
Message-ID: <20020227210026.GA18660@rochester.rr.com>
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>
User-Agent: Mutt/1.3.27i
From: jstrand1@rochester.rr.com (James D Strandboge)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 11:48:49AM -0600 or thereabouts, Rose, Billy wrote:

It seems to me the undelete could be in the kernel, and could be
beneficial.

Rather than modifying all the different filesystems, or libc, we could
modify the VFS unlink function in the kernel.  It would therefore work
with all filesystems working under VFS, and all programs regardless of
whether it is linked against the latest libc or using LD_PRELOAD.

There are obviously some issues that would have to be resolved with the
algorithm, but as far as versioning I think that is the role of backups.
This should be more along the lines of 'whoops I deleted /etc/fstab.
Let me go get it out of /.undelete'.  Simply put, if the file is already
in there, just overwrite it.  Though, it wouldn't be too hard to tack a
.1 on the end of the old file I suppose.

Also, if the files are just moved to the .undelete directory (and by
moved, I mean a hard link to .undelete, followed by a remove of the
original), disk usage as reported by df and du would still show it
as there.  I don't think that is a very big deal.  I simple solution
would just be to have a cron job empty out older files.  It should be the
sysadmin's job on how to manage the .undelete directory, not the kernel's
(IMO).  Of course, a configurable daemon to monitor the directory could
be implemented, but this especially seems like a userspace problem.

Undeleting is the harder of these.  User's should be able to undelete a
file IMO.  Either an suid binary has to be created to list the contents
of the .undelete directory based on the user running it, or they can go
into the directory and get what they need.  Rather than having a world
write /tmp like directory, it could be chmod 1755 with root ownership.
That way users could browse the directory and cp out what they wanted,
but they can't write to it and overwrite files and do symlink attacks,
etc.  This is a security issue in terms of privacy though, depending on
the user's umask.  The former (an suid binary) is probably better, but
the latter is the easier to implement.

Please comment.

James Strandboge

-- 
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A
