Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288532AbSADICf>; Fri, 4 Jan 2002 03:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288533AbSADIC0>; Fri, 4 Jan 2002 03:02:26 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:30226 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S288531AbSADICS>;
	Fri, 4 Jan 2002 03:02:18 -0500
Date: Thu, 3 Jan 2002 23:39:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103233942.A12380@elf.ucw.cz>
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu> <25193.1010018130@redhat.com> <20020103021021.GW1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103021021.GW1803@cpe-24-221-152-185.az.sprintbbd.net>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (cc list trimmed)
> > 
> > alan@lxorguk.ukuu.org.uk said:
> > >  If you want a strcpy that isnt strcpy then change its name or use a
> > > different language 8)
> > 
> > The former is not necessarily sufficient in this case. You've still done the
> > broken pointer arithmetic, so even if the function isn't called strcpy() the
> > compiler is _still_ entitled to replace it with a call to memcpy() or even
> > machine_restart() before sleeping with your mother and starting WW III.
> > 
> > Granted, it probably _won't_ do any of those today, but you should know
> > better than to rely on that.
> > 
> > What part of 'undefined behaviour' is so difficult for people to understand?
> 
> I think it comes down to an expectation that if the behaviour is
> undefined, anything _could_ happen, but what should happen is that it
> should just be passed along to (in this case) strcpy un-modified.

gcc is allowed not to pass it anywhere. You may not second guess
optimizer. If it is not defined, it is not defined.

Imagine

strcpy(a, "xyzzy"+b);
if (b>16)
	printf("foo");

. gcc is permitted to kill printf(), because if b<0 or b>16 behaviour is
undefined. So gcc may assume b<=16.

Quoting alan: 

################################################################################
# What part of 'undefined behaviour' is so difficult for people to understand? #
################################################################################

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
