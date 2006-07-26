Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWGZQZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWGZQZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWGZQZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:25:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35530 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751683AbWGZQZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:25:28 -0400
Date: Wed, 26 Jul 2006 09:25:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <84144f020607260843i15247ddai7f447f0d9422fec5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607260916110.5962@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com> 
 <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com> 
 <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261529240.20519@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260823160.5647@schroedinger.engr.sgi.com>
 <84144f020607260843i15247ddai7f447f0d9422fec5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pekka Enberg wrote:

> On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
> > We intentionally discard the caller mandated alignment for debugging
> > purposes.
> 
> Disagreed. The caller mandated alignment is not a hint. It is the
> required minimum alignment for objects.

This has been with the slab for a long time. Lots of alignments are now
ignored for the debugging case without a problem. Manfred intentionally
put that in. Alignments passed to kmem_cache_create are there for
performance reasons and not because unaligned object break the arch code.
 
> On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
> > And it changes the basic way that slab debugging works.
> 
> Look at kmem_cache_create, we turn off debugging for both caller and
> architecture mandated alignments already and the only reason we are
> not doing it for Heiko is because the architecture recommended default
> alignment is so large.

We discard alignment for FORCED_DEBUG unless

1. object size > 4096

2. If the object size would increase unreasonably.

I simply added another case. That preseves the discarding of alignment for 
the FORCED_DEBUG case but allows an override if operations would be 
impossible for not correctly aligned objects for certain caches (like in 
the S/390 case).
