Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUD0Lgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUD0Lgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264014AbUD0Lgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:36:53 -0400
Received: from ozlabs.org ([203.10.76.45]:10114 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264012AbUD0Lgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:36:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16526.17872.872703.799153@cargo.ozlabs.ibm.com>
Date: Tue, 27 Apr 2004 21:36:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Keith Owens <kaos@sgi.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts on contended spinlocks 
In-Reply-To: <6087.1083051952@kao2.melbourne.sgi.com>
References: <1083048850.11576.19.camel@gaston>
	<6087.1083051952@kao2.melbourne.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> On Tue, 27 Apr 2004 16:54:11 +1000, 
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >Looks good, except as paulus noted that using 0 for flags in the
> >_raw_spin_lock() case is wrong, since 0 is a valid flags value
> >for some archs that could mean anything... 
> 
> 0 is valid for ia64, which is the only architecture that currently
> defines __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS.  If other architectures want
> to define __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS and they need a different
> flag value to indicate 'no flags available' then the 0 can be changed
> to an arch defined value.  Worry about that if it ever occurs.

I was just thinking yesterday that it would be good to reenable
interrupts during spin_lock_irq on ppc64.  I am hacking on the
spinlocks for ppc64 at the moment and this looks like something worth
adding.

Why not keep _raw_spin_lock as it is and only use _raw_spin_lock_flags
in the spin_lock_irq{,save} case?

Paul.
