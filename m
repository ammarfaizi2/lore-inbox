Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSFGA7b>; Thu, 6 Jun 2002 20:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSFGA7a>; Thu, 6 Jun 2002 20:59:30 -0400
Received: from holomorphy.com ([66.224.33.161]:46990 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315461AbSFGA7a>;
	Thu, 6 Jun 2002 20:59:30 -0400
Date: Thu, 6 Jun 2002 17:59:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: davidm@hpl.hp.com
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020607005915.GA22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	davidm@hpl.hp.com, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <OF81A861D7.0F84A7BA-ONC1256BD0.0072344C@de.ibm.com> <15615.53702.794957.958227@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Ulrich.Weigand@de.ibm.com> said:
Uli> So in the case of 8K page size, you need an order-2 allocation
Uli> for the stack, right?  How do you handle failures due to
Uli> fragmentation?

On Thu, Jun 06, 2002 at 02:19:02PM -0700, David Mosberger wrote:
> We don't do anything special.  I'm not sure what the fragmentation
> statistics look like on machines with 1+GB memory; it's something I
> have been wondering about and hoping to look into at some point (if
> someone has done that already, I'd love to see the results). In
> practice, every ia64 linux distro as of today ships with 16KB page
> size, so you only get order-1 allocations for stacks.

I've been collecting information on this as well, as I've been
maintaining a patch to support deferred coalescing in the page-level
allocator. Martin Bligh contributed the code to collect some
fragmentation statistics for that patch, which was originally written
for mainline 2.4. It's slightly less expensive in lazy_buddy, as the
algorithm requires some accounting anyway, but some other statistics
besides population counts for various block sizes might also be useful
to track here. I'm holding off until I read up on seq_file() and convert
the /proc/ reporting over to it before the next release of it, though I
do have more current diffs than I've announced. I wouldn't mind at all
hearing from those who have more stringent fragmentation requirements.

Cheers,
Bill
