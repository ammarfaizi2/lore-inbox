Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVC0H5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVC0H5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 02:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVC0H5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 02:57:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7178 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261212AbVC0H5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 02:57:44 -0500
Date: Sun, 27 Mar 2005 08:57:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050327085725.A30883@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
	tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk> <424566E0.80001@yahoo.com.au> <20050326155254.E12809@flint.arm.linux.org.uk> <42462B7A.4080305@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42462B7A.4080305@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sun, Mar 27, 2005 at 01:41:46PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 01:41:46PM +1000, Nick Piggin wrote:
> Hmm... no, because free_pgd_slow decrements it? In that case, can
> you have free_pgd_slow also decrement nr_ptes, instead of your
> below patch?

Unfortunately not - free_pgd_slow doesn't have any knowledge about the
mm_struct that the pgd was associated with.

Also remember that nr_ptes wasn't incremented in get_pgd_slow() for this
page table either, and this is the "bug" fix.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
