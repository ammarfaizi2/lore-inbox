Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUFYDTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUFYDTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 23:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUFYDTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 23:19:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:36842 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266187AbUFYDTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 23:19:20 -0400
Subject: Re: [Lhms-devel] Re: Merging Nonlinear and Numa style memory
	hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <20040624194557.F02B.YGOTO@us.fujitsu.com>
References: <20040624135838.F009.YGOTO@us.fujitsu.com>
	 <1088116621.3918.1060.camel@nighthawk>
	 <20040624194557.F02B.YGOTO@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1088133541.3918.1348.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 20:19:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 20:11, Yasunori Goto wrote:
> I understand this idea at last.
> Section size of DLPAR of PPC is only 16MB.
> But kmalloc area of virtual address have to be contigous 
> even if the area is divided 16MB physically.
> Dave-san's implementation (it was for IA32) was same index between 
> phys_section and mem_section. So, I was confused.
> 
> > pfn_to_page(unsigned long pfn)
> > {
> >        return
> > &mem_section[phys_section[pfn_to_section(pfn)]].mem_map[section_offset_pfn(pfn)];
> > }
> > 
> 
> But, I suppose this translation might be too complex.

It certainly doesn't look pretty, but I think it's manageable with a
comment, or maybe breaking the operation up into a few lines instead.

> I worry that many person don't like this which is cause of
> performance deterioration.

There is some precedent in the kernel for a table such as this.  Take a
look at the NUMA page_to_pfn() and page_zone() functions.  They use a
zone_table array to do that same kind of thing.

Are you worried bout the pfn_to_page() function itself, that it will
pull in 2 cachelines of data: 1 for phys_section[] and another for
mem_section[]?

> Should this translation be in common code?

What do you mean by common code?  It should be shared by all
architectures.

-- Dave

