Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbRCDADC>; Sat, 3 Mar 2001 19:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRCDACw>; Sat, 3 Mar 2001 19:02:52 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:49205 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129874AbRCDACo>; Sat, 3 Mar 2001 19:02:44 -0500
Date: Sun, 4 Mar 2001 01:02:31 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Philipp Rumpf <prumpf@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com, Kernel list <kernel@linux-mandrake.com>
Subject: Re: [kernel] Re: [PATCH] 2.4.2: cure the kapm-idled taking (100-epsilon)%
 CPU time
In-Reply-To: <20010303172822.A18970@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0103040044550.922-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2001, Philipp Rumpf wrote:

> > Well, from reading the source, I don't see how this can break APM... What am I
> > missing?
> 
> apm_bios_call must not be called with two identical pointers for
> two different registers.
> 

OK, my bad... By replacing the call I made with this:

        u32     dummy, a, b, c, d;

        if (apm_bios_call(APM_FUNC_IDLE, 0, 0, &dummy, &a, &b, &c, &d))
                return 0;

then the situation is back to "normal"...

Just one more thing though: in apm_bios_call_simple():

[...]
    APM_DO_SAVE_SEGS;
    {
        int cx, dx, si;
[...]

Aren't cx, dx and si really meant to be u32?

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

