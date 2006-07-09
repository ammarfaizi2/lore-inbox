Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWGIVAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWGIVAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWGIVAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:00:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161144AbWGIVAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:00:03 -0400
Date: Sun, 9 Jul 2006 13:59:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: clg@fr.ibm.com, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
Message-Id: <20060709135945.dfb58b3d.akpm@osdl.org>
In-Reply-To: <200607092235.32921.rjw@sisk.pl>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B12C74.9090104@fr.ibm.com>
	<20060709132135.6c786cfb.akpm@osdl.org>
	<200607092235.32921.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 22:35:32 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 09 July 2006 22:21, Andrew Morton wrote:
> > On Sun, 09 Jul 2006 18:19:00 +0200
> > Cedric Le Goater <clg@fr.ibm.com> wrote:
> > 
> > > Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> > > 
> > > Kernel BUG at ...home/legoater/linux/2.6.18-rc1-mm1/mm/page_alloc.c:252
> > 
> > 	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
> > 
> > With your config, __GFP_HIGHMEM=0, so wham.
> > 
> > I dunno, Christoph.  I think those patches are going to significantly
> > increase the number of works-with-my-config, doesnt-with-yours scenarios.
> 
> This particular one has no chance to work on x86_64 at all.
> 

Fortunately in -mm we can make this BUG go away by setting
CONFIG_DEBUG_VM=n.

But in 2.6.18-rc1 that's a simple BUG_ON().

> So well, which one is it?

I don't understand that question, sorry.  Right now, I'm inclined to drop
the patches:

reduce-max_nr_zones-remove-two-strange-uses-of-max_nr_zones.patch
reduce-max_nr_zones-fix-max_nr_zones-array-initializations.patch
reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem.patch
reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem-tidy.patch
reduce-max_nr_zones-move-highmem-counters-into-highmemc-h.patch
reduce-max_nr_zones-page-allocator-zone_highmem-cleanup.patch
reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment.patch
reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup.patch
reduce-max_nr_zones-make-zone_dma32-optional.patch
reduce-max_nr_zones-make-zone_highmem-optional.patch
reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones.patch
reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones-s390-fix.patch
reduce-max_nr_zones-fix-i386-srat-check-for-max_nr_zones.patch

It's a question of whether the runtime gain merits the additional developer
load.  Hard call.

