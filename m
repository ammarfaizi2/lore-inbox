Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWINXgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWINXgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWINXgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:36:00 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:42438 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932133AbWINXf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:35:59 -0400
Date: Thu, 14 Sep 2006 19:35:32 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: keith mannthey <kmannth@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in get_memcfg_from_srat
Message-ID: <20060914233532.GF25044@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1158113895.9562.13.camel@keithlap> <1158269696.15745.5.camel@keithlap> <1158271274.24414.6.camel@localhost.localdomain> <1158273830.15745.14.camel@keithlap> <20060914230442.GE25044@in.ibm.com> <1158276093.24414.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158276093.24414.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 04:21:33PM -0700, Dave Hansen wrote:
> On Thu, 2006-09-14 at 19:04 -0400, Vivek Goyal wrote:
> > I think I know what is going on wrong here. boot_ioremap() is assuming 
> > that only first 8MB of physical memory is being mapped and while
> > calculating the index into page table (boot_pte_index) we will truncate
> > any higher address bits. 
> 
> Vivek, are those pte pages still all contiguous?
> 

Yes, they are. (arch/i386/kernel/head.S)

> Yeah, that's probably it.  Keith, I'm trying to think of reasons why we
> need the mask here:
> 
> #define boot_pte_index(address) \
>              (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
> 
> and I can't think of any other than just masking out the top of the
> virtual address.  You could do this a bunch of other ways, like __pa().
> 
> This might just work:
> 
> static unsigned long boot_pte_index(unsigned long vaddr)
> {
> 	return __pa(vaddr) >> PAGE_SHIFT;
> }
>

This looks good. Should work.

Thanks
Vivek
