Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269008AbTCAT7A>; Sat, 1 Mar 2003 14:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269014AbTCAT7A>; Sat, 1 Mar 2003 14:59:00 -0500
Received: from dp.samba.org ([66.70.73.150]:8424 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269008AbTCAT67>;
	Sat, 1 Mar 2003 14:58:59 -0500
Date: Sat, 1 Mar 2003 19:29:42 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030301082942.GB2606@krispykreme>
References: <20030227203512.GA12623@nevyn.them.org> <Pine.LNX.4.44.0302271234530.9696-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302271234530.9696-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Oh, both are work-aroundable, no question about it. The same way it was 
> possible to work around the broken aliasing with previous releases. I'm 
> just hoping that especially the inline thing can be resolved sanely, 
> otherwise we'll end up having to use something ugly like
> 
> 	-D'inline=inline __attribute__((force_inline))'
> 
> on every single command line..
> 
> (I find -finline-limit tasteless, since the limit number is apparently
> totally meaningless as far as the user is concerned. It's clearly a
> command line option that is totally designed for ad-hoc compiler tweaking,
> not for any actual useful user stuff).

Yep, the instruction count used for inlining seems to be calculated too
early to be useful. Things like sigorsets look huge until all the
redundant cases get optimised away.

Also in gcc 3.2 -Winline was broken, I really hope that gets fixed. We
need it to tune -finline-limit and to catch all those stupidly large
inline functions.

Anton
