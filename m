Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbSLEEjy>; Wed, 4 Dec 2002 23:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267214AbSLEEjy>; Wed, 4 Dec 2002 23:39:54 -0500
Received: from holomorphy.com ([66.224.33.161]:27016 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267213AbSLEEjw>;
	Wed, 4 Dec 2002 23:39:52 -0500
Date: Wed, 4 Dec 2002 20:47:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021205044717.GE9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEED6FA.B179FAFD@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 08:32:58PM -0800, Andrew Morton wrote:
> Where in the kernel is such a large number of 4-, 8- or 16-byte
> objects being used?
> The slab allocator will support caches right down to 1024 x 4-byte
> objects per page.  Why is that not appropriate?
> If it is for locality-of-reference between individual objects then
> where in the kernel is this required, and are performance measurements
> available?  It is very unusual to have objects which are so small,
> and a better design would be to obtain the locality of reference
> by aggregating the data into an array or structure.

I will argue not on the frequency of calls but on the preciousness of
space; highmem feels very serious pain when internal fragmentation
of pinned pages occurs (which this is designed to prevent). I don't
have direct experience with this patch/API, but I can say that
fragmentation in ZONE_NORMAL is deadly (witness pagetable occupancy
vs. ZONE_NORMAL consumption, which motivated highpte, despite my
pagetable reclamation smoke blowing).


Bill
