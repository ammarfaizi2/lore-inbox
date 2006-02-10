Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWBJFkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWBJFkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWBJFkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:40:51 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:48707 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751124AbWBJFkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:40:51 -0500
Date: Fri, 10 Feb 2006 14:40:37 +0900
To: Andi Kleen <ak@suse.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: remove __alpha_cix__ and __alpha_fix__
Message-ID: <20060210054037.GA6374@miraclelinux.com>
References: <20060201090224.536581000@localhost.localdomain> <200602011006.09596.ak@suse.de> <43E07EB2.4020409@tls.msk.ru> <200602011124.29423.ak@suse.de> <20060202125007.GA5918@miraclelinux.com> <20060209055531.GA2642@miraclelinux.com> <20060209191236.GA7259@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209191236.GA7259@twiddle.net>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 11:12:36AM -0800, Richard Henderson wrote:
> On Thu, Feb 09, 2006 at 02:55:31PM +0900, Akinobu Mita wrote:
> > -#if defined(__alpha_fix__) && defined(__alpha_cix__)
> > +#ifdef CONFIG_ALPHA_EV67
> 
> What in the world is this supposed to fix?  You aren't seriously
> suggesting that the compiler has stopped defining these, have you?

I just want to imply the use of optimized hweight*() routines to
kbuild system.  In other word I want to tell the kbuild system
the condition of "defined(__alpha_fix__) && defined(__alpha_cix__)".

So I suggested to add previous patch and write below lines in
arch/alpha/Kconfig

config GENERIC_HWEIGHT
        bool
        default y if !ALPHA_EV6 && !ALPHA_EV67

Also, I wonder why there are such gcc builtin definition in kernel code.
Even if the gcc built with the support architecture extensions like CIX
and FIX, It doesn't mean the vmlinux built by that gcc always run
on those machines.

