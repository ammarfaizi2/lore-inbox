Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292515AbSB0PjL>; Wed, 27 Feb 2002 10:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292581AbSB0PjC>; Wed, 27 Feb 2002 10:39:02 -0500
Received: from [66.150.46.254] ([66.150.46.254]:60084 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S292579AbSB0Pi4>;
	Wed, 27 Feb 2002 10:38:56 -0500
Message-ID: <3C7CFD8A.8365878D@wgate.com>
Date: Wed, 27 Feb 2002 10:38:50 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] kernel 2.5.5 - coredump sysctl
In-Reply-To: <200202271405.g1RE5EK15866@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > BTW - are you looking at merging this into your tree (2.5 and/or 2.4)?
> > I belive I can continue doing the patching here but it would be nice
> > to have this generally available as some people (consulting clients of mine)
> > don't want to run kernels that I build but only ones from RedHat...
> 
> I still can't decide if its worth the extra complexity.
> 
> I don't btw think the '/' is a big problem - only root can set the core
> dump path, and current->comm is the "true" name of the program so won't
> have a / in it

Just call me paranoid...

As to the extra complexity - it is rather minor change in code and provides
a way to (a) get core dump names with program names and not just "core"
and (b) place code dump files somewhere else.

The second item is the major one for us since most of the "disk" is
read-only and thus core dumps just don't happen there.  (Almost all of
the disk is read-only infact.  The only writable place is the /cores
directory and the tmpfs /etc, /var, and /tmp  Everything else in our
clusters are either via the database or via other network protocols
that are optimized for the traffic load, load balancing, and fail-over.

Plus, I really like this on my local machine since the core file cleanup
is now a simple cleanup in a single directory rather than a find across
the whole disk looking for coredump files.

The good thing is that the patch goes in rather cleanly right now
(albeit I need a different one for the SGI tree due to a sysctl
numbering conflict for their kdb)

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.
