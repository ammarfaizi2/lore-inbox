Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSDEKSi>; Fri, 5 Apr 2002 05:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDEKS3>; Fri, 5 Apr 2002 05:18:29 -0500
Received: from mail.sonytel.be ([193.74.243.200]:59298 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312460AbSDEKSS>;
	Fri, 5 Apr 2002 05:18:18 -0500
Date: Fri, 5 Apr 2002 12:18:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: "Jonathan A. Davis" <davis@jdhouse.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.4.19-pre5-ac2
In-Reply-To: <20020405065743.GA751@berserk.demon.co.uk>
Message-ID: <Pine.GSO.4.21.0204051216190.10408-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Peter Horton wrote:
> On Thu, Apr 04, 2002 at 08:19:49PM -0600, Jonathan A. Davis wrote:
> > The radeon updates in pre5-ac2 seem to make a minor mess out of my Radeon
> > 7500's console fb.  After X starts up -- switching back to a text console
> > results in artifacts from the X display contents plus borked scrolling.  
> > No tendency to crash though and switching back to X results in a normal X
> > display.  I dropped out the patches to:
> > 
> 
> Yep. The accelerator needs resetting on each console switch so that we
> can cope when X leaves it in a funky state. The new patch I posted
> yesterday should fix it, or for a quick fix add the lines
> 
> 	if(accel)
> 		radeon_engine_init_var();
> 
> after the call to do_install_cmap() in radeon_fb_setvar().

You have to reinit the acceleration engine if FB_ACCELF_TEXT is set again. If
this is already the case, you may be running an X server that's not fbdev aware
(or aren't using `option UseFBDev'?)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

