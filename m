Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbTCOSJn>; Sat, 15 Mar 2003 13:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbTCOSJn>; Sat, 15 Mar 2003 13:09:43 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59826 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261510AbTCOSJJ>;
	Sat, 15 Mar 2003 13:09:09 -0500
Message-Id: <200303151615.h2FGFw88003219@eeyore.valparaiso.cl>
To: Bryan Andersen <bryan@bogonomicon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dpt_i2o.c memleak/incorrectness 
In-Reply-To: Your message of "Thu, 13 Mar 2003 12:58:56 CST."
             <3E70D4F0.6060608@bogonomicon.net> 
Date: Sat, 15 Mar 2003 12:15:58 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Andersen <bryan@bogonomicon.net> dijo:
> >>   There is something strange going on in drivers/scsi/dpt_i2o.c in both
> >>   2.4 and 2.5. adpt_i2o_reset_hba() function allocates 4 bytes 
> >>   for "status" stuff, then tries to reset controller, then 
> >>   if timeout on first reset stage is reached, frees "status" and returns,
> >>   otherwise it proceeds to monitor "status" (which is modified by hardware
> >>   now, btw), and if timeout is reached, just exits.
> > 
> > Correctly - I2O does the same thing in this case. Its just better to
> > throw a few bytes away than risk corruption
> 
> Better document it in the comments or it will get "corrected" by some 
> mem leak detector.  If possible try to use a static for the pointer to 
> the status block, but that may not work.  Re-enterant code and multi CPU 
> situations likely won't allow for that.  Also it might not be worth the 
> effort to properly determin if it is safe to use only one location.

A device owned area, perhaps? To set up an area that can be messed around
without proper locking will get you problems down the line.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
