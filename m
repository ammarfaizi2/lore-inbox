Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289789AbSAWLk1>; Wed, 23 Jan 2002 06:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289796AbSAWLkV>; Wed, 23 Jan 2002 06:40:21 -0500
Received: from holomorphy.com ([216.36.33.161]:64130 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289789AbSAWLkK>;
	Wed, 23 Jan 2002 06:40:10 -0500
Date: Wed, 23 Jan 2002 03:39:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
        andrea@suse.de, alan@redhat.com, akpm@zip.com.au,
        vherva@niksula.hut.fi
Subject: Re: Athlon/AGP issue update
Message-ID: <20020123033942.B899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>,
	vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
	andrea@suse.de, alan@redhat.com, akpm@zip.com.au,
	vherva@niksula.hut.fi
In-Reply-To: <1011779573.9368.40.camel@inventor.gentoo.org> <200201231010.g0NAAuE05886@Port.imtp.ilyichevsk.odessa.ua> <20020123.022441.21593293.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020123.022441.21593293.davem@redhat.com>; from davem@redhat.com on Wed, Jan 23, 2002 at 02:24:41AM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 02:24:41AM -0800, David S. Miller wrote:
> He can only mean by this that there is some branch protected store
> (not taken) to the 4MB linear mappings used by the kernel (starting
> at PAGE_OFFSET).
> But the only thing I am still confused about, is what 4MB mappings
> have to do with any of this.  What I take from the description is that
> the problem will still exist after 4MB mappings are disabled.  What
> prevents the processor from doing the speculative store to the
> cacheable mappings once 4MB pages are disabled?

The range of addresses where speculation is attempted is partially
limited by the page size, for it's unlikely the CPU will attempt to
resolve TLB misses during speculative memory access until it's
committed to them. Furthermore the separate TLB's for 4KB and 4MB
pages on i386 allow far more TLB hits during speculation.

On Wed, Jan 23, 2002 at 02:24:41AM -0800, David S. Miller wrote:
> At best, I bet turning off 4MB pages makes the bug less likely.
> It does not eliminate the chance to hit the bug.
> So what it sounds like is that if there is any cacheable mapping
> _WHATSOEVER_ to physical memory accessible by the GART, the problem
> can occur due to a speculative store being cancelled.
> A real fix would be much more involved, therefore.
> In fact, we map the GART mapped memory to the user fully cacheable.

Controlling how page tables are edited and/or statically set up does
not seem that far out to me, though it could be inconvenient,
especially with respect to dynamically-created translations such as
are done for user pages, as there is essentially no infrastructure
for controlling the cacheable attribute(s) of user mappings now as
I understand it.

On Wed, Jan 23, 2002 at 02:24:41AM -0800, David S. Miller wrote:
> That would have to be fixed, plus we'd need to mark non-cacheable the
> linear PAGE_OFFSET mappings of the kernel (4MB or not) as well.

I would be concerned about efficiency if a larger portion of the direct-
mapped kernel virtual address space than necessary were uncacheable.
Otherwise, if I understand this properly (pardon me for being conservative
in my interpretation) you refer only to the kernel mappings of memory used
by the GART.


Cheers,
Bill
