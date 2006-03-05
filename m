Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWCEXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWCEXbc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:31:32 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:9895 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751922AbWCEXbb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:31:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=It+OeHH8gtfywRVgdaGCMR2v3zzeFmfMC5n5ZaMnRXH/czjLgwgedUCX4KPhn0xIgaz1lnw/ozCZ0FIZHURRMUPGU9a9L24FG25JZJar9XOjHE1G0l6uxE2UE824K7oC6Z53T/y96g1iFtwAyeh076JXdf9uc12mGsACvtKnPL0=
Message-ID: <aec8d6fc0603051531o622d04bdjf2993729b0b946ca@mail.gmail.com>
Date: Mon, 6 Mar 2006 00:31:29 +0100
From: "Mateusz Berezecki" <mateuszb@gmail.com>
To: "Benjamin LaHaise" <bcrl@kvack.org>
Subject: Re: memory range R/W triggered breakpoints in kernel ?
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060305231654.GB20768@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aec8d6fc0603050900w7aa1f93due29e9c1cf87e9316@mail.gmail.com>
	 <20060305231654.GB20768@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Benjamin

On 3/6/06, Benjamin LaHaise <bcrl@kvack.org> wrote:
> On Sun, Mar 05, 2006 at 06:00:34PM +0100, Mateusz Berezecki wrote:
> > I was thinking about writing some memory R/W access monitor. The only
> > concern I'm
> > having is whether it is doable, or are there any already existing and
> > working solutions like
> > that for Linux?
>
> Most CPUs implement memory breakpoints of some sort, although they're
> usually limited to specific address instead of ranges.  See gdb's
> watch/awatch/rwatch commands.

Yes but again this is userspace. I was thinking about solution used
back in the old days in SoftICE kernel level debugger.
It had a BPR command (breakpoint on range) which could monitor
up to 400000 bytes of memory range. Unfortunately for me this command
works in very old versions of _that_ other OS.

>
> > which was read/written from certain address. Afterwards the whole page
> > would be marked as non present again.
>
> Use mprotect() and do it in userspace by catching SIGSEGV.  Doing it for
> the kernel is non-trivial and will hit upon arch specific issues like
> double fault handlers.  Given that the same sort of debugging can be done
> in userspace with UML and gdb, there isn't terribly much incentive to do
> the work to make something like this happen.

I thought about UML or maybe even playing with Xen would be better (is
host kernel
transparent to Xen ? ie. does Xen have access to the same hardware as
host kernel?)
but in the end I'd go for kernel page fault handler anyways.

M
