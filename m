Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263878AbTHVQql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbTHVQql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:46:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41649 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263881AbTHVQq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:46:28 -0400
Date: Fri, 22 Aug 2003 09:39:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
 tst-mmap-eofsync in glibc on parisc)
Message-Id: <20030822093900.4468c012.davem@redhat.com>
In-Reply-To: <20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk>
References: <1061563239.2090.25.camel@mulgrave>
	<20030822091447.6ecea6ca.davem@redhat.com>
	<20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003 17:34:29 +0100
Matthew Wilcox <willy@debian.org> wrote:

> On Fri, Aug 22, 2003 at 09:14:47AM -0700, David S. Miller wrote:
> > On 22 Aug 2003 09:40:37 -0500
> > flush_dcache_page() checks both the shared and non-shared mmap lists,
> > so if it is on _either_ list it is flushed.  It does not check only
> > the shared list.
> 
> Gah, that's going to get really inefficient.  I still think we want to
> split flush_dcache_page() into two operations -- flush_dcache_user() and
> flush_dcache_kernel().  flush_dcache_user() would flush this specific
> user mapping back to ram and flush_dcache_kernel() would flush the
> kernel mapping.  Obviously we'd still want to have flush_dcache_page()
> as there are instances when you want to flush all user mappings and the
> kernel mapping back to ram.

flush_dcache_page() works only on kernel pages.

It is defined to execute when the kernel executes store instructions
into a page.

Therefore splitting it into a "user" part makes absolutely no
sense.

> > The VM_SHARED change you are proposing is definitely wrong.
> 
> Why is it wrong?  Why should whether-or-not a mapping is read-only affect
> whether it's mapped shared?  I can't see anything in SuS v3 that suggests
> we should do this.

MAP_SHARED has no meaning if the mapping isn't writable.
