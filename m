Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132531AbRDQDhK>; Mon, 16 Apr 2001 23:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132534AbRDQDhA>; Mon, 16 Apr 2001 23:37:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6143 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132531AbRDQDgp>; Mon, 16 Apr 2001 23:36:45 -0400
Date: Tue, 17 Apr 2001 09:07:40 +0530
From: Maneesh Soni <smaneesh@in.ibm.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module load/unload race protection?
Message-ID: <20010417090740.A10775@in.ibm.com>
Reply-To: smaneesh@in.ibm.com
In-Reply-To: <200104141026.MAA22602@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200104141026.MAA22602@harpo.it.uu.se>; from mikpe@csd.uu.se on Sat, Apr 14, 2001 at 12:26:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 12:26:40PM +0200, Mikael Pettersson wrote:
> Does the kernel's module loader (kernel/module.c, not kmod)
> protect adequately against concurrent load/load or load/unload
> requests? The question applies to both 2.2 and 2.4 kernels.
> 
> I'm trying to track down a problem where a user using a
> RedHat 2.2.17-14 SMP kernel managed to trigger a situation where
> a driver module had been unloaded while still being in use
> (as in "the kernel has pointers into it", not USE_COUNT != 0).
> I'm reviewing the driver's internal INC/DEC_USE_COUNT usage,
> but so far I've not found any obvious errors.
> 
> /Mikael

There are race conditions while module unloading, present in both 2.2 and 2.4
kernels. Efforts are being made in handling these races by using
read-copy-update mechanism (http://lse.sourceforge.net/locking/rclock.html)
and by using synchronize_kernel() (from Rusty Russell, Keith Owens).
 
 
Regards,
Maneesh                                                                         

-- 
Maneesh Soni <smaneesh@in.ibm.com>
http://lse.sourceforge.net/locking/rclock.html
IBM Linux Technology Center,
IBM Software Lab, Bangalore, India
