Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTL1Oow (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 09:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTL1Oow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 09:44:52 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5128 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261567AbTL1Oov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 09:44:51 -0500
Date: Sun, 28 Dec 2003 14:44:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Colin Ngam <cngam@sgi.com>
Cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031228144415.B20391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Colin Ngam <cngam@sgi.com>, Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031223090227.A5027@infradead.org> <3FE85533.E026DE86@sgi.com> <20031223165506.A8624@infradead.org> <3FEC8F0B.A8C30677@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FEC8F0B.A8C30677@sgi.com>; from cngam@sgi.com on Fri, Dec 26, 2003 at 01:42:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 01:42:03PM -0600, Colin Ngam wrote:
> Hi Christoph,
> 
> Yes I agree.  However, keep in mind that we are following the ia32/ia64
> way of getting platforms initialized, via ACPI etc.  What you see as
> drivers code in sn/io will probably not exist anymore.  All initialization
> and configuration will be done at the System BIOS level and information
> passed down to the Linux Kernel via ACPI.  This will take away much
> code in the kernel.

Well, I've heard this a few times now and life would definitly be simpler
if you're going down that route.  OTOH we all know talk is cheap and code
speaks, and do you really expect SGI to invest money into doing that for
the now almost legacy SHUB/PIC based Altixens?  Well, even if SGI does this
some day it won't really hurt us to get the code in shape first even if
it's only use on MIPS IP27/IP35, wouldn't it?

> We believe that all that will be left in sn/io directory maybe files dealing with
> DMA mappings(IOMMU).

That's one of the candidates that really should be shared with IP27 and the
once someone does them the IP30 and IP35 ports.  Really, the basic dma mapping
code is the same for Bridge/Xbridge/PIC/TIOCP so we should have one driver.
And once all the IRIX I/O infrastructure depency is ripped out that part of
pcibr is rather self-contained.  I can send you my latest variant of the
dma mapping code if you want, but due tue all that stupid renaming of
structure and macro names it won't compile in your tree.  See why I _really_
_really_ dislike that silly renaming?  It breaks all those nice efforts
for code-sharing without any gain.

Even IRIX TOT uses the 'old' names, so what is the point of renaming them?
