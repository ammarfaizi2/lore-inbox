Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVKWSim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVKWSim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVKWSil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:38:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932150AbVKWSik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:38:40 -0500
Date: Wed, 23 Nov 2005 19:38:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Michael Krufky <mkrufky@m1k.net>, Johannes Stezenbach <js@linuxtv.org>
Subject: Re: Linux 2.6.15-rc2
Message-ID: <20051123183839.GR3963@stusta.de>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net> <200511222336.48506.gene.heskett@verizon.net> <20051123174237.GO3963@stusta.de> <20051123182609.GA8336@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123182609.GA8336@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 07:26:09PM +0100, Sam Ravnborg wrote:
> On Wed, Nov 23, 2005 at 06:42:37PM +0100, Adrian Bunk wrote:
> >  EXTRA_CFLAGS += -I$(src)/..
> Wonder if this compiles with O=...
> 
> > -ifneq ($(CONFIG_VIDEO_BUF_DVB),n)
> > +ifneq ($(CONFIG_VIDEO_BUF_DVB),)
> >   EXTRA_CFLAGS += -DHAVE_VIDEO_BUF_DVB=1
> >  endif
> > -ifneq ($(CONFIG_DVB_CX22702),n)
> > +ifneq ($(CONFIG_DVB_CX22702),)
> >   EXTRA_CFLAGS += -DHAVE_CX22702=1
> >  endif
> > -ifneq ($(CONFIG_DVB_OR51132),n)
> > +ifneq ($(CONFIG_DVB_OR51132),)
> >   EXTRA_CFLAGS += -DHAVE_OR51132=1
> >  endif
> > -ifneq ($(CONFIG_DVB_LGDT330X),n)
> > +ifneq ($(CONFIG_DVB_LGDT330X),)
> >   EXTRA_CFLAGS += -DHAVE_LGDT330X=1
> >  endif
> > -ifneq ($(CONFIG_DVB_MT352),n)
> > +ifneq ($(CONFIG_DVB_MT352),)
> >   EXTRA_CFLAGS += -DHAVE_MT352=1
> >  endif
> > -ifneq ($(CONFIG_DVB_NXT200X),n)
> > +ifneq ($(CONFIG_DVB_NXT200X),)
> >   EXTRA_CFLAGS += -DHAVE_NXT200X=1
> >  endif
> > -
> 
> If we stick with HAVE_XXX then please use following style:
> 
> extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
> extra-cflags-$(CONFIG_DVB_CX22702)   += -DHAVE_CX22702=1
> extra-cflags-$(CONFIG_DVB_OR51132)   += -DHAVE_OR51132=1
> extra-cflags-$(CONFIG_DVB_LGDT330X)  += -DHAVE_LGDT330X=1
> extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1
> extra-cflags-$(CONFIG_DVB_NXT200X)   += -DHAVE_NXT200X=1
> 
> EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)

And this does still not solve all problems, the whole approach is a 
mess.

E.g. CONFIG_VIDEO_CX88_DVB=y, CONFIG_DVB_CX22702=m is one of the many 
cases that still won't compile.

I'll try to find a way for doing this all properly.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

