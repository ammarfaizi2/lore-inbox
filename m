Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVCOXgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVCOXgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVCOXgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:36:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262121AbVCOXgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:36:31 -0500
Date: Tue, 15 Mar 2005 18:36:20 -0500
From: Dave Jones <davej@redhat.com>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>
Subject: Re: [PATCH] Reading deterministic cache parameters and exporting it in /sysfs
Message-ID: <20050315233620.GC14380@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Rohit Seth <rohit.seth@intel.com>
References: <20050315152448.A1697@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315152448.A1697@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 03:24:48PM -0800, Venkatesh Pallipadi wrote:
 >  
 > The attached patch adds support for using cpuid(4) instead of cpuid(2), to get 
 > CPU cache information in a deterministic way for Intel CPUs, whenever 
 > supported. The details of cpuid(4) can be found here
 > 
 > IA-32 Intel Architecture Software Developer's Manual (vol 2a)
 > (http://developer.intel.com/design/pentium4/manuals/index_new.htm#sdm_vol2a)
 > and
 > Prescott New Instructions (PNI) Technology: Software Developer's Guide
 > (http://www.intel.com/cd/ids/developer/asmo-na/eng/events/43988.htm)
 >  
 > The advantage of using the cpuid(4) ('Deterministic Cache Parameters Leaf') are:
 > * It provides more information than the descriptors provided by cpuid(2)
 > * It is not table based as cpuid(2). So, we will not need changes to the 
 >   kernel to support new cache descriptors in the descriptor table (as is the 
 >   case with cpuid(2)).
 >  
 > The patch also adds a bunch of interfaces under 
 > /sys/devices/system/cpu/cpuX/cache, showing various information about the
 > caches.

Why does this need to be in kernel-space ? Is there some reason that prevents
you from enhancing x86info for example ?  I really want to live to see the
death of /proc/cpuinfo one day, and reinventing it in sysfs seems pointless
if it can all be done in userspace.
 
 > Most useful field being shared_cpu_map, which says what caches are 
 > shared among which logical cpus. 

Given that the most useful field is of limited use to a majority of users,
and those that are interested can read this from userspace, this has me very puzzled.

		Dave

