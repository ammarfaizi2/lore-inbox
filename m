Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSKCE52>; Sat, 2 Nov 2002 23:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSKCE52>; Sat, 2 Nov 2002 23:57:28 -0500
Received: from waste.org ([209.173.204.2]:57313 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261622AbSKCE51>;
	Sat, 2 Nov 2002 23:57:27 -0500
Date: Sat, 2 Nov 2002 23:03:44 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103050344.GF18884@waste.org>
References: <20021103035017.GD18884@waste.org> <Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 08:20:44PM -0800, Linus Torvalds wrote:
> 
> On Sat, 2 Nov 2002, Oliver Xymoron wrote:
> > 
> > Bindings are cool, but once you start talking about doing a lot of
> > them, they're rather ungainly due to not actually being persisted on
> > the filesystem, no? 
> 
> Well, they _are_ persistent in the filesystem, although in this case "the 
> filesystem" is /etc/fstab.

Yes, but this has annoying side effects like booting single-user and
discovering things like /sbin/ping doesn't exist because mount -a
didn't run yet. Stuff like that sucks.
 
> That's not really a problem, and the advantage of the filesystem bind
> approach is that it is extremely explicit, and it is trivial for a
> maintainer to at all times see all such "elevated" binaries: as Al points
> out, the only thing you need to do is to just ask to be shown the mount
> list with "mount" or with "cat /proc/mounts".

But they show up as regular files to things like ls. And magically
break when copied, moved, etc.. Backups and bind mounts? It's not
obvious to me how that works.
 
> > A better approach is to just make a user-space capabilities-wrapper
> > that's setuid, drops capabilities quickly and safely and calls the
> > real app.
> 
> This is _not_ a good approach from a sysadmin standpoint. The sysadmin
> does not explicitly know what the suid binary does internally, the
> sysadmin just sees a number of suid binaries and has to trust them.

It's not perfect. Perhaps there's some #! script-like way to do it
where there's only one binary to trust. One more point in its favor is
it works in 2.4...

> Yes, I realize that your example had "showcapwrap" etc sysadmin tools to 
> work around this, and make the wrapping be transparent to the sysadmin. 
> That certainly works, although it still depends on trusting that the 
> wrapping cannot be confused some way. I guess that could be done fairly 
> easily (although I think you'd want to make "mkcapwrap" actually _sign_ 
> the wrapped binaries, to make sure that nobody can later try to inject a 
> "bad" binary that _looks_ ok to "showcapwrap" and fools the admin to think 
> everything is ok).
> 
> But from a security maintenance standpoint, wouldn't it be _nice_ to be 
> able to
> 
>  - do a complete "find" over the whole system to show that there is not a 
>    single suid binary anywhere.

That's just show. 
 
>  - trivially show each and every binary that is allowed elevated 
>    permissions (and _which_ elevated permissions) by just doing a "mount".

That might not strike _you_ as weird, but then this is the same guy
who wanted files you could cd into..

>  - and since the mount trees are really per-process, you can allow certain 
>    process groups to have mounts that others don't have.

You can do that with any capability scheme.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
