Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVA0VDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVA0VDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVA0VCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:02:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58849 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261199AbVA0U6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:58:33 -0500
Date: Thu, 27 Jan 2005 15:58:12 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050127204455.GM10843@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
 <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com>
 <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com>
 <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com>
 <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>
 <20050127204455.GM10843@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, William Lee Irwin III wrote:

> (b) sys_mremap() isn't covered.

AFAICS it is covered.

> --- mm1-2.6.11-rc2.orig/mm/mremap.c	2005-01-26 00:26:43.000000000 -0800
> +++ mm1-2.6.11-rc2/mm/mremap.c	2005-01-27 12:34:34.000000000 -0800
> @@ -297,6 +297,8 @@
> 	if (flags & MREMAP_FIXED) {
> 		if (new_addr & ~PAGE_MASK)
> 			goto out;
> +		if (!new_addr)
> +			goto out;

This looks broken, look at the MREMAP_FIXED part...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
