Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTHVRlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbTHVRlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:41:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16595 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263819AbTHVRlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:41:04 -0400
Date: Fri, 22 Aug 2003 18:41:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Matthew Wilcox <willy@debian.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing tst-mmap-eofsync in glibc on parisc)
Message-ID: <20030822174103.GI18834@parcelfarce.linux.theplanet.co.uk>
References: <1061563239.2090.25.camel@mulgrave> <20030822091447.6ecea6ca.davem@redhat.com> <20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk> <20030822093900.4468c012.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822093900.4468c012.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 09:39:00AM -0700, David S. Miller wrote:
> flush_dcache_page() works only on kernel pages.
> 
> It is defined to execute when the kernel executes store instructions
> into a page.
> 
> Therefore splitting it into a "user" part makes absolutely no
> sense.

Uhm.  So what happens when the user has stored into the page and now
the kernel wants to read from it?  There's still data in the cache for
the user mapping that's non-coherent with the kernel mapping.

> > > The VM_SHARED change you are proposing is definitely wrong.
> > 
> > Why is it wrong?  Why should whether-or-not a mapping is read-only affect
> > whether it's mapped shared?  I can't see anything in SuS v3 that suggests
> > we should do this.
> 
> MAP_SHARED has no meaning if the mapping isn't writable.

Sure it does.  It affects whether other writes to that page show up in
the shared read-only mapping.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
