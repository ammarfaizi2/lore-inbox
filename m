Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319265AbSH2QqA>; Thu, 29 Aug 2002 12:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319270AbSH2QqA>; Thu, 29 Aug 2002 12:46:00 -0400
Received: from robotics.caltech.edu ([131.215.101.45]:8152 "EHLO
	robotics.caltech.edu") by vger.kernel.org with ESMTP
	id <S319265AbSH2Qp6>; Thu, 29 Aug 2002 12:45:58 -0400
Date: Thu, 29 Aug 2002 09:50:19 -0700
From: Jim Radford <radford@robotics.caltech.edu>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.20-pre4-ac2] fix broken i810_audio DMA (?)
Message-ID: <20020829095019.A29297@robotics.caltech.edu>
References: <1030585168.2548.18.camel@volans> <1030638379.2726.3.camel@voyager>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030638379.2726.3.camel@voyager>; from juergen.sawinski@mpimf-heidelberg.mpg.de on Thu, Aug 29, 2002 at 06:26:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 06:26:18PM +0200, Juergen Sawinski wrote:
> F*ck. This time the patch attached.
> Thanx Jim.

You're welcome.

It works better, but it's not fixed.

  o Playing through oss directly works like before
  o No more scratchy sound on artsd startup.
  o Playing one song at a time through artsd works.
  o Giving two songs to ogg123 to play through artsd
    works until you Ctrl-C to skip to the next song.
    It then hangs (like before, but with no dmesg output)

Thanks,
-Jim

> On Thu, 2002-08-29 at 03:39, Juergen Sawinski wrote:
> > Changes:
> > -remove dma reset in stop_{dac,adc}
> >  (from ICH4 manual: contents of all Bus master related registers to be
> >   reset; so, probably some registers are not re-initilized properly on
> >   consecutive re-opening of /dev/dsp ???)
> > -remove writes to OFF_CIV, instead set LVI relative to CIV
> > 
> > and some stuff that was already in the last diff I send to the list:
> > -implement a codec ID <-> IO register offset mapping
> > -in i810_ioctl, case SNDCTL_DSP_CHANNELS: only touch bits 20:21
> >  off GLOB_CNT (multichannel capabilities)
> > -AMD 8111 has 6 hw channels so I must have mmio (but I don't have
> >  any docs to verify this)
> > -minor fixes
