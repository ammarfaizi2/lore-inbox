Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVD0N5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVD0N5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVD0N5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:57:51 -0400
Received: from gate.in-addr.de ([212.8.193.158]:64446 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261597AbVD0N4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:56:46 -0400
Date: Wed, 27 Apr 2005 15:56:35 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050427135635.GA4431@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050425210915.GX32085@marowsky-bree.de> <200504260130.17016.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504260130.17016.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-26T01:30:16, Daniel Phillips <phillips@istop.com> wrote:

> > Now that we have two (or three) options with actual users, now is
> > the right time to finally come up with sane and useful abstractions.
> > This is great.
> Great thought, but it won't work unless you actually read them all,
> which I hope is what you're proposing.

Sure. As time permits ;-)

> I'm a little skeptical about the chance of fitting an 11-parameter function 
> call into a generic kernel plug-in framework.  Are those the exact same 11 
> parameters that God intended?

An 11-parameter function, frankly, more often than not indicates that
the interface is wrong. I know it's inherited from VMS, which is a
perfectly legitimate reason, but I assume it might get cleaned / broken
up in the future.

> While it would be great to share a single dlm between gfs and ocfs2 - maybe 
> Lustre too - my crystal ball says that that laudable goal is unlikely to be 
> achieved in the near future, whereas there isn't much choice but to sort out 
> a common membership framework right now.

Oh, sure. I just like to keep a long term vision in mind, an idea I'd
think you approve of. ;-)

Also I didn't say that they should necessarily _share_ a DLM; I assume
there'll be more than one, just like we have more than one filesystem.
But, can this be mapped to a common subset of features which an
application/user/filesystem can assume to be present in every DLM,
accessed via a common API? This does not preclude the option that one
DLM will perform substantially better for some user than another one, or
that one DLM takes advantage of some specific hardware feature which
makes it run a magnitude faster on the z-Series for example.

As I said, this is not something to do right now, but something to keep
in mind going forward, but to keep in mind at every step.

> As far as I can see, only cluster membership wants or needs a common 
> framework.  And I'm not sure that any of that even needs to be in-kernel.

Well, right now nobody proposes the membership to be in-kernel. What I'd
like to see though is a common way of _feeding_ the membership to a
given kernel component, and being able to query the kind of syntax &
semantics it expects.

Note that I said "given kernel component", because I assume from the
start that a node might be part of several overlapping clusters. The
membership I feed to the GFS DLM might not be the same I feed to OCFS2
for another mount.

Questions which need to be settled, or which the API at least needs to
export so we know what is expected from us:

- How do the node ids look like? Are they sparse integers, continuous
  ints, uuids, IPv4 or IPv6 address of the 'primary' IP of a node,
  hostnames...?

- How are the communication links configured? How to tell it which
  interfaces to use for IP, for example?

- How do we actually deliver the membership events -
  echo "current node list" >/sys/cluster/gfs/membership
  or...?
  
- What kind of semantics are expected: Can we deliver the membership
  events as they come, do we need to introduce suspend/resume barriers
  etc?

- How to security credentials play into this, and where are they
  enforced - so that a user-space app doesn't mess with kernel locks?

Maybe initially we'll end up with those being "exported" in
Documentation/{OCFS2,GFS}-DLM/ files, but ultimately it'd be nice if
user-space could auto-discover them and do the right thing w/a minimum
amount of configuration.

Or maybe these will be abstracted by user-space wrapper libraries, and
everybody does in the kernel what they deem best.

It's just something which needs to be answered and decided ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

