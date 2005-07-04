Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVGDI52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVGDI52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 04:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVGDI51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 04:57:27 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:9491 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261584AbVGDI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 04:57:06 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050703193619.GA2928@janus> (message from Frank van Maarseveen
	on Sun, 3 Jul 2005 21:36:19 +0200)
Subject: Re: FUSE merging? (2)
References: <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu> <20050703141028.GB1298@janus> <E1Dp6hK-00056d-00@dorka.pomaz.szeredi.hu> <20050703193619.GA2928@janus>
Message-Id: <E1DpMkg-00064O-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 04 Jul 2005 10:56:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is important because on UNIX, "root" rules on local filesystems.
> I dont't like the idea of root not being able to run "find -xdev"
> anymore for administrative tasks, just because something got hidden
> by accident or just for fun by a user.  It's not about malicious
> users who want to hide data: they can do that in tons of ways.

That's a sort of security by obscurity: if the user is dumb enough he
cannot do any harm.  But I'm not interested in that sort of thing.  If
this issue important, then it should be solved properly, and not just
by "preventing accidents".

> IMHO The best thing FUSE could do is to make the mount totally
> invisible: don't return EACCES, don't follow the FUSE mount but stay
> on the original tree. I think it's either this or returning EACCES
> plus the leaf node constraint at mount time.

The leaf node constranint doesn't make sense.  The hidden mount thing
does, but it has been very flatly rejected by Al Viro.

There's a nice solution to this (discussed at length earlier): private
namespaces.

I think we are still confusing these two issues, which are in fact
separate.

  1) polluting global namespace is bad (find -xdev issue)

  2) not ptraceable (or not killable) processes should not be able to
     access an unprivileged mount

For 1) private namespaces are the proper solution.  For 2) the
fuse_allow_task() in it's current or modified form (to check
killability) should be OK.

1) is completely orthogonal to FUSE.  2) is currently provably secure,
and doesn't seem cause problems in practice.  Do you have a concrete
example, where it would cause problems?

Miklos
