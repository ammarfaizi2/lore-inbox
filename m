Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWHDByf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWHDByf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWHDByf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:54:35 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:21176 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932588AbWHDBye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:54:34 -0400
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, y-goto@jp.fujitsu.com,
       andrew <akpm@osdl.org>
In-Reply-To: <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154650396.5925.49.camel@keithlap>
	 <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 18:54:32 -0700
Message-Id: <1154656472.5925.71.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 09:44 +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 03 Aug 2006 17:13:16 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > On Thu, 2006-08-03 at 12:36 +0900, KAMEZAWA Hiroyuki wrote:
> > > add_memory() does all necessary check to avoid collision.
> > > then, acpi layer doesn't have to check region by itself.
> > > 
> > > (*) pfn_valid() just returns page struct is valid or not. It returns 0
> > >     if a section has been already added even is ioresource is not added.
> > >     ioresource collision check in mm/memory_hotplug.c can do more precise
> > >     collistion check.
> > >     added enabled bit check just for sanity check..
> > > 
> > > Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> > 
> > > -		start_pfn = info->start_addr >> PAGE_SHIFT;
> > > -		end_pfn = (info->start_addr + info->length - 1) >> PAGE_SHIFT;
> > > -
> > > -		if (pfn_valid(start_pfn) || pfn_valid(end_pfn)) {
> > 
> > This check needs to go somewhare in the add path.  I am thinking of a
> > validate_add_memory_area call in add_memory (that can also be flexable
> > to enable the reserve check of (this memory area in add_nodes).  
> > 
> >   It is a useful protection for the sparsemem add path. I would rather
> > the kernel be able to stand up to odd acpi namespaces or other
> > mechanisms of invoking add_memory. 
> > 
> Hmm..Okay. I'll try some check patch today. please review it.
> Maybe moving ioresouce collision check in early stage of add_memory() is good ?
  Yea.  I am working a a full patch set for but my sparsemem and reserve
add-based paths.  It creates a valid_memory_add_range call at the start
of add_memory. I should be posting the set in the next few hours.

> Note:
> I remove pfn_valid() here because pfn_valid() just says section exists or
> not. When adding seveal small memory chunks in one section, Only the  first
> small chunk can be added. 
Hmm... I thought memory add areas needed to be section aligned for the arch?

  What protecting is there for calling add_memory on an already present
memory range?  


Thanks,
  Keith 


