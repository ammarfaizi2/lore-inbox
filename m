Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbSLLUom>; Thu, 12 Dec 2002 15:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbSLLUom>; Thu, 12 Dec 2002 15:44:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48393 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267470AbSLLUol>;
	Thu, 12 Dec 2002 15:44:41 -0500
Date: Thu, 12 Dec 2002 21:52:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, John Bradford <john@grabjohn.com>,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 breaks ALSA AWE32
Message-ID: <20021212205206.GA11836@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Sam Ravnborg <sam@ravnborg.org>, John Bradford <john@grabjohn.com>,
	perex@suse.cz, linux-kernel@vger.kernel.org
References: <20021212195258.GA12691@mars.ravnborg.org> <Pine.LNX.4.44.0212121421320.17517-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212121421320.17517-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On tor, dec 12, 2002 at 02:26:26 -0600, Kai Germaschewski wrote:
> > Kai, any ideas how to do this in a better way?
> 
> The minimal fix I can think of would be

Looks good - thanks.

One detail when looking at the patch:

> ===== sound/synth/emux/Makefile 1.4 vs edited =====
> --- 1.4/sound/synth/emux/Makefile	Tue Jun 18 04:16:20 2002
> +++ edited/sound/synth/emux/Makefile	Thu Dec 12 14:20:08 2002
> @@ -5,16 +5,11 @@
>  
>  export-objs  := emux.o
>  
> -snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
> -		       emux_effect.o emux_proc.o soundfont.o
> -ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
> -  snd-emux-synth-objs += emux_oss.o
> -endif
> +snd-emux-synth-y := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
> +		    emux_effect.o emux_proc.o soundfont.o
> +snd-emux-synth-$(CONFIG_SND_SEQUENCER_OSS) += emux_oss.o

snd-emux-synth-objs := $(snd-emux-synth-y)

>  
> -# Toplevel Module Dependency
> -ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
> -  obj-$(CONFIG_SND_SBAWE) += snd-emux-synth.o
> -  obj-$(CONFIG_SND_EMU10K1) += snd-emux-synth.o
> -endif
> +obj-$(CONFIG_SND_SBAWE) += snd-emux-synth.o
> +obj-$(CONFIG_SND_EMU10K1) += snd-emux-synth.o
>  
>  include $(TOPDIR)/Rules.make
> 
> However, synth/Makefile still has the ugly ifdef in there, which wouldn't
> be necessary if we entered synth/ just when CONFIG_SND_SEQUENCER is set.
> It looks like more generic routines are in synth/ (util-mem), though,
> which IMO shouldn't be there, but rather in some lib/ or whatever dir. So
> there's the opportunity for further cleanup, but I'll leave that to the
> ALSA people. Anybody care for testing the second patch above?
> 
> --Kai
> 
