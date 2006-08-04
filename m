Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWHDEZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWHDEZi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 00:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWHDEZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 00:25:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:55529 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030249AbWHDEZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 00:25:37 -0400
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, y-goto@jp.fujitsu.com,
       andrew <akpm@osdl.org>
In-Reply-To: <20060804124847.610791b5.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154650396.5925.49.camel@keithlap>
	 <20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154656472.5925.71.camel@keithlap>
	 <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154660408.5925.79.camel@keithlap>
	 <20060804121308.e9720b49.kamezawa.hiroyu@jp.fujitsu.com>
	 <1154661826.5925.92.camel@keithlap>
	 <20060804124847.610791b5.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 21:25:34 -0700
Message-Id: <1154665534.5925.98.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 12:48 +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 03 Aug 2006 20:23:46 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:

> > > > What keeps 0xa0000000 to 0xa1000000 from being re-onlined by a bad call
> > > > to add_memory?
> > > 
> > > Usual sparsemem's add_memory() checks whether there are sections in
> > > sparse_add_one_section(). then add_pages() returns -EEXIST (nothing to do).
> > > And ioresouce collision check will finally find collision because 0-0xbffffff
> > > resource will conflict with 0xa0000000 to 0xa10000000 area.
> > > But, x86_64 's (not sparsemem) add_pages() doen't do collision check, so it panics.
> > 
> > I have paniced with your 5 patches while doing SPARSMEM....  I think
> > your 6th patch address the issues I was seeing.  
> > 


with the 6 patches things work as expected.  It is nice to have the
sysfs devices online the correct amount of memory.  

I was broken without this patch because invalid add_memory calls are
made on by box (yet another issue) during boot. 

I will build my patch set on top of your 6 patches. 

Thanks,
  Keith 

