Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263414AbRFRXVR>; Mon, 18 Jun 2001 19:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRFRXVH>; Mon, 18 Jun 2001 19:21:07 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:6408 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S263414AbRFRXVC>; Mon, 18 Jun 2001 19:21:02 -0400
Date: Mon, 18 Jun 2001 18:20:52 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC2068@orsmsx42.jf.intel.com>
Subject: Re: gnu asm help...
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <z0dk5C.A.DoE.WzoL7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Raj, Ashok" <ashok.raj@intel.com> on Mon, 18 Jun 2001
15:56:50 -0700


> also if there is any reference to the gnu asm symtax, please send me a
> pointer.. 

There's lots

> i can understand what the LOCK "incl %0 means.. but not sure what the rest
> is for.

LOCK just means the x86 "lock" prefix.

incl is the 32-bit version of "inc" (incremement)

You want to return the variable?  Try this:

static __inline__ unsigned long atomic_inc(atomic_t *v)
{
    __asm__ __volatile__(
        LOCK "incl %0"
        :"=m" (v->counter)
        :"m" (v->counter));

    return v->counter;
}


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

