Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbSLLUro>; Thu, 12 Dec 2002 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbSLLUro>; Thu, 12 Dec 2002 15:47:44 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:63978 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267481AbSLLUro>; Thu, 12 Dec 2002 15:47:44 -0500
Date: Thu, 12 Dec 2002 14:55:28 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: John Bradford <john@grabjohn.com>, <perex@suse.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 breaks ALSA AWE32
In-Reply-To: <20021212205206.GA11836@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0212121454290.17517-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Sam Ravnborg wrote:

> One detail when looking at the patch:
> 
> > ===== sound/synth/emux/Makefile 1.4 vs edited =====
> > --- 1.4/sound/synth/emux/Makefile	Tue Jun 18 04:16:20 2002
> > +++ edited/sound/synth/emux/Makefile	Thu Dec 12 14:20:08 2002
> > @@ -5,16 +5,11 @@
> >  
> >  export-objs  := emux.o
> >  
> > -snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
> > -		       emux_effect.o emux_proc.o soundfont.o
> > -ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
> > -  snd-emux-synth-objs += emux_oss.o
> > -endif
> > +snd-emux-synth-y := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
> > +		    emux_effect.o emux_proc.o soundfont.o
> > +snd-emux-synth-$(CONFIG_SND_SEQUENCER_OSS) += emux_oss.o
> 
> snd-emux-synth-objs := $(snd-emux-synth-y)

Nope, kbuild does that for you ;)
(And yes, lots of places still do it manually, but it's not necessary 
anymore).

--Kai


