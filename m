Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWBGP3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWBGP3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBGP3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:29:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31558 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751115AbWBGP3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:29:44 -0500
Date: Tue, 7 Feb 2006 16:31:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
       William Irwin <wli@holomorphy.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060207153126.GN4210@suse.de>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060207151541.GA32139@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207151541.GA32139@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07 2006, Heiko Carstens wrote:
> > tree 8c30052a0d7fadec37c785a42a71b28d0a9c5fcf
> > parent cef5076987dd545ac74f4efcf1c962be8eac34b0
> > author Eric Dumazet <dada1@cosmosbay.com> Sun, 05 Feb 2006 15:27:36 -0800
> > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 06 Feb 2006 03:06:51 -0800
> > 
> > [PATCH] percpu data: only iterate over possible CPUs
> > 
> > percpu_data blindly allocates bootmem memory to store NR_CPUS instances of
> > cpudata, instead of allocating memory only for possible cpus.
> > 
> > As a preparation for changing that, we need to convert various 0 -> NR_CPUS
> > loops to use for_each_cpu().
> > 
> > (The above only applies to users of asm-generic/percpu.h.  powerpc has gone it
> > alone and is presently only allocating memory for present CPUs, so it's
> > currently corrupting memory).
> 
> This patch is broken since it replaces several loops that iterate NR_CPUS
> times with for_each_cpu before cpu_possible_map is setup:

Hrmpf, chicking and egg - we must not initialize data for unknown CPUs,
but we can't check since it's not setup.

To me it sounds really broken that core structures like that are not
setup before we init eg fs stuff.

-- 
Jens Axboe

