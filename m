Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269155AbUIRHmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269155AbUIRHmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUIRHmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:42:20 -0400
Received: from ozlabs.org ([203.10.76.45]:52155 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269158AbUIRHll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:41:41 -0400
Date: Sat, 18 Sep 2004 09:46:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Remove LARGE_PAGE_SHIFT constant
Message-ID: <20040917234656.GB23252@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20040917011320.GA6523@zax> <20040917170328.GB2179@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917170328.GB2179@logos.cnet>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 02:03:28PM -0300, Marcelo Tosatti wrote:
> On Fri, Sep 17, 2004 at 11:13:20AM +1000, David Gibson wrote:
> > Andrew, please apply:
> > 
> > For historical reasons, ppc64 has ended up with two #defines for the
> > size of a large (16M) page: LARGE_PAGE_SHIFT and HPAGE_SHIFT.  This
> > patch removes LARGE_PAGE_SHIFT in favour of the more widely used
> > HPAGE_SHIFT.
> 
> Nitpicking, "LARGE_PAGE_xxx" is used by x86/x86_64:
> 
> #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
> #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
> 
> Wouldnt it be nice to keep consistency between archs?

Hrm... they are indeed there.  However *all* archs, including x86 and
x86_64 have HPAGE_SHIFT et al - it's used in generic code, so x86 has
the duplicate #defines as well.

Actually.. I guess the distinction is that LARGE_PAGE_* refer to the
hardware large page size, whereas HPAGE_SIZE refers to the software
page size used for hugetlbfs.  I think those are identical for all
arches at the moment, but they wouldn't have to be.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
