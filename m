Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSKCDoL>; Sat, 2 Nov 2002 22:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSKCDoL>; Sat, 2 Nov 2002 22:44:11 -0500
Received: from waste.org ([209.173.204.2]:9184 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261584AbSKCDoK>;
	Sat, 2 Nov 2002 22:44:10 -0500
Date: Sat, 2 Nov 2002 21:50:17 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103035017.GD18884@waste.org>
References: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu> <Pine.LNX.4.44.0211021922280.2354-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021922280.2354-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 07:23:11PM -0800, Linus Torvalds wrote:
> 
> On Sat, 2 Nov 2002, Alexander Viro wrote:
> >
> > 	<shrug> that can be done without doing anything to filesystem.
> > Namely, turn current "nosuid" of vfsmount into a mask of capabilities.
> > Then use bindings instead of links.
> 
> I like that idea. It's very explicit, and clearly name-based, and we do
> have 99% of the support for it already.

Bindings are cool, but once you start talking about doing a lot of
them, they're rather ungainly due to not actually being persisted on
the filesystem, no? 

A better approach is to just make a user-space capabilities-wrapper
that's setuid, drops capabilities quickly and safely and calls the
real app. Something like:

# mv ping ping.real
# chmod -s ping.real
# mkcapwrap +net_raw ping.real
# chmod +s ping
# showcapwrap ping
invokes /bin/ping
grants net_raw
#

No fs magic, no persistence issues, all user-space.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
