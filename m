Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbSAPRG3>; Wed, 16 Jan 2002 12:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSAPRGQ>; Wed, 16 Jan 2002 12:06:16 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:19328
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S281214AbSAPRF7>; Wed, 16 Jan 2002 12:05:59 -0500
Date: Wed, 16 Jan 2002 10:05:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Cc: linux-kernel@vger.kernel.org, Lukas Geyer <geyer@ml.kva.se>
Subject: Re: Two issues with 2.4.18pre3 on PPC
Message-ID: <20020116170554.GA771@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se> <20020116163737.29030@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116163737.29030@mailhost.mipsys.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 05:37:37PM +0100, benh@kernel.crashing.org wrote:
> >- The generic RTC driver in drivers/char/rtc.c does not work for this
> >  iBook. The driver in drivers/macintosh/rtc.c does work, but it only
> >  implements the two ioctls RTC_RD_TIME and RTC_SET_TIME. (Is this due to
> >  hardware limitations?) Anyway, it is confusing to have both drivers
> >  configurable for PPC, maybe the corresponding Config.in files should be
> >  adjusted. (In addition, this is complicated by the fact that both
> >  configuration options appear in different submenus and if you select
> >  both as modules, then the generic driver will "shadow" the macintosh
> >  one.)
> 
> That's a weirdness we haven't solved yet. Part of the problem is
> that a common kernel can boot pmac, chrp and prep, and the later
> ones can use the drivers/char/rtc.c driver. Actually, the
> drivers/macintosh/rtc.c one may work on these too as it's just
> a wrapper on some platform code selected at runtime depending on
> the machine class.

drivers/macintosh/rtc.c works on every PPC system, except for APUS (they
have their own generic rtc driver from m68k they use).  This is a know
'issue' with 2.4, that's not really solvable for the reason Ben
mentioned.  In 2.5 hopefully we'll replace drivers/char/rtc.c with a
generic rtc driver (and remove the PPC, MIPS and m68k generic drivers at
the same time).

Eric, do you think you could modify the CONFIG_RTC help entry to mention
that on PPC you should use the CONFIG_PPC_RTC option and not CONFIG_RTC,
if in doubt?  That's probably the best fix for 2.4.x

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
