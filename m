Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261882AbSI3Ayj>; Sun, 29 Sep 2002 20:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbSI3Ayj>; Sun, 29 Sep 2002 20:54:39 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:25107 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261882AbSI3Ayh>; Sun, 29 Sep 2002 20:54:37 -0400
Message-Id: <200209300059.g8U0xoNa025046@pincoya.inf.utfsm.cl>
To: Gerald Britton <gbritton@alum.mit.edu>
cc: Dominik Brodowski <linux@brodo.de>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers 
In-Reply-To: Message from Gerald Britton <gbritton@alum.mit.edu> 
   of "Sun, 29 Sep 2002 15:56:48 -0400." <20020929155648.A20308@light-brigade.mit.edu> 
Date: Sun, 29 Sep 2002 20:59:50 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerald Britton <gbritton@alum.mit.edu> said:
> On Sun, Sep 29, 2002 at 12:10:18PM +0200, Dominik Brodowski wrote:
> > I think I found the problem: it should be GFP_ATOMIC and not GFP_KERNEL in
> > the allocation of struct cpufreq_driver. Will be fixed in the next release.
> 
> Nope.  That should be fine, it's in a process context and not holding any
> locks, so GFP_KERNEL should be fine.  I found the bug though:
>  
> -driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_dri
> ver));
> +driver->policy = (struct cpufreq_policy *) (driver + 1);
>  
> Remember your pointer arithmetic.

Perhaps you should create a local variable of the right type:

   struct cpufreq_policy *local_var = (struct cpufreq_policy *)driver;

   driver->policy = &local_var[1];

(gcc should be smart enough to loose it)

[In any case, making this part of driver point at itself looks wrong to me...]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
