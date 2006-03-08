Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWCHXIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWCHXIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWCHXIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:08:54 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:63172 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1030277AbWCHXIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:08:52 -0500
Date: Thu, 9 Mar 2006 02:08:51 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       Alan Cox <alan@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060309020851.D9651@jurassic.park.msu.ru>
References: <20060308154157.GI7301@parisc-linux.org> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <10095.1141838381@warthog.cambridge.redhat.com> <17423.22121.254026.487964@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17423.22121.254026.487964@cargo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Mar 09, 2006 at 09:10:49AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 09:10:49AM +1100, Paul Mackerras wrote:
> David Howells writes:
> 
> > > # define smp_read_barrier_depends()     do { } while(0)
> > 
> > What's this one meant to do?
> 
> On most CPUs, if you load one value and use the value you get to
> compute the address for a second load, there is an implicit read
> barrier between the two loads because of the dependency.  That's not
> true on alpha, apparently, because of the way their caches are
> structured.

Who said?! ;-)

> The smp_read_barrier_depends is a read barrier that you
> use between two loads when there is already a dependency between the
> loads, and it is a no-op on everything except alpha (IIRC).

My "Compiler Writer's Guide for the Alpha 21264" says that if the
result of the first load contributes to the address calculation
of the second load, then the second load cannot issue until the data
from the first load is available.

Obviously, we don't care about earlier alphas as they are executing
strictly in program order.

Ivan.
