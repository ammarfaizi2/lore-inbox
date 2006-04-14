Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWDNFZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWDNFZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 01:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWDNFZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 01:25:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965108AbWDNFZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 01:25:46 -0400
Date: Thu, 13 Apr 2006 22:25:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
Message-Id: <20060413222516.4cb5885c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604131831150.16220@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
	<20060413171331.1752e21f.akpm@osdl.org>
	<Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
	<20060413174232.57d02343.akpm@osdl.org>
	<Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
	<20060413180159.0c01beb7.akpm@osdl.org>
	<20060413181716.152493b8.akpm@osdl.org>
	<Pine.LNX.4.64.0604131831150.16220@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 13 Apr 2006, Andrew Morton wrote:
> 
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Perhaps it would be better to go to
> > >  sleep on some global queue, poke that queue each time a page migration
> > >  completes?
> > 
> > Or take mmap_sem for writing in do_migrate_pages()?  That takes the whole
> > pagefault path out of the picture.
> 
> We would have to take that for each task mapping the page. Very expensive 
> operation.

So...  why does do_migrate_pages() take mmap_sem at all?

And the code we're talking about here deals with anonymous pages, which are
not shared betweem mm's.
