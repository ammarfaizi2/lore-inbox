Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVCCCsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVCCCsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCCCpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:45:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:1696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVCCCmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:42:17 -0500
Date: Wed, 2 Mar 2005 18:41:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302184153.53610b88.akpm@osdl.org>
In-Reply-To: <16934.26602.88841.50950@cse.unsw.edu.au>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<16934.22078.129692.140147@cse.unsw.edu.au>
	<20050302164847.294e7bca.akpm@osdl.org>
	<16934.26602.88841.50950@cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> On Wednesday March 2, akpm@osdl.org wrote:
> > 
> > Only davem, AFAIK.  All the other trees get auto-sucked into -mm for
> > testing. 
> 
> Ok, I got the feeling it was more wide spread than that, but I
> apparently misread the signs (people mentioning that had 'patches
> queued for Linus' and such).

I'd like to get my sticky paws onto Dave's tree actually, but haven't got
around to hassling.  He doesn't buffer much, or for very long anwyay.

> >           Generally the owners of those trees make the decision as to which
> > of their code has been sufficiently well-tested for a Linus merge, and when
> > that should happen.
> 
> I wonder if there is a problem here.
> Who is in a position to judge when a patch is ready to be merged?
> I suspect that it would be hard for a developer to be objective about
> the readiness of their own patches (I know all my patches are perfectly
> ready the moment I create them, despite what experience tells me :-)

True.  But if someone tries a big push when we're after -rc1 it will get
extra attention.  Basically, nobody does that.

> Assuming we have a 'stable', a 'testing' and a 'devel' series
> (whatever actual numbering gets used for them(*)), then maybe it is ok
> for a developer to judge if it is ready for 'testing', but it should
> really have either some minimum time in 'testing' or independent
> review before being allowed into 'stable'.
> 
> Are you and Linus able to handle the independent review load?

No.  That's why I'm always spamming people and asking them to ack stuff.

I don't think Linus or I pay much attention to patches which come in via
-bk trees - if the owners of those trees break them, they get to fix them.

That does leave open the problem that people can merge crappy code which
happens to work.  That's what hch is for ;)

Really, to a large extent the kernel doesn't use the "dictator" model any
more.  It's more like the "various people have commit permissions" model,
only they don't actually autonomously do a physical commit.

> Should every developer/maintainer find someone to review any patches
> that they think should 'jump the queue'.

Queue-jumping is a pain, and we should only do it with good reason.

That being said, kernel development is remarkably decoupled, in that there
is rarely overlap between the various subsystems.  Otherwise I couldn't sit
on up to 900 patches all the time.  Sometimes there is overlap between the
32 bk trees, and I'll usually tell people so that it gets sorted out.

Reviewing is important, and it's a bit of a problem that patches can get
merged into the mainline tree via this particular path:

 developer
 -> subsystem maintainer (maybe cc'ed to obscure mailing list)
    -> Couple of weeks in -mm for testing
    -> Linus via bk pull

This bypasses the main review site: linux-kernel.  Because the people on
<obscure mailing list> may not have the motivation/skills/experience.  And
things do sneak through.  Greg usually cc's linux-kernel on stuff as he
sends it to Linus, which is good.  But it's a problem.

Good changelogging really helps the review process.  If the submitter can
skilfully tell the reviewer what the patch does, why and how then the
review process becomes largely a matter of checking that the patch does
what he meant it to do.  The _understanding_ process happens while you read
the changelog.  In an ideal world.


> (Would anyone like to review my nfs/raid patches for me?  I review
> patches I get from others, but find it very hard to review my own
> work.  Andrew does a good job, but does miss things sometimes). 

Yes, it's hard.  If one is lucky, it's "hey, that locking looks funny". 
And, usually, "your coding style is sucky".  But apart from that, one needs
to be pretty heavily involved in the particular area to comment usefully.

So I think your question should be rephrased as "would anyone else like to
become nfsd/raid developers".
