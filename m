Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTHVQed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTHVQed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:34:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15825 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263300AbTHVQeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:34:31 -0400
Date: Fri, 22 Aug 2003 17:34:29 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing tst-mmap-eofsync in glibc on parisc)
Message-ID: <20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk>
References: <1061563239.2090.25.camel@mulgrave> <20030822091447.6ecea6ca.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822091447.6ecea6ca.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 09:14:47AM -0700, David S. Miller wrote:
> On 22 Aug 2003 09:40:37 -0500
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> > The reason this doesn't happen is because the mapping is not on the
> > mmap_shared list that flush_dcache_page() updates.
> 
> flush_dcache_page() checks both the shared and non-shared mmap lists,
> so if it is on _either_ list it is flushed.  It does not check only
> the shared list.

Gah, that's going to get really inefficient.  I still think we want to
split flush_dcache_page() into two operations -- flush_dcache_user() and
flush_dcache_kernel().  flush_dcache_user() would flush this specific
user mapping back to ram and flush_dcache_kernel() would flush the
kernel mapping.  Obviously we'd still want to have flush_dcache_page()
as there are instances when you want to flush all user mappings and the
kernel mapping back to ram.

> The VM_SHARED change you are proposing is definitely wrong.

Why is it wrong?  Why should whether-or-not a mapping is read-only affect
whether it's mapped shared?  I can't see anything in SuS v3 that suggests
we should do this.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
