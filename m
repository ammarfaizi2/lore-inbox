Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTEMVQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTEMVQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:16:32 -0400
Received: from beppo.feral.com ([192.67.166.79]:11019 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id S263397AbTEMVQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:16:22 -0400
Date: Tue, 13 May 2003 14:28:56 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
X-X-Sender: mjacob@mailhost.quaver.net
Reply-To: mjacob@quaver.net
To: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4 fix to allow vmalloc at interrupt time
In-Reply-To: <20030513211707.GU8978@holomorphy.com>
Message-ID: <20030513142840.K83125@mailhost.quaver.net>
References: <20030512225654.GA27358@cm.nu> <20030513140629.I83125@mailhost.quaver.net>
 <20030513211707.GU8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ah. Thanks.



On Tue, 13 May 2003, William Lee Irwin III wrote:

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
>
>
>
> -- wli
>
