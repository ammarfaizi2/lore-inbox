Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWDNO01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDNO01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWDNO00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:26:26 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:12941 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964800AbWDNO00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:26:26 -0400
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, hugh@veritas.com,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
In-Reply-To: <20060413222516.4cb5885c.akpm@osdl.org>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
	 <20060413171331.1752e21f.akpm@osdl.org>
	 <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
	 <20060413174232.57d02343.akpm@osdl.org>
	 <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
	 <20060413180159.0c01beb7.akpm@osdl.org>
	 <20060413181716.152493b8.akpm@osdl.org>
	 <Pine.LNX.4.64.0604131831150.16220@schroedinger.engr.sgi.com>
	 <20060413222516.4cb5885c.akpm@osdl.org>
Content-Type: text/plain
Organization: HP/OSLO
Date: Fri, 14 Apr 2006 10:27:43 -0400
Message-Id: <1145024863.5211.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 22:25 -0700, Andrew Morton wrote:
> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > On Thu, 13 Apr 2006, Andrew Morton wrote:
> > 
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > Perhaps it would be better to go to
> > > >  sleep on some global queue, poke that queue each time a page migration
> > > >  completes?
> > > 
> > > Or take mmap_sem for writing in do_migrate_pages()?  That takes the whole
> > > pagefault path out of the picture.
> > 
> > We would have to take that for each task mapping the page. Very expensive 
> > operation.
> 
> So...  why does do_migrate_pages() take mmap_sem at all?
> 
> And the code we're talking about here deals with anonymous pages, which are
> not shared betweem mm's.

I think that anon pages are shared, copy-on-write, between parent and
child after a fork().  If no exec() and no task writes the page, the
sharing can become quite extensive.  I encountered this testing the
migrate-on-fault patches.  With MPOL_MF_MOVE, these shared anon pages
don't get migrated at all [sometimes this is what you want, sometimes
not...], but with '_MOVE_ALL the shared anon pages DO get migrated, so
you can have races between a faulting task and the migrating task.

Lee

