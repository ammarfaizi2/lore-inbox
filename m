Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTKFNWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTKFNWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:22:32 -0500
Received: from thunk.org ([140.239.227.29]:58778 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263545AbTKFNWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:22:31 -0500
Date: Thu, 6 Nov 2003 08:22:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: bert hubert <ahu@ds9a.nl>, Scott Robert Ladd <coyote@coyotegulch.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031106132212.GA23624@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, bert hubert <ahu@ds9a.nl>,
	Scott Robert Ladd <coyote@coyotegulch.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com> <20031105230350.GB12992@work.bitmover.com> <3FA9C974.3010002@coyotegulch.com> <20031106100606.GA23891@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106100606.GA23891@outpost.ds9a.nl>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 11:06:07AM +0100, bert hubert wrote:
> On Wed, Nov 05, 2003 at 11:09:24PM -0500, Scott Robert Ladd wrote:
> 
> > In other words, the theoretical exploit was inserted by someone clever. 
> > Do we have any idea who?
> 
> And, was there any route via which this malicious patch could've worked
> itself into a kernel release?

Not an official one, but maybe if some distribution was using the
secondary CVS repository instead of the primary BK repository.  

(For people who think this is somehow a BK vs. CVS unfairness, it's
probably true --- remote's CVS's security properties are only best
described as terrifying.  "CVS is not the answer.  CVS is the
question.  'NO' is the answer...."  :-)

To be fair, though, BK really needs to add per-changeset digital
signatures, and I've been bugging Larry about this for years.  :-) And
there's a similar risk involving a subtle patch that claims to fix a
bug, but really opens up a security hole.  Someone clever enough to
send a "patch" to Linus, who can forge sufficient mail headers that he
doesn't notice --- and perhaps even forge a cc to the LKML, even
though it never got sent there, might be able to sneak such a minor
change into the master sources.  This is especially true if the trojan
horse gets burried in a number of other plausible changes, and had an
SMTP from field that appeared to come from a trusted kernel developer.

An argument might be made that all patches sent to Linus should be at
a minimum be GPG signed, but that assumes that Linus would be willing
to use GPG, or is willing to have his mail reader set upt to do
automatic GPG verification.  One of the reasons why I think
integration with BK would be a Good Thing is that (a) it becomes
automatic, and (b) instead of it being verified only by Linus when he
receives the patch, I or anyone else can verify the digital signature
on each changeset whenever we want.  This distributed verfication is
very powerful, and hopefully this points out why we badly need such a
capability.

						- Ted

P.S.  And once we have GPG signatures in BK, Larry could access
control lists that would only allow certain trusted key holders from
submitting changesets which modify the BK triggers script directory.
Why this is important is left as an exercise to the reader....  (And
before someone asks, CVS has the exact same vulnerability; in fact,
it's arguable that it's even worse in CVS.)
