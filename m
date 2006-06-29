Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWF2QcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWF2QcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWF2QcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:32:00 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34503 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750891AbWF2Qb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:31:59 -0400
Date: Thu, 29 Jun 2006 09:32:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060629163236.GD1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629142442.GA11546@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 04:24:42PM +0200, Ingo Molnar wrote:
> 
> * Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > OK, I need to catch up, but I see a lot of oops while running 
> > rcutorture in my box (rt1). I am investigating this atm.
> 
> fyi, 2.6.17-mm4 throws tons of these:
> 
>  BUG: scheduling while atomic: rcu_torture_rea/0x00010000/1471
>   [<c0106123>] show_trace+0xd/0x10
>   [<c010613d>] dump_stack+0x17/0x1a
>   [<c123b4e2>] schedule+0x61/0xc61
>   [<c015f380>] rcu_torture_reader+0x12e/0x17e
>   [<c014101f>] kthread+0xc4/0xf0
>   [<c0102005>] kernel_thread_helper+0x5/0xb

Probably the fault of my new ops-ization of rcutorture.c.  :-/
(For whatever it is worth, Dipankar would still be using the older
non-ops-ized version of rcutorture.c.)

Did you get these oopses with default setting of torture_type, or did you
specify torture_type=rcu_bh or torture_type=srcu to the modprobe command?

This was on i386, x86_64, or on something else?

Ah!  This would have been a CONFIG_PREEMPT build, right?

						Thanx, Paul
