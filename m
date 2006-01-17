Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWAQBJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWAQBJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 20:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWAQBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 20:09:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751320AbWAQBJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 20:09:49 -0500
Date: Mon, 16 Jan 2006 17:09:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave C Boutcher <sleddog@us.ibm.com>
Cc: serue@us.ibm.com, michael@ellerman.id.au, linuxppc64-dev@ozlabs.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: 2.6.15-mm4 failure on power5
Message-Id: <20060116170907.60149236.akpm@osdl.org>
In-Reply-To: <20060116215252.GA10538@cs.umn.edu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com>
	<20060115230557.0f07a55c.akpm@osdl.org>
	<200601170000.58134.michael@ellerman.id.au>
	<20060116153748.GA25866@sergelap.austin.ibm.com>
	<20060116215252.GA10538@cs.umn.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave C Boutcher <sleddog@us.ibm.com> wrote:
>
> On Mon, Jan 16, 2006 at 09:37:48AM -0600, Serge E. Hallyn wrote:
> > Quoting Michael Ellerman (michael@ellerman.id.au):
> > > On Mon, 16 Jan 2006 18:05, Andrew Morton wrote:
> > > > "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > > > > On my power5 partition, 2.6.15-mm4 hangs on boot
> > 
> > boot: quicktest
> > Please wait, loading kernel...
> 
> ...
> 
> > Page orders: linear mapping = 24, others = 12
> >  -> smp_release_cpus()
> >  <- smp_release_cpus()
> >  <- setup_system()
> > 
> > So setup_system() at least finishes, though I don't see the
> > printk's at the bottom of that function.
> 
> 2.6.15-mm4 won't boot on my power5 either.  I tracked it down to the
> following mutex patch from Ingo: kernel-kernel-cpuc-to-mutexes.patch

Thanks for doing that - I know it's a lot of work, but boy it helps.

<mutters something unprintable about mutex patches and work prioritisation>

> If I revert just that patch, mm4 boots fine.  Its really not obvious to
> me at all why that patch is breaking things though...
> 

Yes, that is strange.  I do recall that if something accidentally enables
interrupts too early in boot, ppc64 machines tend to go comatose.  But if
we'd been running that code under local_irq_disable(), down() would have
spat a warning.

Drat, it seems I don't have CPU hotplug in my ppc64 config.
