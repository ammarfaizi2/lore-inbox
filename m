Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318167AbSGWSrg>; Tue, 23 Jul 2002 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSGWSrf>; Tue, 23 Jul 2002 14:47:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17999 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318167AbSGWSrf>; Tue, 23 Jul 2002 14:47:35 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Roger Gammans <roger@computer-surgery.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk>
	<20020722102930.A14802@lst.de> <20020722102705.GB21907@lukas>
	<20020722152031.GB692@opus.bloom.county>
	<20020722232941.A10083@computer-surgery.co.uk>
	<20020722154443.E19057@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Jul 2002 12:38:54 -0600
In-Reply-To: <20020722154443.E19057@work.bitmover.com>
Message-ID: <m1y9c2mgqp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Mon, Jul 22, 2002 at 11:29:41PM +0100, Roger Gammans wrote:
> > On Mon, Jul 22, 2002 at 08:20:31AM -0700, Tom Rini wrote:
> > > Possibly, once bitkeeper allowes ChangeSets to only depend on what they
> > > actually need, not every previous ChangeSet in the repository.  IIRC,
> > > this was one of the things Linus asked for, so hopefully it will happen.
> > 
> > While that would be great.
> > 
> > With all due respect to Larry and the bk team, I think you'll
> > find determining 'needed changesets' in this case is a _hard_ problem.
> 
> Thanks, we agree completely.  It's actually an impossible problem
> for a program since it requires semantic knowledge of the content
> under revision control.  And even then the program can get it wrong
> (think about a change which shortens the depth of the stack followed by
> a change that won't work with the old stack depth, now you export that
> to the other tree and it breaks yet it worked in the first tree).

Perfection is impossible.  However there is a lot of independent code
in the linux kernel.  It has to be that way or maintenance would quickly
become impossible.  

The last time this was suggested, the idea was to look how far back into
the repository  (up to a given limit) a current changeset could apply, with all
of it's current dependencies. 

But beyond that I suspect it would be easier to declare lack of dependencies.

drivers/net and drivers/ide are completely separate subtrees.  At
least not until you get ATA over ip.  And even then the dependencies
is with the ip layer.  

Maybe independence should be shown by putting each independent chunk
into it's own repository.  And then building a working kernel tree 
would just be a matter of checking out all of the parallel
repositories, into the appropriate location.  Then the global tree
can just remember which version of all of the subtrees it was
tested with last.

Given that a fully independent program is likely to break because of
a buggy libc (which I have no business depending upon the exact
version), I think the insistence on global dependencies is just plain
silly, you can never find the entire set of dependencies.  

So Larry please cope with the fact that perfect dependency modeling is
impossible, and setup a method that works in the real world.  Or do
you have a way to model that my code only works on a magic test
machine, that magically catches a page fault, and does the right
thing, while all other machines page fault reliably?

Eric
