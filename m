Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280531AbRLGNXv>; Fri, 7 Dec 2001 08:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280805AbRLGNXi>; Fri, 7 Dec 2001 08:23:38 -0500
Received: from ns.suse.de ([213.95.15.193]:50183 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280531AbRLGNXZ>;
	Fri, 7 Dec 2001 08:23:25 -0500
Date: Fri, 7 Dec 2001 14:23:21 +0100
From: Andi Kleen <ak@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@zip.com.au>,
        riel@conectiva.com.br, kiran@in.ibm.com,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011207142321.A7652@wotan.suse.de>
In-Reply-To: <20011205163153.E16315@in.ibm.com> <Pine.LNX.4.33L.0112051109340.4079-100000@imladris.surriel.com> <3C0E7ED9.1F0BD44E@zip.com.au> <20011206141826.16833acc.rusty@rustcorp.com.au> <20011207182214.D15810@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207182214.D15810@in.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 06:22:14PM +0530, Dipankar Sarma wrote:
> Your per-cpu area patch looks like a good solution with a very simple
> implementation. BTW, some OSes map the per-cpu data areas
> to the same virtual address for each CPU avoiding the per-cpu data
> array lookup. I am not sure if this really saves much, we are ourselves
> trying to understand the overhead of such array lookup with 
> statctrs. 

Using virtual addresses with per cpu mappings would be rather difficult to 
implement for i386, because it uses the linux page table directly in 
hardware. It would mean that you couldn't simply reuse the same top level
page for all clone()s sharing the same mm_struct, but would need to allocate
one per CPU. 

On i386 the old method from the SGI PDA patch looks cheapest: just having
a pointer in task_struct and set it in the scheduler.

-Andi
