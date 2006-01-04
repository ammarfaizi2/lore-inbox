Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWADLWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWADLWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWADLWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:22:17 -0500
Received: from mx1.suse.de ([195.135.220.2]:40072 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751699AbWADLWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:22:17 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
Date: Wed, 4 Jan 2006 12:22:09 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20051108185349.6e86cec3.akpm@osdl.org> <200601041215.36627.ak@suse.de> <43BBAF37.3060108@cosmosbay.com>
In-Reply-To: <43BBAF37.3060108@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601041222.09304.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 12:19, Eric Dumazet wrote:
> Andi Kleen a écrit :
> > On Wednesday 04 January 2006 12:13, Eric Dumazet wrote:
> >> Andi Kleen a écrit :
> >>> Eric Dumazet <dada1@cosmosbay.com> writes:
> >>>> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
> >>>> platforms, lowering kmalloc() allocated space by 50%.
> >>> It should be probably a kmem_cache_alloc() instead of a kmalloc
> >>> in the first place anyways. This would reduce fragmentation.
> >> Well in theory yes, if you really expect thousand of tasks running...
> >> But for most machines, number of concurrent tasks is < 200, and using a 
> >> special cache for this is not a win.
> > 
> > It is because it avoids fragmentation because objects with similar livetimes
> > are clustered together. In general caches are a win
> > if the data is nearly a page or more.
> 
> I dont undertand your last sentence. Do you mean 'if the object size is near 
> PAGE_SIZE' ?

Total data of all objects together. That's because caches always get their
own pages and cannot share them with other caches. The overhead of the kmem_cache_t 
by itself is negligible.

-Andi
