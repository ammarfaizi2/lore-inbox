Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWH2Rg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWH2Rg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWH2Rg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:36:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58275 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965174AbWH2Rg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:36:27 -0400
Date: Tue, 29 Aug 2006 10:36:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <200608291922.04354.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608291033380.19174@schroedinger.engr.sgi.com>
References: <44F395DE.10804@yahoo.com.au> <11861.1156845927@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
 <200608291922.04354.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006, Andi Kleen wrote:

> On Tuesday 29 August 2006 17:56, Christoph Lameter wrote:
> > On Tue, 29 Aug 2006, David Howells wrote:
> > 
> > > Because i386 (and x86_64) can do better by using XADDL/XADDQ.
> > 
> > And Ia64 would like to use fetchadd....
> 
> This might be a dumb question, but I would expect even on altix 
> with lots of parallel faulting threads rwsem performance be basically
> limited by aquiring the cache line and releasing it later to another CPU.

Correct. However, a cmpxchg may have to acquire that cacheline multiple 
times in a highly contented situation. A fetchadd acquires the cacheline 
only once.

> Do you really think it will make much difference what particular atomic
> operation is used? The basic cost of sending the cache line over the
> interconnect should be all the same, no? And once the cache line is local
> it should be reasonably fast either way.

We have long tuned that portion of the code and therefore we are 
skeptical of changes. But if we cannot measure a difference to a 
generic implemenentation then it would be okay.

