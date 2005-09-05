Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVIEHoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVIEHoc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVIEHoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:44:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22543 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932276AbVIEHoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:44:32 -0400
Date: Mon, 5 Sep 2005 08:44:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905084425.B24051@flint.arm.linux.org.uk>
Mail-Followup-To: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050905070053.GA7329@in.ibm.com>; from vatsa@in.ibm.com on Mon, Sep 05, 2005 at 12:30:53PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 12:30:53PM +0530, Srivatsa Vaddagiri wrote:
> On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > First of all, and maybe this is just me, I think it would be good to
> > make the dyn_tick_timer per-interrupt source, as opposed to each arch?
> 
> Nish, may be a good idea as it may make the code more cleaner (it will
> remove the 'if (cpu_has_local_apic())' kind of code that is there
> currently in x86). However note that ARM currently has 'handler' member also 
> part of it, which is used to recover time and that has nothing to do with 
> interrupt source. Unless there is something like John's TOD, we still
> need to recover time in a arch-dependent fashion ..Where do you
> propose to have that 'handler' member?

Exactly where it is.  It's there because of the problem you allude to
above - it's there to catch up system time.  Any generic code can't
answer the question "how much time has passed since we disabled the
timer" without additional information.

However, we could change "handler" to be a function pointer which
returns the number of missed ticks instead, and then updates the
kernels time and tick keeping.  That would probably be more efficient.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
