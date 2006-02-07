Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWBGQnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWBGQnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWBGQnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:43:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932122AbWBGQnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:43:41 -0500
Date: Tue, 7 Feb 2006 08:42:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Ingo Molnar <mingo@elte.hu>, Jens Axboe <axboe@suse.de>,
       Anton Blanchard <anton@samba.org>, William Irwin <wli@holomorphy.com>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
In-Reply-To: <43E8CA10.5070501@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
 <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Feb 2006, Eric Dumazet wrote:
> 
> This patch assumes that cpu_possible_map is setup before
> setup_per_cpu_areas().
> 
> That sounds a reasonable assumption, but maybe not on your architecture ?

I have to say, it sounds not just like a reasonable assumption, but like 
the only sane assumption that there _could_ be.

> I dont think cpu_possible_map has to be filled at smp_prepare_cpus() time, but
> long before.
> 
> On i386/x86_64/ia64, this is done from setup_arch() called from start_kernel()
> just before setup_per_cpu_areas()
> 
> On powerpc it's done from setup_system(), called before start_kernel()

It absolutely _has_ to be done from setup_arch() or earlier, as shown by 
the fact that "setup_per_cpu_areas()" is the very next thing that 
init/main.c calls (and clearly, that needs to know what CPU's are 
possible).

ppc64 certainly calls it early enough, as does x86/x86-64/ia64. I don't 
see anybody else doing it too late either.

Heiko, can you point to the "old comment" you mentioned in the email, or 
the architecture that does this wrong?

		Linus
