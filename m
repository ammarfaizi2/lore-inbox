Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVINWEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVINWEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVINWEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:04:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15633 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965058AbVINWEA (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:04:00 -0400
Date: Wed, 14 Sep 2005 23:03:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
Message-ID: <20050914230352.G30746@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <432838E8.5030302@yahoo.com.au> <432839F1.5020907@yahoo.com.au> <43283B66.8080005@yahoo.com.au> <Pine.LNX.4.61.0509141829050.3743@scrub.home> <432854B6.1020408@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <432854B6.1020408@yahoo.com.au>; from nickpiggin@yahoo.com.au on Thu, Sep 15, 2005 at 02:49:58AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 02:49:58AM +1000, Nick Piggin wrote:
> Roman Zippel wrote:
> > Hi,
> > 
> > On Thu, 15 Sep 2005, Nick Piggin wrote:
> > 
> > 
> >>Is there any point in keeping this around?
> > 
> > 
> > Yes, for drivers which want to use it to synchronize with userspace.
> > Alternatively it could be changed into a Kconfig definition.
> > 
> 
> I think it already is. At least, I did grep for it and didn't
> see anything.
> 
> I think userspace synchronization may be quite a valid use of
> atomic cmpxchg, but Kconfig is a far better place to do it than
> testing HAVE_ARCH_CMPXCHG.

What business has userspace got of telling whether cmpxchg works on
an architecture by looking at kernel headers?

Even if an architecture provides an implementation of it, it might
rely on turning IRQs off, which may not be possible in userspace,
leading to the userspace version actually being non-atomic.

*Forget* kernel includes telling userspace what architecture
features are available.  It's extremely buggy by design.

If you want to remove HAVE_ARCH_CMPXCHG that's fine.  If userspace
complains, you've found a bug for them. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
