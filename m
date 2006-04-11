Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWDKNkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWDKNkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 09:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDKNkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 09:40:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11993 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750874AbWDKNkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 09:40:45 -0400
Date: Tue, 11 Apr 2006 15:40:54 +0200
From: Petr Baudis <pasky@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumpable tasks and ownership of /proc/*/fd
Message-ID: <20060411134054.GU27631@pasky.or.cz>
References: <20060408120815.GB16588@pasky.or.cz> <m17j5yhtp4.fsf@ebiederm.dsl.xmission.com> <20060410065332.GD16588@pasky.or.cz> <m1r745ho6s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r745ho6s.fsf@ebiederm.dsl.xmission.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 10, 2006 at 09:42:03AM CEST, I got a letter
where "Eric W. Biederman" <ebiederm@xmission.com> said that...
> The most straight forward is:
> int openat(int dirfd, const char *path, int flags, int mode)
> {
>         int orig_dir_fd;
>         int result;
> 	lock()
> 	orig_dir_fd = open(".");
> 	fchdir(dirfd);
>         result = open(relpath);
>         fchdir(orig_dir_fd);
>         close(orig_dir_fd);
>         unlock();
>         return result;
> }
> 
> I suspect something like the above needs to be considered if
> you want the emulation to work on old kernels, in the presence
> of suid applications.
> 
..snip..
> 
> Although I guess you could attempt to use /proc/self/fd/<n>
> and if that gets a permission problem try a slower but more
> reliable path in the emulation.

Oops, I completely forgot about fchdir(). Thanks, I think I will use
something like this for now.


By the way, I would like to return to a statement from your previous
mail:

> Other processes we do need to deny if we aren't dumpable because
> they don't have another way to get that information.

I still don't understand this - so why don't provide them _this_ way to
get that information? What is the security risk?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
