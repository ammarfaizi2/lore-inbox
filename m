Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbRCaCDT>; Fri, 30 Mar 2001 21:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131950AbRCaCDJ>; Fri, 30 Mar 2001 21:03:09 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:24841 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S131942AbRCaCDC>; Fri, 30 Mar 2001 21:03:02 -0500
Message-ID: <3AC53A18.C08FFC38@vc.cvut.cz>
Date: Fri, 30 Mar 2001 17:59:52 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: J Brook <jbk@postmark.net>
CC: mythos <papadako@csd.uoc.gr>, Alan Olsen <alan@clueserver.org>,
   linux-kernel@vger.kernel.org
Subject: Re: Matrox G400 Dualhead
In-Reply-To: <20010331001238.10669.qmail@venus.postmark.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Brook wrote:
> 
> > Does anyone know why fualhead is not working anymore?
> > I just get a screen with rubbish on the second head.
> > Also when kernel loads and and registers fb1 I lose signal
> > on the second head.

On G400 there is no signal on second head after poweron. So you cannot
lose it ;-) On G450 there is same signal on both heads - but you are
talking about G400. Or no? They are very different (they have different
everything except PCI device ID register :-( ). You should add
'Option "UseFBDev"' into your XF86Config-4 - probably together with 
'Option "NoHWCursor"'.

> ...
> 
> >With 2.4.2 it was working just fine.
> 
> I have also noticed problems with the 2.4.3 release. I have a G450
> 32Mb, that I use in single-head mode. The console framebuffer runs
> fine at boot time, but when I load X (4.0.3 compiled with Matrox HAL
> library) and then return to the console, I get a blank screen (signal
> lost).

It is easy - do not do that. Matroxfb really does not expect that
someone
will powerdown parts of chip which matroxfb needs, but which XFree does
not use (for example clock source for secondary head) or that it will
change
some undocumented registers (for example Matrox HAL driver changes
memory
clock speed).
 
> I don't know what the problem is. I can confirm with Mythos that
> under
> 2.4.2 it was working just fine :-)

I have no idea what changed between 2.4.2 and 2.4.3 - I do not
remember that I was doing some changes into the matroxfb during
last few weeks - so maybe that source of these problems is in XFree
4.0.3 ?
					Petr Vandrovec
					vandrove@vc.cvut.cz
