Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbQKJSVR>; Fri, 10 Nov 2000 13:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQKJSVH>; Fri, 10 Nov 2000 13:21:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131118AbQKJSVB>; Fri, 10 Nov 2000 13:21:01 -0500
Message-ID: <3A0C3C7F.FF594CE9@transmeta.com>
Date: Fri, 10 Nov 2000 10:20:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: davej@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <Pine.LNX.4.21.0011101751080.514-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> 
> Hi hpa,
> 
>  First test, the AMD K6-2.
> 
> Before your patch..
>         cpu family      : 5
>         model           : 8
>         stepping        : 12
> 
> After..
> 
>         cpu family      : 5
>         model           : 8
>         stepping        : 4
> 
> Line 1826 of setup.c
> 
>         c->x86_mask = tfms & 7;
> 
> Should be..
> 
>         c->x86_mask = tfms & 15;
> 
> I think?
> 
> Also, look at the feature flags:
> before:
> flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
> 
> after:
> features        : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
> 
> Note, I lost MTRR & sep. This may be related to the stepping bug
> though. I'll recompile a kernel with the &15 fix, and see if that cures
> all.
> 

That is actually correct -- the K6-2 doesn't actually have mtrr and sep,
but has syscall and k6_mtrr instead (the stepping bug causes k6_mtrr not
to show up.)  Part of the bugginess of the old system was using one flag
for multiple purposes.  This was Linux' doing, not AMD's, by the way.

> btw, whilst all this is getting a shakedown, how about renaming
> that 'x86_mask' field to the more obvious 'x86_stepping' ?
> c->x86 would make more sense as c->x86_family too thinking about it.
> 

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
