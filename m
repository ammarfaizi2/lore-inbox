Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUGFHfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUGFHfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 03:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGFHfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 03:35:18 -0400
Received: from gate.in-addr.de ([212.8.193.158]:31162 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263640AbUGFHfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 03:35:03 -0400
Date: Tue, 6 Jul 2004 09:34:45 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040706073444.GB19892@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407051442.27397.phillips@redhat.com> <20040705191204.GE6845@marowsky-bree.de> <200407051627.51790.phillips@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407051627.51790.phillips@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-05T16:27:51,
   Daniel Phillips <phillips@redhat.com> said:

> > Indeed. If your efforts in joining the infrastructure are more
> > successful than ours have been, more power to you ;-)
> 
> What problems did you run into?

The problems were mostly political. Maybe we tried to push too early,
but 1-3 years back, people weren't really interested in agreeing on some
common components or APIs. In particular a certain Linux vendor didn't
even join the group ;-) And the "industry" was very reluctant too. Which
meant that everybody spend ages talking and not much happening.

However, times may have changed, and hopefully for the better. The push
to get one solution included into the Linux kernel may be enough to
convince people that this time its for real...

There still is the Open Clustering Framework group though, which is a
sub-group of the FSG and maybe the right umbrella to put this under, to
stay away from the impression that it's a single vendor pushing.

If we could revive that and make real progress, I'd be as happy as a
well fed penguin.

Now with OpenAIS on the table, the GFS stack, the work already done by
OCF in the past (which is, admittedly, depressingly little, but I quite
like the Resource Agent API for one) et cetera, there may be a good
chance.

I'll try to get travel approval to go to the meeting. 

BTW, is the mailing list working? I tried subscribing when you first
announced it, but the subscription request hasn't been approved yet...
Maybe I shouldn't have subscribed with the suse.de address ;-)

> On a quick read-through, it seems quite straightforward for quorum, 
> membership and distributed locking.

Believe me, you'd be amazed to find out how long you can argue on how to
identify a node alone - node name, node number (sparse or continuous?),
UUID...? ;-)

And, how do you define quorum, and is it always needed? Some algorithms
don't need quorum (ie, election algorithms can do fine without), so a
membership service which only works with quorum isn't the right
component etc...

> The idea of having more than one node fencing system running at the same 
> time seems deeply scary, we'd better make some effort to come up with 
> something common.

Yes. This is actually an important point, and fencing policies are also
reasonably complex. The GFS stack seems to tie fencing quite deeply into
the system (which is understandable, since you always have shared
storage, otherwise a node wouldn't be part of the GFS domain in the
first place).

However, the new dependency based cluster resource manager we are
writing right now (which we simply call "Cluster Resource Manager" for
lack of creativity ;) decides whether or not it needs to fence a node
based on the resources in the cluster - if it isn't affecting the
resources we can run on the remaining nodes, or none of the resources
requires node-level fencing, no such operation will be done. 

This has advantages in larger clusters (where, if split, each partition
could still continue to run resources which are unaffected by the split
even the other nodes cannot be fenced), in shared nothing clusters or
resources which are self-fencing and do not need STONITH etc.

The ties between membership, quorum and fencing are not as strong in
these scenarios, at least not mandatory. So a stack which enforced
fencing at these levels, and w/o coordinating with the CRM first, would
not work out.

And by pushing for inclusion into the main kernel, you'll also raise all
sleeping zom^Wbeauties. I hope you have a long breath for the
discussions ;-)

There's lots of work there.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

