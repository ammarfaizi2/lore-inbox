Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132801AbRDDMUn>; Wed, 4 Apr 2001 08:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRDDMUY>; Wed, 4 Apr 2001 08:20:24 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:7672 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S132801AbRDDMUO>; Wed, 4 Apr 2001 08:20:14 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: console.c unblank_screen problem
Date: Wed, 4 Apr 2001 14:18:56 +0200
Message-Id: <20010404121856.1992@mailhost.mipsys.com>
In-Reply-To: <200104041109.NAA28776@harpo.it.uu.se>
In-Reply-To: <200104041109.NAA28776@harpo.it.uu.se>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Thanks for this patch. I've been using it on my Dell Latitude laptop
>for the last 10 days, and it has been a significant improvement.
>
>Before the patch: After a few days with a 2.4 kernel and RH7.0
>(XFree86-4.0.1-1 and XFree86-SVGA-3.3.6-33) the latop would
>misbehave at a resume event: when I opened the lid the screen would
>unblank and then after less than a second the entire screen would
>shift (wrap/rotate) left by about 40% of its width. Restarting X
>would only fix this temporarily, as the next resume would have the
>same problem. This does not occur with a 2.2 kernel or with the
>Accelerated-X server I used before.
>
>With the patch: No problem after 10 days with frequent suspend/resume
>cycles. (2.4.2-ac24 + the patch)
>
>[Alan, mind putting this in the next 2.4.3-ac? I've rediffed it
>against 2.4.3-ac2.]

Glad to get some feedback !

I'm still getting other problems related to console.c power management
however. On the PowerBook, occasionally, if suspend is triggered from
a text console, the machine may hang during the sleep process. I don't
quite understand that code in console.c anyway since it seems to trigger
a timer to later call the VESA blank. That timer thing doesn't makes much
sense to me, especially since when the timer fire (if it ever fires),
the machine will probably be sleeping. 

The problem with it on powerbooks is that we do suspend the graphic chip
from fbdev layer (later on).
So if after this timer expires, the console code tries to access the chip
in any way, bad things will happen (it will die).

I'm working on workaround at the fbdev level, but I'm curious to know
if that PM code in console.c is useful at all in it's current form,
especially since it plays those tricks with timers which don't seem like
a good idea when the machine is going to sleep.

Ben.



