Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314516AbSDXEkd>; Wed, 24 Apr 2002 00:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314523AbSDXEkc>; Wed, 24 Apr 2002 00:40:32 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:47371 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314516AbSDXEkc>; Wed, 24 Apr 2002 00:40:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: in_interrupt race 
Cc: linux-kernel@vger.kernel.org
In-Reply-To: Your message of "Tue, 23 Apr 2002 09:31:51 +0100."
             <20020423093151.A17302@flint.arm.linux.org.uk> 
Date: Wed, 24 Apr 2002 14:43:04 +1000
Message-Id: <E170EcT-0003bW-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020423093151.A17302@flint.arm.linux.org.uk> you write:
> On Tue, Apr 23, 2002 at 01:25:24PM +1000, Rusty Russell wrote:
> > Yes: the old CPU happens to be processing an interrupt now.
> > The neat solution is to follow Linus' original instinct and make
> > PREEMPT an option only for UP: I only like preempt because it brings
> > UP into line with SMP, effectively enlarging the SMP userbase to reasonable
> > size.
> 
> > -bool 'Preemptible kernel' CONFIG_PREEMPT
> > +dep_bool 'Preemptible kernel' CONFIG_PREEMPT $CONFIG_SMP
> > -bool 'Preemptible Kernel' CONFIG_PREEMPT
> > +dep_bool 'Preemptible Kernel' CONFIG_PREEMPT $CONFIG_SMP
> 
> Do you really mean that CONFIG_PREEMPT is only available if CONFIG_SMP is
> 'y' or undefined?

<sigh>... Of course that should be reversed.
if [ "$CONFIG_SMP" != y ]; then
   bool 'Preemptible Kernel' CONFIG_PREEMPT
fi

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
