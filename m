Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWHDAqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWHDAqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWHDAqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:46:12 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:3748 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932578AbWHDAqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:46:11 -0400
Date: Fri, 4 Aug 2006 09:44:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       y-goto@jp.fujitsu.com, akpm@osdl.org
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
Message-Id: <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154650396.5925.49.camel@keithlap>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	<1154650396.5925.49.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 17:13:16 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> On Thu, 2006-08-03 at 12:36 +0900, KAMEZAWA Hiroyuki wrote:
> > add_memory() does all necessary check to avoid collision.
> > then, acpi layer doesn't have to check region by itself.
> > 
> > (*) pfn_valid() just returns page struct is valid or not. It returns 0
> >     if a section has been already added even is ioresource is not added.
> >     ioresource collision check in mm/memory_hotplug.c can do more precise
> >     collistion check.
> >     added enabled bit check just for sanity check..
> > 
> > Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> > -		start_pfn = info->start_addr >> PAGE_SHIFT;
> > -		end_pfn = (info->start_addr + info->length - 1) >> PAGE_SHIFT;
> > -
> > -		if (pfn_valid(start_pfn) || pfn_valid(end_pfn)) {
> 
> This check needs to go somewhare in the add path.  I am thinking of a
> validate_add_memory_area call in add_memory (that can also be flexable
> to enable the reserve check of (this memory area in add_nodes).  
> 
>   It is a useful protection for the sparsemem add path. I would rather
> the kernel be able to stand up to odd acpi namespaces or other
> mechanisms of invoking add_memory. 
> 
Hmm..Okay. I'll try some check patch today. please review it.
Maybe moving ioresouce collision check in early stage of add_memory() is good ?

Note:
I remove pfn_valid() here because pfn_valid() just says section exists or
not. When adding seveal small memory chunks in one section, Only the  first
small chunk can be added. 

Thanks,
-Kame


