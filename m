Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWBIUM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWBIUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWBIUMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:12:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32965 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750754AbWBIUMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:12:25 -0500
Date: Thu, 9 Feb 2006 12:12:18 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation V3
In-Reply-To: <200602092105.04412.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602091209220.9952@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602091152300.9941@schroedinger.engr.sgi.com>
 <200602092105.04412.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006, Andi Kleen wrote:

> > - Do not return NULL and therefore do not change the return values of
> >   __alloc_pages.
> 
> Hmm, to make this work well i guess mmap() would need to be changed
> to take the policy into account when doing the !MAP_NORESERVE checking
> when the kernel runs in strict no overcommit mode.
> Otherwise there is no fool proof way an application can prevent getting killed.

There is no fool proof way right now for the MPOL_BIND case. 

> And mbind() would need to recompute it and fail if the new policy's possible
> allocation are not guaranteed to work.

Well we need to fix that but the patch does not introduce the problem.

> Doing this all properly would probably get quite messy.

I'd say making overcommit working nicely with MPOL_BIND is yet another 
fundamental issue for the policy layer but it does not matter for this 
patch.
