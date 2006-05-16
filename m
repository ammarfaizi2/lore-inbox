Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWEPRfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWEPRfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWEPRfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:35:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:44460 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932170AbWEPRe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:34:59 -0400
Date: Tue, 16 May 2006 10:34:21 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] typo in i386/init.c [BugMe #6538]
Message-ID: <20060516173421.GB4341@us.ibm.com>
References: <20060516165040.GA4341@us.ibm.com> <20060516102427.2c50d469.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516102427.2c50d469.akpm@osdl.org>
X-Operating-System: Linux 2.6.17-rc4 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.2006 [10:24:27 -0700], Andrew Morton wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> >
> > Hi Andrew,
> > 
> > Resending, since I haven't heard anything back yet.
> > 
> > Description: Fix a small typo in arch/i386/mm/init.c. Confirmed to fix
> > BugMe #6538.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > diff -urpN 2.6.17-rc4/arch/i386/mm/init.c 2.6.17-rc4-dev/arch/i386/mm/init.c
> > --- 2.6.17-rc4/arch/i386/mm/init.c	2006-05-12 10:26:59.000000000 -0700
> > +++ 2.6.17-rc4-dev/arch/i386/mm/init.c	2006-05-12 13:49:38.000000000 -0700
> > @@ -651,7 +651,7 @@ void __init mem_init(void)
> >   * Specifically, in the case of x86, we will always add
> >   * memory to the highmem for now.
> >   */
> > -#ifdef CONFIG_HOTPLUG_MEMORY
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> >  #ifndef CONFIG_NEED_MULTIPLE_NODES
> >  int add_memory(u64 start, u64 size)
> >  {
> > 
> 
> I already have this patch queued up but I was half-wondering whether
> to not send it in for 2.6.17.  Partly because the kernel actually
> links and apparently works, which is a rarity when memory hotplug is
> concerned.
> 
> And partly because, well, just look at the patch.  It will give the
> kernel new global symbols add_memory() and remove_memory().  So how
> come it links OK at present?

BugMe #6538 (http://bugzilla.kernel.org/show_bug.cgi?id=6538) indicates
that we currently fail to link with at least 1 .config currently. Toralf
indicated this patch fixes the build for that particular .config.

> And how do we know that it'll link correctly with all configs once
> those symbols are added?  If it _does_ link OK with these symbols
> added then they're not needed anyway.
> 
> So there's something fishy going on here.

I won't deny that :)

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
