Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVA0VWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVA0VWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVA0VT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:19:59 -0500
Received: from holomorphy.com ([66.93.40.71]:63419 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261182AbVA0VN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:13:29 -0500
Date: Thu, 27 Jan 2005 13:13:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050127211319.GN10843@holomorphy.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com> <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com> <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com> <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com> <20050127204455.GM10843@holomorphy.com> <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, William Lee Irwin III wrote:
>> (b) sys_mremap() isn't covered.

On Thu, Jan 27, 2005 at 03:58:12PM -0500, Rik van Riel wrote:
> AFAICS it is covered.
> >--- mm1-2.6.11-rc2.orig/mm/mremap.c	2005-01-26 00:26:43.000000000 -0800
> >+++ mm1-2.6.11-rc2/mm/mremap.c	2005-01-27 12:34:34.000000000 -0800
> >@@ -297,6 +297,8 @@
> >	if (flags & MREMAP_FIXED) {
> >		if (new_addr & ~PAGE_MASK)
> >			goto out;
> >+		if (!new_addr)
> >+			goto out;
> 
> This looks broken, look at the MREMAP_FIXED part...

The only way I can make sense of this is if you're trying to say that
because the user is trying to pass in a fixed address, that 0 should
then be permitted.

The intention was to disallow vmas starting at 0 categorically. i.e. it
is very intentional to deny the MREMAP_FIXED to 0 case of mremap().
It was also the intention to deny the MAP_FIXED to 0 case of mmap(),
though I didn't actually sweep that much (if at all).


-- wli
