Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTHVSBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263465AbTHVSBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:01:55 -0400
Received: from rth.ninka.net ([216.101.162.244]:33409 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263449AbTHVSBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:01:50 -0400
Date: Fri, 22 Aug 2003 11:01:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
 tst-mmap-eofsync in glibc on parisc)
Message-Id: <20030822110144.5f7b83c5.davem@redhat.com>
In-Reply-To: <20030822103634.46a15747.davem@redhat.com>
References: <1061563239.2090.25.camel@mulgrave>
	<20030822091447.6ecea6ca.davem@redhat.com>
	<20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk>
	<20030822093900.4468c012.davem@redhat.com>
	<20030822174103.GI18834@parcelfarce.linux.theplanet.co.uk>
	<20030822103634.46a15747.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003 10:36:34 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Fri, 22 Aug 2003 18:41:03 +0100
> Matthew Wilcox <willy@debian.org> wrote:
> 
> > Uhm.  So what happens when the user has stored into the page and now
> > the kernel wants to read from it?  There's still data in the cache for
> > the user mapping that's non-coherent with the kernel mapping.
> 
> I see.  This causes the page cache read flush_dcache_page() call
> not to trigger.

Wait, I'm confused again.

How can the user "write" to the mmap()'d side if PROT_WRITE
was not specified?  That is the only case in which the proposed
patch could make a difference, we check this:

	switch (flags & MAP_TYPE) {
		case MAP_SHARED:
			if ((prot&PROT_WRITE) && !(file->f_mode&FMODE_WRITE))
				return -EACCES;

Therefore if the user can write to the page, file->f_mode will
have the write bit set too.

So the proposed patch looks bogus to me.
