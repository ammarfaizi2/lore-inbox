Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRCOF3z>; Thu, 15 Mar 2001 00:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131649AbRCOF3q>; Thu, 15 Mar 2001 00:29:46 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:59584 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131587AbRCOF3g>; Thu, 15 Mar 2001 00:29:36 -0500
Date: Wed, 14 Mar 2001 13:30:03 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Brad Douglas <brad@neruo.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Message-ID: <Pine.LNX.4.31.0103141321040.779-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>But wouldn't falling back to dummycon prevent the driver specific
>suspend/resume calls from working?  Or at a minimum, make handling those
>calls more complex?

Not if suspend/resume are handled on the fbdev driver level. Dummycon
would only shutdown fbcon on explict open of /dev/fb. Also note it will be
possible to have only a serial console and use /dev/fb by itself. In this
case we don't even need dummycon since their is no VT support present.

>No, there does not need to be graphical images of the text console -- a
>simply text buffer would suffice.

See email to Ben.

>But what about things like GTKFb and
>Embedded QT?  They would certainly benefit from having a backup screen
>image, right?  I do not believe there is any way to determine if the
>console is in fact in a 'text' or graphical state.

Yes and it would not be hard to do this. I have the basic idea in the
email to Ben. As for console in text or graphical state take a look at
vt_ioctl.c:vt_ioctl() for KDGETMODE. You get back KD_TEXT or KD_GRAPHICS.


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

