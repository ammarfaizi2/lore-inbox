Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWCHXpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWCHXpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWCHXpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:45:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751092AbWCHXpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:45:21 -0500
Date: Wed, 8 Mar 2006 15:43:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: kiran@scalex86.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add
 percpu_counter_mod_bh
Message-Id: <20060308154321.0e779111.akpm@osdl.org>
In-Reply-To: <20060308224140.GC5410@kvack.org>
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308015934.GB9062@localhost.localdomain>
	<20060307181301.4dd6aa96.akpm@osdl.org>
	<20060308202656.GA4493@localhost.localdomain>
	<20060308203642.GZ5410@kvack.org>
	<20060308210726.GD4493@localhost.localdomain>
	<20060308211733.GA5410@kvack.org>
	<20060308222528.GE4493@localhost.localdomain>
	<20060308224140.GC5410@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Wed, Mar 08, 2006 at 02:25:28PM -0800, Ravikiran G Thirumalai wrote:
> > Then, for the batched percpu_counters, we could gain by using local_t only for 
> > the UP case. But we will have to have a new local_long_t implementation 
> > for that.  Do you think just one use case of local_long_t warrants for a new
> > set of apis?
> 
> I think it may make more sense to simply convert local_t into a long, given 
> that most of the users will be things like stats counters.
> 

Yes, I agree that making local_t signed would be better.  It's consistent
with atomic_t, atomic64_t and atomic_long_t and it's a bit more flexible.

Perhaps.  A lot of applications would just be upcounters for statistics,
where unsigned is desired.  But I think the consistency argument wins out.

