Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVC3RkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVC3RkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVC3RkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:40:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14857 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261902AbVC3RkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:40:11 -0500
Date: Wed, 30 Mar 2005 18:39:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050330183956.C13781@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
	davem@davemloft.net, tony.luck@intel.com, benh@kernel.crashing.org,
	ak@suse.de, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk> <20050326133720.B12809@flint.arm.linux.org.uk> <424568D2.7090701@yahoo.com.au> <20050326150321.C12809@flint.arm.linux.org.uk> <Pine.LNX.4.61.0503301731210.21413@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0503301731210.21413@goblin.wat.veritas.com>; from hugh@veritas.com on Wed, Mar 30, 2005 at 06:00:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 06:00:54PM +0100, Hugh Dickins wrote:
> And, whether FIRST_USER_ADDRESS is 0x8000 or 2MB,
> shouldn't your arch_get_unmapped_area be enforcing it?

Why should it?  arch_get_unmapped_area allocates address space dynamically
when NULL is passed, and always starts from TASK_UNMAPPED_BASE.  This
will be greater than 32K.

The protection against mapping things below 32K comes from the syscall
wrappers on mmap() and mremap().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
