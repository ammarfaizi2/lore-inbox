Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVKWUjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVKWUjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVKWUi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:38:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932367AbVKWUi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:38:58 -0500
Date: Wed, 23 Nov 2005 21:38:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Johannes Stezenbach <js@linuxtv.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.15-rc2
Message-ID: <20051123203856.GU3963@stusta.de>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net> <200511222336.48506.gene.heskett@verizon.net> <20051123174237.GO3963@stusta.de> <4384C059.3070003@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384C059.3070003@m1k.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 02:17:45PM -0500, Michael Krufky wrote:
> Adrian Bunk wrote:
> 
> >On Tue, Nov 22, 2005 at 11:36:48PM -0500, Gene Heskett wrote:
> > 
> >
> >>...
> >>Well, I just went thru it again, and turned off everything but the
> >>cx8800 and ORv51132 stuffs, and now I get this at the and of the
> >>'makeit' script I use here:
> >>
> >>WARNING:
> >>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> >>needs unknown symbol mt352_attach
> >>WARNING:
> >>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> >>needs unknown symbol nxt200x_attach
> >>WARNING:
> >>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> >>needs unknown symbol mt352_write
> >>WARNING:
> >>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> >>needs unknown symbol lgdt330x_attach
> >>WARNING:
> >>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> >>needs unknown symbol cx22702_attach
> >>...
> >>   
> >>
> >Nice catch and thanks for your report.
> >
> >The bug is obvious. A possible patch is below (and at least 
> >drivers/media/video/saa7134/Makefile contains the same bug),
> >but I'd really prfer getting rid of the -DHAVE_* stuff in the
> >Makefiles and using Kconfig variables instead.
> > 
> >
> We need to keep the -DHAVE_FOO stuff there, in order to satisfy the 
> following requirements:
> 
> 1) To allow the option of only selecting those frontends required by 
> specific dvb hardware, without forcing all modules to be loaded... This 
> feature is optional, and I implemented it in response to the demand from 
> some hybrid v4l/dvb device users, (and myself)  Why force a driver to 
> load every frontend module if it isnt required by the hardware? -- 
> apparantly the implementation was less than perfect.  I had originally 
> intended for this to live in -mm for a bit, but when the merge window 
> came around, Mauro had sent it upstream before I had the chance to 
> create alternate patches for linus' tree.
> 
> 2) (more importantly) To allow v4l-kernel cvs to retain backwards 
> compatability with older kernels..
> 
> I had originally tried to rename these to use the Kconfig variables, but 
> LKML people asked for it to be changed back.
> 
> Please do not remove this feature -- if it is broken, then we should try 
> to fix it, rather than remove it.  If the specific frontend selection 
> isn't working, then I guess we can revert back to the old behavior where 
> every frontend is forced, but I would rather not.

I do not yet know how to fix it, but configurations like 
CONFIG_VIDEO_CX88_DVB=y, CONFIG_DVB_CX22702=m are currently compile 
errors.

> Michael Krufky

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

