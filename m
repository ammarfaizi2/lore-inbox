Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUHSXmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUHSXmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUHSXmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:42:18 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:56728 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267528AbUHSXmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:42:16 -0400
Date: Thu, 19 Aug 2004 16:38:37 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
Message-ID: <20040819233837.GA2723@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <253460000.1092939952@flay> <200408191711.04776.jbarnes@engr.sgi.com> <200408191724.04422.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408191724.04422.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 05:24:04PM -0400, Jesse Barnes wrote:
> On Thursday, August 19, 2004 5:11 pm, Jesse Barnes wrote:
> > The output is attached (my mailer insists on wrapping it if I inline it). 
> > I used 'lockstat -w'.
> 
> The highlights:
> 
>  nw   spin   rjct  lock & function
> 19.0% 81.0%    0%  dcache_lock
>  3.3% 96.7%    0%    d_alloc+0x270
>  2.7% 97.3%    0%    d_delete+0x40
> 18.3% 81.7%    0%    d_instantiate+0x90
>  4.7% 95.3%    0%    d_move+0x60
> 34.6% 65.4%    0%    d_rehash+0xe0
> 19.1% 80.9%    0%    dput+0x40
> 10.5% 89.5%    0%    link_path_walk+0xef0
>    0%  100%    0%    sys_getcwd+0x210
> 
> 41.4% 58.6%    0%  rcu_state
> 61.3% 38.7%    0%    __rcu_process_callbacks+0x260
> 41.4% 58.6%    0%    rcu_check_quiescent_state+0xf0
> 
> So it looks like the dcache lock is the biggest problem on this system with 
> this load.  And although the rcu stuff has improved tremendously for this 
> system, it's still highly contended.

Was this run using all of Manfred's RCU patches?  If not, it would be
interesting to see what you get with full RCU_HUGE patchset.

							Thanx, Paul
