Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUGKVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUGKVIu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 17:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUGKVIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 17:08:50 -0400
Received: from gate.in-addr.de ([212.8.193.158]:46750 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S264405AbUGKVIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 17:08:47 -0400
Date: Sun, 11 Jul 2004 23:06:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>, sdake@mvista.com
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040711210624.GC3933@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407111544.25590.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-11T15:44:25,
   Daniel Phillips <phillips@istop.com> said:

> Unless you can prove that your userspace approach never deadlocks, the other 
> questions don't even move the needle.  I am sure that one day somebody, maybe 
> you, will demonstrate a userspace approach that is provably correct.  

If you can _prove_ your kernel-space implementation to be correct, I'll
drop all and every single complaint ;)

> Until then, if you want your cluster to stay up and fail over
> properly, there's only one game in town.  

This however is not true; clusters have managed just fine running in
user-space (realtime priority, mlocked into (pre-allocated) memory
etc).

I agree that for a cluster filesystem it's much lower latency to have
the infrastructure in the kernel. Going back and forth to user-land just
ain't as fast and also not very neat.

However, the memory argument is pretty weak; the memory for
heartbeating and core functionality must be pre-allocated if you care
that much. And if you cannot allocate it, maybe you ain't healthy enough
to join the cluster in the first place.

Otherwise, I don't much care about whether it's in-kernel or not.

My main argument against being in the kernel space has always been
portability and ease of integration, which makes this quite annoying for
ISVs, and the support issues which arise. But if it's however a common
component part of the 'kernel proper', then this argument no longer
holds.

If the infrastructure takes that jump, I'd be happy. Infrastructure is
boring and has been solved/reinvented so often there's hardly anything
new and exciting about heartbeating, membership, there's more fun work
higher up the stack.

> > There is one more advantage to group messaging and distributed
> > locking implemented within the kernel, that I hadn't originally
> > considered; it sure is sexy.
> I don't think it's sexy, I think it's ugly, to tell the truth.  I am
> actively researching how to move the slow-path cluster infrastructure
> out of kernel, and I would be pleased to work together with anyone
> else who is interested in this nasty problem.

Messaging (which hopefully includes strong authentication if not
encryption, though I could see that being delegated to IPsec) and
locking is in the fast-path, though.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

