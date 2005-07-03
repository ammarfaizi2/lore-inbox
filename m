Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVGCTgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVGCTgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVGCTgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:36:40 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:8633 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261502AbVGCTgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:36:24 -0400
Date: Sun, 3 Jul 2005 21:36:19 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging? (2)
Message-ID: <20050703193619.GA2928@janus>
References: <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu> <20050703141028.GB1298@janus> <E1Dp6hK-00056d-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dp6hK-00056d-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 05:47:58PM +0200, Miklos Szeredi wrote:
> > > > But that's not really acceptable (see previous audit case) unless FUSE
> > > > refuses to mount on non-leaf dirs.
> > > 
> > > I don't think the audit case is important.  It's easy to work around
> > > it manually by the sysadmin, and for the automatic case it doesn't
> > > really matter (as detailed above).
> > 
> > Note that the audit case "as user" is less important than the root case. I
> > consider the latter very important and EACCES will break it when FUSE
> > permits mounting on non-leaf dirs.
> 
> OK.  Can you tell me, why you consider it important?  And what's your
> proposal for dealing with it?

It is important because on UNIX, "root" rules on local filesystems.
I dont't like the idea of root not being able to run "find -xdev" anymore
for administrative tasks, just because something got hidden by accident
or just for fun by a user. It's not about malicious users who want to
hide data: they can do that in tons of ways. The simple "find -xdev"
by root should just not be affected unless there is a very good reason
(SELinux or other "hardened" solutions).

IMHO The best thing FUSE could do is to make the mount totally invisible:
don't return EACCES, don't follow the FUSE mount but stay on the original
tree. I think it's either this or returning EACCES plus the leaf node
constraint at mount time.

The name-space variancy introduced by the first option is only minor:
Mounting anything over a tree which is still in use by a process is
much worse because it tends to be disruptive. And that has always been
possible.

[And I would use the kill() equivalence instead of ptrace() because it
is more appropriate. Doing so avoids the risk of accidentally breaking
useful setuid programs - I don't know if that will happen but I don't
see any security issues here.]

-- 
Frank
