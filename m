Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUENVzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUENVzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUENVzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:55:38 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:35007 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262972AbUENVzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:55:12 -0400
Subject: Re: [PATCH] capabilites, take 2
From: Albert Cahalan <albert@users.sf.net>
To: Chris Wright <chrisw@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       luto@myrealbox.com, olaf+list.linux-kernel@olafdietsche.de,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20040514141145.Z21045@build.pdx.osdl.net>
References: <1084536213.951.615.camel@cube>
	 <1084548061.17741.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1084547976.952.644.camel@cube>
	 <1084557969.18592.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1084555929.951.679.camel@cube>  <20040514141145.Z21045@build.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1084563151.955.695.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2004 15:32:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 17:11, Chris Wright wrote:
> * Albert Cahalan (albert@users.sourceforge.net) wrote:
> > On Fri, 2004-05-14 at 14:06, Stephen Smalley wrote:
> > > You missed the point.  Capability scheme maps far too
> > > many operations to a single capability; CAP_SYS_ADMIN
> > > in Linux is a good example.
> > 
> > What I said: lovely, but not exactly groundbreaking.
> > 
> > Suppose we break up CAP_SYS_ADMIN into 41 other bits.
> > There you go. It's silly to argue that a system with
> > more bits is some kind of major advance over one with
> > just a few bits. There is a quality-of-implementation
> > issue here, not some fundamental difference.
> 
> Needing more bits isn't the only problem.

That's what much of the document went on about. The
rest of the document was mostly generic MAC concepts.

> > > TE model
> > > defers organization of operations into equivalence
> > > classes to the policy writer.
> > 
> > I don't see anything special here either. With a
> > plain capability-bit system, you could allow for
> > user-defined aliases that map to multiple bits.
> > In some random /etc config file:
> > 
> > define ADMIN := FOO | BAR | BAZ
> 
> This doesn't effect the inflexibility of a single definition for domain
> transistion that's inherent in the capabilty system.

Sure. I already noted this.

> > Lack of granularity is an implementation detail.
> > (Blame the SGI folks that wouldn't listen to me.)
> > Lack of granularity is not a design flaw.
> 
> It's a design flaw.  More bits won't help.  There's an important missing
> piece...credentials for both subject and object.  Both of which can be
> dynamic, and differ per subject's view of an object.

There is no meaningful object.

subject: process 12345
object: ??????
operation: lock memory

For a few capability bits, there is a meaningful object
and you could use SELinux in place of the capability bits.
For most of the capability bits, this is not the case.

> > What I'm looking for:
> > 
> > 1. configure the kernel by ...
> > 2. ensure that /bin/foo runs early in boot
> > 3. put "blah blah blah" in /etc/foo.conf
> > 
> > That is, is there a small set of simple config files
> > and binaries that I could just slap onto an existing
> > system to ensure that a particular app is granted an
> > extra capability bit?
> > 
> > If yes, then the ugly old-Oracle hack is not needed.
> 
> Nearly.  There's the minor issue that execve() clears that bit more
> agressively than desired for non-root processes.  Otherwise pam can do
> it with pam_cap.  Which is all we're trying to fix here.

Stephen Smalley suggested that SELinux could take the
place of our capability bits. So I'm asking how you do
that, using the most minimal SELinux config.

If he really has a way, then there is no need to change
the execve() behavior in the Linux 2.6.x kernels.

Perhaps we just need an LSM hook to re-add the capability
bit after execve() drops it. That's a tiny change that
doesn't affect any existing system.



