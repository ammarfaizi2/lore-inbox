Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVD1M5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVD1M5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 08:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVD1M4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 08:56:13 -0400
Received: from gate.in-addr.de ([212.8.193.158]:52949 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262102AbVD1MzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 08:55:22 -0400
Date: Thu, 28 Apr 2005 14:55:12 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050428125512.GR21645@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de> <200504280249.04735.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504280249.04735.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-28T02:49:04, Daniel Phillips <phillips@istop.com> wrote:

> > Just some food for thought how this all fits together rather
> > neatly.
> 
> It's actually the membership system that glues it all together.  The
> dlm is just another service.

Membership is one of the lowest level and high privileged inputs to the
whole picture, of course.

However, "membership" is already a pretty broad term, and one must
clearly state what one is talking about. So we're clearly focused on
node membership here, which is a special case of group membership; the
top-level, sort of. 

Then every node has it's local view of node membership, constructed
typically from observing node heartbeats.

Then the nodes communicate to reach concensus on the coordinated
membership, which will usually be a set of nodes with full N:N
connectivity (via the cluster messaging mechanism); and they'll also
usually aim to identify the largest possible set.

Eventually, there'll be a membership view which also implies certain
shared data integrity guarantees if appropriate (ie, fencing in case a
node didn't go down cleanly, and granting access on a clean join).

These steps but the last one usually happen completely internal to the
membership layer; the last one requires coordination already, because
the fencing layer itself might need recovery before it can fence
something after a node failure.

And then there's quorum computation.

Certainly you could also try looking at it from a membership-centric
angle, but the piece which coordinates the recovery of the various
components which makes sure the right kind of membership events are
delivered in the proper order, and errors during component recovery are
appropriately handled, is, I think, pretty much distinct from the
"membership" and a higher level component. 

So I'm not sure I'd buy "the membership is what glues it all together"
on eBay even for a low starting bid.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

