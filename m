Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291349AbSAaV6D>; Thu, 31 Jan 2002 16:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291353AbSAaV5y>; Thu, 31 Jan 2002 16:57:54 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:241 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291354AbSAaV5d>;
	Thu, 31 Jan 2002 16:57:33 -0500
Date: Thu, 31 Jan 2002 14:56:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        lm@bitmover.com
Subject: Re: real BK usage (was: A modest proposal -- We need a patch penguin)
Message-ID: <20020131145655.W763@lynx.adilger.int>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net> <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there> <20020130034746.K32317@havoc.gtf.org> <a38ekv$1is$1@penguin.transmeta.com> <20020130050708.D11267@havoc.gtf.org> <20020130102458.B763@lynx.adilger.int> <20020130093459.P23269@work.bitmover.com> <20020130130319.G763@lynx.adilger.int> <20020131091110.K1519@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020131091110.K1519@work.bitmover.com>; from lm@bitmover.com on Thu, Jan 31, 2002 at 09:11:10AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 31, 2002  09:11 -0800, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 01:03:19PM -0700, Andreas Dilger wrote:
> > Yes, technically it works fine, but practically not.  For example, I want
> > to test _all_ of the changes I make, and to test them each individually
> > is a lot of work.  Putting them all in the same tree, and testing them
> > as a group is a lot less work.  More importantly, this is how people do
> > their work in real life, so we don't want to change how people work to
> > fit the tool, but vice versa.
> 
> This thread has been about the idea of being able to send any one of those
> changes out in isolation, right?  That's the problem we are solving.

But what you are proposing is that I keep N trees for each of my N changes
against the baseline, keep all of those N trees up-to-date, compile
and reboot each of the N kernels for each local or upstream change, and
possibly have N! different kernels to test each combination of changes.

> But your statement is that you want to test them all at once, testing
> them one at a time is too much work.

I guess I wasn't very clear then.  I will probably test changes I make
in _order_, but not necessarily in _isolation_.  I may also not test
_every_ change I make individually if it is fairly minor and "obvious".
If the changes are orthogonal, testing kernel+A and testing kernel+A+B
should be enough to tell me that B works without A.  That means I should
be able to send out B without everyone needing A in order to test it.

> Doesn't that mean that you don't even know if these changes compile, let
> alone run, when you send them out individually?  You haven't tested them,
> you've only tested the set of them as one unit.

It boils down to "how much testing is enough" for each of the separate
changes.  Is eyeballing them enough?  Is compiling enough?  Is a single
reboot enough?  I don't have N machines, let alone N!, to test each of
the N changes I have in my tree individually.

There is also value in saying "I've had this patch in my kernel for X
{days,weeks,months} and it works fine", and by your statement above I
could only do this with a single change.

What I'm saying is that I will code a specific change A, test it, and then
usually go on to code the next change B in the tree that has A in it.
Yes, in some cases testing B in isolation is needed (big changes, or
changes which need to be benchmarked in isolation).  In general you
wouldn't make change A if it wasn't worthwhile, and after it's done why
would you not want to continue using it?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

