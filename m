Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271998AbRIDQoR>; Tue, 4 Sep 2001 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271997AbRIDQoH>; Tue, 4 Sep 2001 12:44:07 -0400
Received: from are.twiddle.net ([64.81.246.98]:27013 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S271995AbRIDQn4>;
	Tue, 4 Sep 2001 12:43:56 -0400
Date: Tue, 4 Sep 2001 09:44:12 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul Mackerras <paulus@samba.org>
Cc: David Mosberger <davidm@hpl.hp.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
Message-ID: <20010904094412.B18163@twiddle.net>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	David Mosberger <davidm@hpl.hp.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com> <20010903131436.A16069@twiddle.net> <15251.59286.154267.431231@napali.hpl.hp.com> <20010903134125.B16069@twiddle.net> <15252.13330.652765.959658@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15252.13330.652765.959658@cargo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Sep 04, 2001 at 11:53:22AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 11:53:22AM +1000, Paul Mackerras wrote:
> If the page is a private page (private COW or anonymous page) then I
> don't see where the kernel would be modifying the page.

ptrace set breakpoint?

> For alpha, the thing that my patch does that might hurt is the change
> from flush_icache_page to flush_icache_range in kernel/ptrace.c.  Any
> comment on that?

Hum.  Yes.  We need a way to distinguish between userspace and
kernelspace icache flushes.

Previously, flush_icache_page was used exclusively for userspace
and flush_icache_range exclusively for kernelspace.  Since I _do_
have address space numbers, I can avoid the "flush all" by allocating
a new ASN for the user process.  Which doesn't work for the kernel
of course; there I do have to flush all.


r~
