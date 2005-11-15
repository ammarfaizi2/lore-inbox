Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVKOAQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVKOAQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKOAQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:16:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932203AbVKOAQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:16:47 -0500
Date: Mon, 14 Nov 2005 16:17:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: 2.6.14 X spinning in the kernel
Message-Id: <20051114161704.5b918e67.akpm@osdl.org>
In-Reply-To: <1132012281.24066.36.camel@localhost.localdomain>
References: <1132012281.24066.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> My 2-cpu EM64T machine started showing this problem again on 2.6.14.
> On some reboots, X seems to spin in the kernel forever.
> 
> sysrq-t output shows nothing.
> 
> X             R  running task       0  3607   3589          3903
> (L-TLB)
> 
> top shows:
>  3607 root      25   0     0    0    0 R 99.1  0.0 262:04.69 X
> 
> 
> So, I wrote a module to do smp_call_function() on all CPUs
> to show stacks on them. CPU0 seems to be spinning in exit_mmap().
> I did this multiple times to collect stacks few times.
> 
> Is this a known issue ?

Nope.  Maybe your vma list has a loop in it, in remove_vma()?  slab
debugging would detect that, due to the repeated
kmem_cache_free(vm_area_cachep, vma);

