Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWHDIcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWHDIcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWHDIcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:32:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:31943 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161106AbWHDIcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:32:07 -0400
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, y-goto@jp.fujitsu.com,
       andrew <akpm@osdl.org>
In-Reply-To: <44D3041E.501@kolumbus.fi>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154650396.5925.49.camel@keithlap>
	 <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154656472.5925.71.camel@keithlap>
	 <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154660408.5925.79.camel@keithlap>
	 <20060804121308.e9720b49.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154661826.5925.92.camel@keithlap>
	 <20060804124847.610791b5.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154665534.5925.98.camel@keithlap>  <44D3041E.501@kolumbus.fi>
Content-Type: text/plain; charset=utf-8
Organization: Linux Technology Center IBM
Date: Fri, 04 Aug 2006 01:32:04 -0700
Message-Id: <1154680324.5925.107.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 11:23 +0300, Mika Penttilä wrote:
> keith mannthey wrote:
> > On Fri, 2006-08-04 at 12:48 +0900, KAMEZAWA Hiroyuki wrote:
> >   
> >> On Thu, 03 Aug 2006 20:23:46 -0700
> >> keith mannthey <kmannth@us.ibm.com> wrote:
> >>     
> >
> >   
> >>>>> What keeps 0xa0000000 to 0xa1000000 from being re-onlined by a bad call
> >>>>> to add_memory?
> >>>>>           
> >>>> Usual sparsemem's add_memory() checks whether there are sections in
> >>>> sparse_add_one_section(). then add_pages() returns -EEXIST (nothing to do).
> >>>> And ioresouce collision check will finally find collision because 0-0xbffffff
> >>>> resource will conflict with 0xa0000000 to 0xa10000000 area.
> >>>> But, x86_64 's (not sparsemem) add_pages() doen't do collision check, so it panics.
> >>>>         
> >>> I have paniced with your 5 patches while doing SPARSMEM....  I think
> >>> your 6th patch address the issues I was seeing.  
> >>>
> >>>       
> >
> >
> > with the 6 patches things work as expected.  It is nice to have the
> > sysfs devices online the correct amount of memory.  
> >
> > I was broken without this patch because invalid add_memory calls are
> > made on by box (yet another issue) during boot. 
> >
> > I will build my patch set on top of your 6 patches. 
> >
> > Thanks,
> >   Keith 
> >
> >   
> Keith, are you working on the reserve hotadd case? It looks really 
> broken, at the same time we both assume the hot add region contains RAM 
> per e820 (use of reserve_bootmem_node()) and at the same time in other 
> places (in reserve_hotadd()) that it may not contain RAM. And 
> nodes_cover_memory() is broken no matter what we assume.

I am working that right now... There is handful of things that need
cleaned up with RESERVE.  I am about 1 patch away for a patchset that
make both SPARSEMEM and RESERVE hot-add work on x86_64. It should be out
soon. 

Reserve is in a non-compile state as it stands with 2.6.18. 

Thanks,
 Keith 

