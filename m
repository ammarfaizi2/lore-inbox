Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWBUSeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWBUSeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBUSeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:34:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31424 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932387AbWBUSeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:34:00 -0500
Date: Tue, 21 Feb 2006 10:33:44 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [patch] Cache align futex hash buckets
In-Reply-To: <43FA8938.70006@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Nick Piggin wrote:

> Ravikiran G Thirumalai wrote:
> > Following change places each element of the futex_queues hashtable on a
> > different cacheline.  Spinlocks of adjacent hash buckets lie on the same
> > cacheline otherwise.
> > 
> 
> It does not make sense to add swaths of unused memory into a hashtable for
> this purpose, does it?

It does if you essentially have a 4k cacheline (because you are doing NUMA 
in software with multiple PCs....) and transferring control of that 
cacheline is comparatively expensive.
