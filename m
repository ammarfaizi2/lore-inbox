Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTHVQri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTHVQri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:47:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44209 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263181AbTHVQrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:47:35 -0400
Date: Fri, 22 Aug 2003 09:39:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: willy@debian.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
 tst-mmap-eofsync in glibc on parisc)
Message-Id: <20030822093957.0ad547cd.davem@redhat.com>
In-Reply-To: <20030822174203.H12903@flint.arm.linux.org.uk>
References: <1061563239.2090.25.camel@mulgrave>
	<20030822091447.6ecea6ca.davem@redhat.com>
	<20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk>
	<20030822174203.H12903@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003 17:42:03 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> > Gah, that's going to get really inefficient.  I still think we want to
> > split flush_dcache_page() into two operations -- flush_dcache_user() and
> > flush_dcache_kernel().  flush_dcache_user() would flush this specific
> > user mapping back to ram and flush_dcache_kernel() would flush the
> > kernel mapping.
> 
> Where are you proposing calling only _user() and _kernel() from ?

The is not acceptable answer.

Purely, flush_dcache_page() is defined to execute when the
kernel stores into a page cache page, and that is it's only
valid definition.

Splitting into a "user" part makes absolutely no sense.
