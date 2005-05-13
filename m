Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVEMQVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVEMQVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVEMQVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:21:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33478 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262420AbVEMQU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:20:58 -0400
Date: Fri, 13 May 2005 09:20:34 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: NUMA aware slab allocator V2
In-Reply-To: <1115992613.7129.10.camel@localhost>
Message-ID: <Pine.LNX.4.58.0505130915400.4500@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <20050512000444.641f44a9.akpm@osdl.org>  <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
  <20050513000648.7d341710.akpm@osdl.org>  <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
  <20050513043311.7961e694.akpm@osdl.org>  <Pine.LNX.4.58.0505130436380.4500@schroedinger.engr.sgi.com>
 <1115992613.7129.10.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Dave Hansen wrote:

> I think I found the problem.  Could you try the attached patch?

Ok. That is a part of the problem. The other issue that I saw while
testing is that the new slab allocator fails on 64 bit non NUMA platforms
because the bootstrap does not work right. The size of struct kmem_list3
may become > 64 bytes (with preempt etc on which increases the size of the
spinlock_t) which requires an additional slab to be handled in a special
way during bootstrap. I hope I will have an updated patch soon.
