Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWCXSF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWCXSF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWCXSF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:05:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:35215 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751338AbWCXSF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:05:56 -0500
Date: Fri, 24 Mar 2006 13:05:38 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, torvalds@osdl.org,
       ebiederm@xmission.com, galak@kernel.crashing.org, gregkh@suse.de,
       bcrl@kvack.org, dave.jiang@gmail.com, arjan@infradead.org,
       maneesh@in.ibm.com, muralim@in.ibm.com
Subject: Re: [RFC][PATCH 0/10] 64 bit resources
Message-ID: <20060324180538.GC4406@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060324011217.7b8aade1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324011217.7b8aade1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 01:12:17AM -0800, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > Hi,
> > 
> > Here is an attempt to implement support for 64 bit resources. This will
> > enable memory more than 4G to be exported through /proc/iomem, which is used
> > by kexec/kdump to determine the physical memory layout of the system.
> > 
> > ...
> > 
> > We used "make allyesconfig" with CONFIG_DEBUG_INFO=n on 2.6.16-mm1.
> > 
> > i386
> > ----
> > 
> > vmlinux size without patch: 40191425
> > vmlinux size with path: 40244677
> > vmlinux size bloat: 52K (.13%)
> 
> ugh, that's actually a surprising amount of growth.  Could you look into it
> a bit more please?  Where's it coming from?  text?  data?


Andrew, most of it seems to be coming from .text. I have pasted few results
below.

> 
> A bit of growth in drivers is probably OK, as all machines load a tiny
> subset of them.  But if it's core kernel, not so good.  What is the effect
> on allnoconfig?

Here are more compilation results with allnoconfig, allmodconfig and
allyesconfig on i386. I have picked section sizes from the output of readelf.

allnoconfig 
----------

vmlinux bloat: 0

.text bloat: 1008 bytes
.data bloat: 672 bytes.
.init.text bloat: 128 bytes
.init.data bloat: 0 bytes

(Not sure why vmlinux size difference is zero, given the fact that few
 sections are showing bloated size)


allmodconfig (CONFIG_DEBUG_INFO=n)
------------

vmlinux bloat:4096 bytes
                                                                                
.text bloat: 4064 bytes
.init.text bloat: 470 bytes
.data bloat: 640 bytes


allyesconfig  (CONFIG_DEBUG_INFO=n)
-----------

vmlinux size bloat: 52K
                                                                                
.text bloat: 28.5K
.init_text bloat: 5K
.eh_frame bloat: 16K  (What's that. Looks big)
.rodata bloat: 152 bytes
.data bloat: 768 bytes


Thanks
Vivek
