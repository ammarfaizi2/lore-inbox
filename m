Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVBRWVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVBRWVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVBRWVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:21:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:29432 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261534AbVBRWVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:21:01 -0500
Subject: Re: [RFC][PATCH] Memory Hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Rik van Riel <riel@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <Pine.LNX.4.61.0502181650381.4052@chimarrao.boston.redhat.com>
References: <1108685033.6482.38.camel@localhost>
	 <1108685111.6482.40.camel@localhost>
	 <Pine.LNX.4.61.0502181650381.4052@chimarrao.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 14:20:46 -0800
Message-Id: <1108765246.6482.135.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 16:52 -0500, Rik van Riel wrote:
> On Thu, 17 Feb 2005, Dave Hansen wrote:
> > The attached patch is a prototype implementation of memory hot-add.  It
> > allows you to boot your system, and add memory to it later.  Why would
> > you want to do this?
> 
> I want it so I can grow Xen guests after they have been booted
> up.  Being able to hot-add memory is essential for dynamically
> resizing the memory of various guest OSes, to readjust them for
> the workload.

That's the same thing we like about it on ppc64 partitions.

> Memory hot-remove isn't really needed with Xen, the balloon
> driver takes care of that.

You can free up individual pages back to the hypervisor, but you might
also want the opportunity to free up some unused mem_map if you shrink
the partition by a large amount.

> > I can post individual patches if anyone would like to comment on them.
> 
> I'm interested.  I want to get this stuff working with Xen ;)

You can either pull them from here:

	http://www.sr71.net/patches/2.6.11/2.6.11-rc3-mhp1/broken-out/

or grab the whole tarball:

http://www.sr71.net/patches/2.6.11/2.6.11-rc3-mhp1/broken-out-2.6.11-rc3-mhp1.tar.gz

Or, I could always post the whole bunch to lhms.  Nobody there should
mind too much. :)

The largest part of porting hot-add to a new architecture is usually the
sparsemem portion.  You'll pretty much have to #ifdef pfn_to_page() and
friends, declare a few macros, and then do a bit of debugging.  Here's
ppc64 as an example:

http://www.sr71.net/patches/2.6.11/2.6.11-rc3-mhp1/broken-out/B-sparse-170-sparsemem-ppc64.patch

-- Dave

