Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUBQWHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266638AbUBQWD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:03:28 -0500
Received: from galileo.bork.org ([66.11.174.156]:39833 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S266649AbUBQWB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:01:57 -0500
Date: Tue, 17 Feb 2004 17:01:54 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, steiner@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Message-ID: <20040217220154.GT12142@localhost>
References: <20040217154926.GI12142@localhost> <20040217125038.14396a1d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217125038.14396a1d.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Feb 17, 2004 at 12:50:38PM -0800, Andrew Morton wrote:
> Martin Hicks <mort@wildopensource.com> wrote:
> >
> > Another optimization patch from Jack Steiner, intended to reduce TLB
> > flushes during process migration.
> 
> This patch is only applicable to CONFIG_NUMA.  Wouldn't SMP systems benefit
> from the same treatment?
> 
> And does this optimisation come with any benchmark results?

Here's some figures from Jack:

---

I dont have a benchmark for JUST the scheduler change, but the entire
node history + sched change is:

        nwchem on a 128p showed:

          Before:
            siosi7.sale.56-shm1cs: Time after atomic energies summed:   140.2
            siosi7.sale.120-shm1cs: Time after atomic energies summed:   306.9

          After:
            56p  = Time after atomic energies summed:    99.3
            120p = Time after atomic energies summed:   110.4

          Almost 3X improvement on 120p.

I dont recall how much was due to the sched fix, but I remember that it was
significant.

Note that the amount of improvement is highly platform specific.


---

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
