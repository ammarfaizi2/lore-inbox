Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUCSAvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUCSAvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:51:16 -0500
Received: from ozlabs.org ([203.10.76.45]:20870 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261187AbUCSAvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:51:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16474.17281.854064.530815@cargo.ozlabs.ibm.com>
Date: Fri, 19 Mar 2004 11:49:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
In-Reply-To: <20040318230628.GA2050@dualathlon.random>
References: <20040318022201.GE2113@dualathlon.random>
	<Pine.LNX.4.44.0403181928210.16385-100000@localhost.localdomain>
	<20040318230628.GA2050@dualathlon.random>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> On Thu, Mar 18, 2004 at 08:41:45PM +0000, Hugh Dickins wrote:
> > and ppc64 can manage an early per-cpu increment.  You'll find you've
> > broken ppc and ppc64, which have grown to use the pgtable rmap stuff
> > for themselves, you'll probably want to grab some of my arch patches.
> 
> Oh well, this is the next blocker now... Where can I find your arch
> patches? PPC folks comments?

We need page->mapping and page->index set for pages used for pte and
pmd pages, so that we can get from a pte_t * back to the mm_struct *
and the address within that mm.  It's just a matter of setting
page->mapping and page->index in the pte_alloc and pmd_alloc
functions.

I just looked at Hugh's anobjrmap 6/6 patch and it looks to me that it
does that correctly.

Regards,
Paul.
