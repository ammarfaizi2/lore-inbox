Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVD1Xmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVD1Xmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVD1Xmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:42:37 -0400
Received: from smtp.istop.com ([66.11.167.126]:13251 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262331AbVD1Xme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:42:34 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Thu, 28 Apr 2005 19:43:12 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20050425165826.GB11938@redhat.com> <200504272252.55525.phillips@istop.com> <20050428123720.GQ21645@marowsky-bree.de>
In-Reply-To: <20050428123720.GQ21645@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504281943.12436.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 08:37, Lars Marowsky-Bree wrote:
> On 2005-04-27T22:52:55, Daniel Phillips <phillips@istop.com> wrote:
> > > So we can't deliver it raw membership events. Noted.
> >
> > Just to pick a nit: there is no way to be sure a membership event might
> > not still be on the way to the dead node, however the rest of the cluster
> > knows the node is dead and can ignore it, in theory.  (In practice, only
> > (g)dlm and gfs are well glued into the cman membership protocol, and
> > other components, e.g., cluster block devices and applications, need to
> > be looked at with squinty eyes.)
>
> I'm sorry, I don't get what you are saying here. Could you please
> clarify?
>
> "Membership even on the way to the dead node"? ie, you mean that the
> (now dead) node hasn't acknowledged a previous membership which still
> included it, because it died inbetween? Well, sure, membership is never
> certain at all; it's always in transition, essentially, because we can
> only detect faults some time after the fact.

Exactly, and that is what the barriers are for.  I like the concept of 
barriers a whole lot.  We should put this interface on a pedestal and really 
dig into how to use it, or even better, how to optimize it.

But for now, as I understand it, a cluster client's view of the cluster world 
is entirely via cman events, which include things like other nodes joining 
and leaving service groups.  (Service groups are another interface we need to 
put on a pedestal, and start working on, because right now it's a clean idea, 
not thought all the way through.)

> (It'd be cool if we could mandate nodes to pre-announce failures by a
> couple of seconds, alas I think that's a feature you'll only find in an
> OSDL requirement document, rated as "prio 1" ;-)

Heh, I generally think about failing over in less than a second, preferably 
much, much less.  Maybe you just have to scale your heuristic a little?

> I also don't understand what you're saying in the second part. How are
> gdlm/gfs "well glued" into the CMAN membership protocol, and what are we
> looking for when we turn our squinty eyes to applications...?

Gdlm and gfs are well-glued because Dave and Patrick have been working on it 
for years.  Other components barely know about the interfaces, let alone use 
them correctly.  In the end _every component_ of the cluster stack has to do 
the dance correctly on every node.  We've really only just started on that 
path.  Hopefully we'll be able to move down it much more quickly now that the 
code is coming out of the cathedral.

Regards,

Daniel
