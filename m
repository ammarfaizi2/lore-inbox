Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbSKAXT2>; Fri, 1 Nov 2002 18:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265811AbSKAXT1>; Fri, 1 Nov 2002 18:19:27 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:942 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S265810AbSKAXT1>; Fri, 1 Nov 2002 18:19:27 -0500
Date: Fri, 1 Nov 2002 18:25:55 -0500
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021101232555.GA6413@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	linux-kernel@vger.kernel.org
References: <20021101085148.E105A2C06A@lists.samba.org> <1036175565.2260.20.camel@mentor> <apuj4s$e33$1@main.gmane.org> <871y6554g0.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871y6554g0.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 11:07:59PM +0100, Olaf Dietsche wrote:
> > Unfortunately Alexander has spoken again:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103498212701476&w=4
> 
> Well, this was his first histerical response. In the meantime, all his
> points have been addressed. I haven't heard of new objections, did you?

I have several comments.

Where are the capabilities stored? In a file called .capability in the
root of the filesystem? Why would that root be writable, my current Coda
development tree has a read-only top-level directory in which different
realms can be dynamically mounted (similar to autofs).

How would I remove a capability from a vulnerable binary on readonly
media (i.e. cdrom), while still allowing other applications on the same
disk to run with special caps.

Right now an administrator can simply search for all setuid binaries to
check for possible 'unwanted priviledge elevations'. With the proposed
capabilities seemingly ordinary applications could suddenly have special
powers. Also when I explicitly drop capabilities secure a system, these
fs-caps could very well reintroduce a capability that were not in the
permitted set of any of the running processes.

It is probably better to remove than to add capabilities. As everyone
knows a setuid app is 'dangerous' use this code to remove some of the
power that normally is associated with setuid. I.e. when the setuid bit
is set for a specific application don't change euid to root, but still
give the power to bind to priviledged ports.

In the end I believe capabilities (like setuid) should be a local
decision. Yes, I'm looking at this from the viewpoint of a distributed
network filesystem that crosses administrative boundaries, and as such I
don't always trust whatever is stored in a mounted volume.

Why not modify a program like sudo or super that can give capabilities
to processes based on local rules and configuration... Ok there already
is a programs that does something like this which is called 'whichcap'.

Another solution is to have a trusted daemon that is the only process
in the system with the capability to grant capabilities to other
proceses. Other processes can send a request to this daemon, which can
consult local rules, double check md5 checksum or whatever paranoia is
needed before it actually does a setcap.

Jan

