Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSBSTm5>; Tue, 19 Feb 2002 14:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSBSTmq>; Tue, 19 Feb 2002 14:42:46 -0500
Received: from rj.SGI.COM ([204.94.215.100]:47320 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S286934AbSBSTmc>;
	Tue, 19 Feb 2002 14:42:32 -0500
Date: Tue, 19 Feb 2002 11:42:22 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: David Mosberger <davidm@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readl/writel and memory barriers
Message-ID: <20020219114222.A1511407@sgi.com>
Mail-Followup-To: David Mosberger <davidm@hpl.hp.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase> <15474.34580.625864.963930@napali.hpl.hp.com> <20020219103506.A1511175@sgi.com> <15474.43138.423593.512492@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15474.43138.423593.512492@napali.hpl.hp.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 11:33:22AM -0800, David Mosberger wrote:
> It certainly does for on ia64-compliant system.  Check section 9.3
> "Multi-threaded Code" in the "Itanium Software Conventions and Runtime
> Architecture manual".

I don't have that doc handy, but I'll trust your judgement...

> Now, with NUMA platforms, where the chipsets/switch may re-order
> accesses, the performance hit will be much bigger, so the old scheme
> may not be sufficient.

Right.  I still have to do some performance measurements, but I
suspect that as the system size goes up, we'll see the I/O ordering
penalty increase.  It'll probably get noticable at around 64p.

> I'm no NUMA expert, but my guess is that nobody will want to go
> through all the existing drivers to change them to use mmiob().  For
> new drivers, it might be OK.

The source level impact should actually be pretty small.  An mmiob()
prior to the spin_unlock in a critical section that does I/O usually
suffices.  Maybe it would be a good idea to have io_spin_lock and
io_spin_unlock for this purpose?

Thanks,
Jesse
