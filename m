Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbTA3BGh>; Wed, 29 Jan 2003 20:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTA3BGh>; Wed, 29 Jan 2003 20:06:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57754 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266962AbTA3BGg>;
	Wed, 29 Jan 2003 20:06:36 -0500
Subject: frlock and barrier discussion
From: Stephen Hemminger <shemminger@osdl.org>
To: Richard Henderson <rth@twiddle.net>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128230639.A17385@twiddle.net>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net>
	 <20030128230639.A17385@twiddle.net>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 29 Jan 2003 17:15:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 23:06, Richard Henderson wrote:
> On Tue, Jan 28, 2003 at 03:42:21PM -0800, Stephen Hemminger wrote:
> > +static inline void fr_write_begin(frlock_t *rw)
> > +{
> > +	preempt_disable();
> > +	rw->pre_sequence++;
> > +	wmb();
> > +}
> > +
> > +static inline void fr_write_end(frlock_t *rw)
> > +{
> > +	wmb();
> > +	rw->post_sequence++;
> 
> These need to be mb(), not wmb(), if you want the bits in between
> to actually happen in between, as with your xtime example.  At
> present there's nothing stoping xtime from being *read* before
> your read from pre_sequence happens.


First, write_begin/end can only be safely used when there is separate
writer synchronization such as a spin_lock or semaphore.  
As far as I know, semaphore or spin_lock guarantees a barrier.
So xtime or anything else can not be read before the spin_lock.

Using mb() is more paranoid than necessary. 




