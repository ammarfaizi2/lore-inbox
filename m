Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268323AbTBSCRm>; Tue, 18 Feb 2003 21:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268324AbTBSCRl>; Tue, 18 Feb 2003 21:17:41 -0500
Received: from almesberger.net ([63.105.73.239]:46859 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268323AbTBSCRk>; Tue, 18 Feb 2003 21:17:40 -0500
Date: Tue, 18 Feb 2003 23:27:29 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030218232729.V2092@almesberger.net>
References: <20030214153039.G2092@almesberger.net> <Pine.LNX.4.44.0302142106140.1336-100000@serv> <20030214211226.I2092@almesberger.net> <Pine.LNX.4.44.0302150148010.1336-100000@serv> <20030214232818.J2092@almesberger.net> <Pine.LNX.4.44.0302151816550.1336-100000@serv> <20030217140423.N2092@almesberger.net> <Pine.LNX.4.44.0302172019220.1336-100000@serv> <20030217221837.Q2092@almesberger.net> <Pine.LNX.4.44.0302181516210.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302181516210.1336-100000@serv>; from zippel@linux-m68k.org on Wed, Feb 19, 2003 at 02:48:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Anyway, for now just keep this option in mind and let's look at the other
> options, which don't require a module API change.

Yes, we can look at the modules case at the end.

> In that case it would be kernel memory, which cannot be freed, so it will 
> not go away and requires no module count.

kfree isn't the only way to make data unusable. Remember the
"my_state" example.

> > Likewise, possibly dynamically allocated data that is synchronized
> > by the caller, e.g. "user" in "struct proc_dir_entry".
> 
> user?

"data", sorry. I always call this kind of argument something like
"user" in my code ...

> A generic file system as it's registered via register_filesystem.

Okay, I'll have a look at that.

> Um, it's getting late and I just played too much with procfs to find a 
> sensible solution. Below is an experimental patch to add callback which 
> would allow it to safely remove user data. Very lightly tested, so no 
> guarantees.

Yep, that's the kind of callback I had in mind.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
