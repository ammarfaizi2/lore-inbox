Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273132AbRIWC6C>; Sat, 22 Sep 2001 22:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273210AbRIWC5w>; Sat, 22 Sep 2001 22:57:52 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:13072 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273132AbRIWC5l>; Sat, 22 Sep 2001 22:57:41 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: safemode <safemode@speakeasy.net>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200109230016.f8N0G6G25222@zero.tech9.net>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
	<20010922211919Z272247-760+15646@vger.kernel.org>  
	<200109230016.f8N0G6G25222@zero.tech9.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 22 Sep 2001 22:58:12 -0400
Message-Id: <1001213894.873.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-22 at 20:15, safemode wrote:
> hrmm  strange because the only thing that could be causing the soundcard to 
> skip would be irq requests still stuck in the cpu as far as i know.  I only 
> get that with massive ide access and that's it.  Also that is when linux is 
> juggling them all equally. 

The soundcard will skip whenever there is not enough data for it to
play, this would be caused by the mp3 player not getting the needed CPU
time (or the PCI bus is saturated or some such).

This could be caused by more than just irq requests -- anytime the
kernel can't schedule the mp3 player readily enough.  With the
preemption patch, this can occur during not just interrupt handling but
any concurreny lock.

> > > even i dont get any skips when i run the player at nice -n -20.
> >
> > During dbench 16/32 and higher? Are you sure?
> 
> I ran it myself and i dont drink alcohol or take drugs.  so yea, i'm sure :)

Heh :)
 
> If i went high enough i suppose the same problem would occur.  it's probably 
> in an area of the kernel where the preempt patch doesn't work (yet).    It 
> does happen on cdparanoia -Z -B "1"    I dont think anything ide is safe from 
> that.    

By design, preemption does not occur under any lock (right now we use
SMP locks).  This means all the spinlocks in the kernel disable
preemption, the big kernel lock disables preemption, irq_off obviously
does, etc.

What we need to do now is identify the long held locks and -- if they
are causing problems -- do something about them.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

