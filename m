Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSLaKkL>; Tue, 31 Dec 2002 05:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSLaKkL>; Tue, 31 Dec 2002 05:40:11 -0500
Received: from ip68-101-124-193.oc.oc.cox.net ([68.101.124.193]:62337 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S261376AbSLaKkK>; Tue, 31 Dec 2002 05:40:10 -0500
Date: Tue, 31 Dec 2002 02:48:35 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org, mnalis-umsdos@voyager.hr
Subject: Re: [BUG] 2.2.24-rc2/2.4.18/2.4.20 UMSDOS hardlink OOPS
Message-ID: <20021231104835.GC2323@ip68-4-86-174.oc.oc.cox.net>
References: <20021231080117.GB2323@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021231080117.GB2323@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 12:01:17AM -0800, Barry K. Nathan wrote:
> 4. Obtain the glibc package from the "L" package set (I think the
> filename is "slackware/l/glibc-2.2.5-i386-2.tgz" from your Slackware 8.1
> FTP mirror, your Slackware CD burned from downloaded ISO file, or disc 1
> from your Slackware boxed set), and install it. In my case, this means
> inserting disc 1, mounting it on /mnt/cdrom, and "installpkg
> /mnt/cdrom/slackware/l/glibc-2.2.5-i386-2.tgz".

Or, for more verbosity, replace
installpkg /mnt/cdrom/slackware/l/glibc-2.2.5-i386-2.tgz

with
cd / # important, if done from say /root the oops doesn't happen
tar zxvf /mnt/cdrom/slackware/l/glibc-2.2.5-i386-2.tgz

(Then you can strace tar if listing each filename isn't enough for you.)

> At this point I'm not sure what should be done to fix this. Should
> umsdos_solve_hlink (or UMSDOS_link?) be turning the negative dentry into
> some kind of error (-ENOENT?) for the calling function? (Hmmm... after I
> send this e-mail I think I'll try making a patch to do this and see what
> effect it has.) Or is the negative dentry itself a symptom/result of

Ok, I've done this (returning -ENOENT from umsdos_solve_link instead of
oopsing). I guess I'll post the patches (one for 2.2, one for 2.4)
tomorrow after I test them some more. This seems in my limited testing
to improve stability and eliminate data loss vs. not having the patch,
but I need to test it a bit more first. (In any case, the patch only
makes a difference in cases that would have oopsed/segfaulted without
it.)

IOW, it's an incomplete (if not simply wrong) fix, but it could be
better than what's there now, maybe.

-Barry K. Nathan <barryn@pobox.com>
