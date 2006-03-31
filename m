Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWCaR4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWCaR4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCaR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:56:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32966 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932165AbWCaR4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:56:34 -0500
Date: Fri, 31 Mar 2006 09:56:23 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <200603311948.38218.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0603310952540.6825@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
 <p73vetu921a.fsf@verdi.suse.de> <Pine.LNX.4.64.0603310943480.6628@schroedinger.engr.sgi.com>
 <200603311948.38218.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Andi Kleen wrote:

> > Powerpc can do similar things AFAIK. Not sure what other arches have 
> > finer grained control over barriers but it could cover a lot of special 
> > cases for other processors as well.
> 
> Yes, but I don't think the goal of a portable atomic operations API
> in Linux is it to cover everybody's special case in every possible 
> combination. The goal is to have an abstraction that will lead to 
> portable code. I don't think your proposal will do this.

AFAIK The goal of a bitmap operations API (we are not talking about atomic 
operations here) is to make bitmap operations as efficient as possible and 
as simple as possible. We already have multiple special cases for each 
bitmap operation

I.e.

clear_bit()
__clear_bit()

and some people talk abouit

clear_bit_lock()
clear_bit_unlock()

What I am prosing is to do one clear_bit_mode function that can take a 
parameter customizing its synchronization behavior.

clear_bit_mode(bit,addr,mode)

