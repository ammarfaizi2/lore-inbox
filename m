Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbVLWTGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVLWTGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 14:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbVLWTGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 14:06:06 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:62420 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161004AbVLWTGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 14:06:05 -0500
Subject: Re: [WTF?] sys_tas() on m32r
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20051223055526.bc1a4044.akpm@osdl.org>
References: <20051223061556.GR27946@ftp.linux.org.uk>
	 <20051223055526.bc1a4044.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 14:10:34 -0500
Message-Id: <1135365035.22177.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 05:55 -0800, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > asmlinkage int sys_tas(int *addr)
> > {
> >         int oldval;
> >         unsigned long flags;
> > 
> >         if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
> >                 return -EFAULT;
> >         local_irq_save(flags);
> >         oldval = *addr;
> >         if (!oldval)
> >                 *addr = 1;
> >         local_irq_restore(flags);
> >         return oldval;
> > }
> > in arch/m32r/kernel/sys_m32r.c.  Trivial oops *AND* ability to trigger
> > IO with interrupts disabled.
> 
> Yeah.  I pointed this out to Takata in October last year and then promptly
> forgot about it.  It's rather amazing that this code (which appears to be in
> live use in linuxthreads) hasn't generated oopses.

No one uses LinuxThreads anymore?

Even the oldest of the old (Debian stable) have moved to NPTL.

Lee

