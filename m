Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282914AbRLGQmX>; Fri, 7 Dec 2001 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGQmN>; Fri, 7 Dec 2001 11:42:13 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40075 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282912AbRLGQmC>; Fri, 7 Dec 2001 11:42:02 -0500
Date: Fri, 7 Dec 2001 09:41:51 -0700
Message-Id: <200112071641.fB7GfpS14840@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] / ALSA-0.9.0beta[9,10]
In-Reply-To: <20011207084910.7ec3b9c3.rene.rebe@gmx.net>
In-Reply-To: <20011207003528.1448673e.rene.rebe@gmx.net>
	<200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
	<20011207084910.7ec3b9c3.rene.rebe@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
> On Thu, 6 Dec 2001 23:09:14 -0700
> Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
> 
> > Rene Rebe writes:
> > > At least since 2.4.17-pre4 and -pre5 devfs is not handling
> > > permissions in the right way with ALSA:
[...]
> > > rene@jackson:/dev > l dsp sound/dsp 
> > > ls: sound/dsp: Permission denied
> > > lr-xr-xr-x   1 root     root            9 Dec  7 00:14 dsp -> sound/dsp
> > > rene@jackson:/dev > cd sound/
> > > bash: cd: sound/: Permission denied
> > > rene@jackson:/dev > 
> > > 
> > > rene@jackson:/dev > l snd
> > > ls: snd/..: Permission denied
> > > ls: snd/.: Permission denied
> > > ls: snd/controlC0: Permission denied
> > > ls: snd/controlC1: Permission denied
> > > ls: snd/timer: Permission denied
> > > ls: snd/midiC0D0: Permission denied
> > > ls: snd/pcmC0D2p: Permission denied
> > > ls: snd/pcmC0D1c: Permission denied
> > > ls: snd/pcmC0D0p: Permission denied
> > > ls: snd/pcmC0D0c: Permission denied
> > > ls: snd/midiC1D0: Permission denied
> > > ls: snd/pcmC1D0p: Permission denied
> > > ls: snd/pcmC1D0c: Permission denied
> > > total 0
> > > 
> > > They all have 666 (or 777 for dirs)!

Are you positive the directory has 777 permissions?

Thomas Hood may have found your problem:
> Some devfs permission problems may have arisen because of the
> fact that devfs now notifies devfsd of the creation of
> directories.  Many people have devfsd configured to set
> permissions to all devices matching a certain regular
> expression --- e.g., all devices with "sound" in their
> pathname.  The problem is that the "sound" directory itself
> matches this regular expression, and so will have its perm
> bits set exactly like the device files' perm bits---e.g.,
> with the eXamine bit cleared.  The solution is to edit the
> devfsd config so that it excludes the directory.  E.g.,
> instead of:
>     REGISTER sound PERMISSIONS root.audio 0664
> (which worked before but won't any more) do:
>     REGISTER ^sound/.* PERMISSIONS root.audio 0664
> or something similar.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
