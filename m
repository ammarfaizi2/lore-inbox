Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbQKJSKq>; Fri, 10 Nov 2000 13:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130741AbQKJSKg>; Fri, 10 Nov 2000 13:10:36 -0500
Received: from neodymium.btinternet.com ([194.73.73.83]:17605 "EHLO
	neodymium.btinternet.com") by vger.kernel.org with ESMTP
	id <S130507AbQKJSKV>; Fri, 10 Nov 2000 13:10:21 -0500
From: davej@suse.de
Date: Fri, 10 Nov 2000 17:56:45 +0000 (GMT)
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <3A0B6B43.D1210AAA@transmeta.com>
Message-ID: <Pine.LNX.4.21.0011101751080.514-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi hpa,

 First test, the AMD K6-2.

Before your patch..
	cpu family      : 5
	model           : 8
	stepping        : 12

After..

	cpu family      : 5
	model           : 8
	stepping        : 4

Line 1826 of setup.c

	c->x86_mask = tfms & 7;

Should be..

	c->x86_mask = tfms & 15;

I think?

Also, look at the feature flags:
before:
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow

after:
features        : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow

Note, I lost MTRR & sep. This may be related to the stepping bug
though. I'll recompile a kernel with the &15 fix, and see if that cures
all.

btw, whilst all this is getting a shakedown, how about renaming
that 'x86_mask' field to the more obvious 'x86_stepping' ?
c->x86 would make more sense as c->x86_family too thinking about it.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
