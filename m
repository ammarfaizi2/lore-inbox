Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWGZTrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWGZTrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWGZTrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:47:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55242 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751112AbWGZTrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:47:23 -0400
Date: Wed, 26 Jul 2006 12:47:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <44C7C46C.4090201@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0607261239170.7520@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
 <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI>
 <20060726105204.GF9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
 <44C7AF31.9000507@colorfullife.com> <Pine.LNX.4.64.0607261118001.6608@schroedinger.engr.sgi.com>
 <44C7B842.5060606@colorfullife.com> <Pine.LNX.4.64.0607261153220.6896@schroedinger.engr.sgi.com>
 <44C7C261.6050602@colorfullife.com> <Pine.LNX.4.64.0607261229430.7132@schroedinger.engr.sgi.com>
 <44C7C46C.4090201@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Manfred Spraul wrote:

> Christoph Lameter wrote:
> 
> > A slab user is setting alignment in order to optimize performance not for
> > correctness. Most users that I know of can live with misalignments. If that
> > would not be the case then this code would never have worked.
> >  
> 
> Which users do you know that set align and that can live with misalignments?
> As I wrote, there are no such users in my (i386) kernel.

The users of SLAB_HWCACHE_ALIGN can live with that.

Systems running with slab debugging on must be very buggy at this point or 
we were very lucky:

The list is a bit strange:

>* the pmd structure (4096: hardware requirement)

It is already exempted from debug since the size is 4096.

>* the pgd structure (32 bytes: hardware requirement)

We were lucky on that one in the past? This should break.

>* the task structure (16 byte. fxsave)

Would only break if floating point is used I think.

>* sigqueue, pid: both request 4 byte alignment (based on __alignof__()). 
>Doesn't affect debugging.
So also not relevant.


We now want to say that SLAB_HWCACHE_ALIGN is only a suggestion to be 
disposed of if debug is on whereas an explicitly specified alignment must be enforced?

