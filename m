Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTEMWa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEMWa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:30:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24072 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261193AbTEMWaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:30:25 -0400
Date: Tue, 13 May 2003 23:40:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, mjacob@quaver.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4 fix to allow vmalloc at interrupt time
Message-ID: <20030513234050.G15172@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mjacob@quaver.net, linux-kernel@vger.kernel.org
References: <20030512225654.GA27358@cm.nu> <20030513140629.I83125@mailhost.quaver.net> <20030513211707.GU8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513211707.GU8978@holomorphy.com>; from wli@holomorphy.com on Tue, May 13, 2003 at 02:17:07PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:17:07PM -0700, William Lee Irwin III wrote:
> On Tue, May 13, 2003 at 02:11:12PM -0700, Matthew Jacob wrote:
> > This fixes a buglet wrt doing vmalloc at interrupt time for 2.4.
> > get_vm_area should call kmalloc with GFP_ATOMIC- after all, it's
> > set up to allow for an allocation failure. As best as I read
> > the 2.4 code, the rest of the path through _kmem_cache_alloc
> > should be safe.
> 
> Try write_lock_irq(&vmlist_lock)/read_lock_irq(&vmlist_lock) and
> passing in a gfp mask with an alternative API etc. for the interrupt
> time special case. It's deadlockable without at least the locking bits.
> 
> But it's worse than that, the implicit smp_call_function() means this
> is stillborn and infeasible period.

Not to mention the page table allocation code...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

