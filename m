Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263289AbUJ2Lr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbUJ2Lr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUJ2Lmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:42:55 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:32897 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263260AbUJ2LjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:39:11 -0400
Date: Fri, 29 Oct 2004 13:38:37 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH[ Export __PAGE_KERNEL_EXEC for modules (vmmon)
Message-ID: <20041029113837.GD10837@vana.vc.cvut.cz>
References: <20041028221148.GE24972@vana.vc.cvut.cz> <1099040620.2641.11.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099040620.2641.11.camel@laptop.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:03:41AM +0200, Arjan van de Ven wrote:
> On Fri, 2004-10-29 at 00:11 +0200, Petr Vandrovec wrote:
> > Hello Ingo,
> >   recently support for NX on i386 arrived to 2.6.x kernel, and I have
> > some problems building code which uses vmap since then - PAGE_KERNEL_EXEC
> 
> why are you vmap'ing *executable* kernel memory?
> That sounds very wrong.... very very wrong. The module loader needs it,
> sure, but that's not modular. What on earth are you doing ????

Due to rule that not everything should be in kernel, userspace
picks one of codes needed to switch processor from currently used
mode  & address space to mode VMware needs (ia32 => long, long => ia32, 
PAE <=> non-PAE + cr3 + gdt + idt) maps it into kernel space, and then run 
it as needed.  And for running it it must be executable.

OK, I think that I understand message.  __pgprot(__PAGE_KERNEL & ~_PAGE_NX)
is my friend.
						Petr Vandrovec

