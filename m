Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSAPR42>; Wed, 16 Jan 2002 12:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbSAPR4X>; Wed, 16 Jan 2002 12:56:23 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:55680
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S285161AbSAPRyp>; Wed, 16 Jan 2002 12:54:45 -0500
Date: Wed, 16 Jan 2002 10:54:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Lukas Geyer <geyer@ml.kva.se>
Subject: Re: Two issues with 2.4.18pre3 on PPC
Message-ID: <20020116175450.GD771@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se> <20020116163737.29030@mailhost.mipsys.com> <20020116170554.GA771@cpe-24-221-152-185.az.sprintbbd.net> <20020116121058.B5940@thyrsus.com> <20020116173116.GC771@cpe-24-221-152-185.az.sprintbbd.net> <20020116122525.A6712@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116122525.A6712@thyrsus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 12:25:25PM -0500, Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
> > Unless the user wants to use drivers/char/rtc.c because they're on a
> > chrp or prep box.
> 
> OK, so the derivation right side should change a little (I'll take a patch).

The problem is both drivers are viable options on PPC, and it's possible
to build a kernel (CONFIG_ALL_PPC) that works on both systems that can't
use d/c/rtc.c (pmac) and ones that can (chrp/prep).  And there are users
of d/c/rtc.c on that config even.
 
> The actual point is one of design philosophy.  Instead of presenting the 
> ser with unnecessarily platform-specific questions, we should be asking
> platform-independent (wherever this is possible) questions about the 
> *capabilities* he/she wants and mixing that wuith information about the
> platform.

I mostly agree.  But there's the design problem of 'CONFIG_RTC' meaning
PC-style RTC chip.  Just like 'CONFIG_SERIAL' currently means
ns1655x-style uarts.  Both of these should (and hopefully will) be fixed
in 2.5.x.  CONFIG_RTC should be mean, we have some sort of Real Time
Clock, now give it to me.  The code driver should be able to be told
what kind of clock we have (which, it currently can't, which is why
there's 3 'generic' rtc drivers but only 1 of which is in kernel.org
now).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
