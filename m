Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVCRKME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVCRKME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 05:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVCRKME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 05:12:04 -0500
Received: from colin2.muc.de ([193.149.48.15]:27407 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261555AbVCRKMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 05:12:02 -0500
Date: 18 Mar 2005 11:12:00 +0100
Date: Fri, 18 Mar 2005 11:12:00 +0100
From: Andi Kleen <ak@muc.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Christoph Lameter <clameter@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
Message-ID: <20050318101200.GA79386@muc.de>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com> <1110490683.24355.17.camel@localhost> <Pine.LNX.4.58.0503101702120.15940@schroedinger.engr.sgi.com> <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi Kleen (iirc) says that non-temporal stores seem to be
> big win in microbenchmarks (and I second that), but they are
> a net loss when we are going to use zeroed page just after
> zeroing. He recommends avoid using non-temporal stores

The rule of thumb is to only use non temporal stores when your
data set is bigger than the L2/L3 caches of the CPU. This means >1MB.
The kernel normally never works on data sets that big.

For Christophers new background cleaner daemon it may be worth it 
when the queue is a LILO. This means it is likely there is a relatively
long time between the clearing operation and a workload using it.
But even then it is a very close call and would need clear benchmark 
numbers in macrobenchmarks.

-Andi

