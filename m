Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVC1HwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVC1HwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 02:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVC1HwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 02:52:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42251 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261347AbVC1HwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 02:52:00 -0500
Date: Mon, 28 Mar 2005 08:51:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: nickpiggin@yahoo.com.au, hugh@veritas.com, akpm@osdl.org,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050328085136.A9847@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	nickpiggin@yahoo.com.au, hugh@veritas.com, akpm@osdl.org,
	tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk> <424566E0.80001@yahoo.com.au> <20050326155254.E12809@flint.arm.linux.org.uk> <42462B7A.4080305@yahoo.com.au> <20050327085725.A30883@flint.arm.linux.org.uk> <20050327101739.48c843e1.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050327101739.48c843e1.davem@davemloft.net>; from davem@davemloft.net on Sun, Mar 27, 2005 at 10:17:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 10:17:39AM -0800, David S. Miller wrote:
> On Sun, 27 Mar 2005 08:57:25 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > Unfortunately not - free_pgd_slow doesn't have any knowledge about the
> > mm_struct that the pgd was associated with.
> 
> You could store the mm pointer in the page struct of the
> pgd, we used to that before set_pte_at() existed on
> sparc64 and ppc64 for pte level tables.
> 
> page->mapping and page->index are basically free game for
> tracking information assosciated with page table chunks.

Why would I want to do this, given that decrementing mm->nr_ptes in
free_pgd_slow() would make it negative ?  Am I missing something
obvious?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
