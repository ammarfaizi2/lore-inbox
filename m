Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbSAGRTH>; Mon, 7 Jan 2002 12:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281809AbSAGRS6>; Mon, 7 Jan 2002 12:18:58 -0500
Received: from gate.perex.cz ([194.212.165.105]:57607 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S281797AbSAGRSp>;
	Mon, 7 Jan 2002 12:18:45 -0500
Date: Mon, 7 Jan 2002 18:18:02 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: David Weinehall <tao@acc.umu.se>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <20020107164136.I5235@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.31.0201071807060.498-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, David Weinehall wrote:

> On Mon, Jan 07, 2002 at 03:32:18PM +0100, Christoph Hellwig wrote:
> > In article <Pine.LNX.4.31.0201061814580.545-100000@pnote.perex-int.cz> you wrote:
> > > The latest patch is alsa-2002-01-06-1-linux-2.5.2pre9.patch.gz and
> > > contains:
> >
> > > * moved linux/drivers/sound directory to linux/sound/oss
> > > * moved sound core files to linux/sound
> > > * integrated ALSA kernel code
> > >   - linux/include/sound - sound header files
> > >   - linux/sound/core	- midlevel (no hw dependent) code
> > >   - linux/sound/drivers - generic drivers (no arch dependent)
> > >   - linux/sound/i2c     - reduced I2C core and drivers
> > >   - linux/sound/isa	- ISA sound hardware drivers
> > >   - linux/sound/pci	- PCI sound hardware drivers
> > >   - linux/sound/ppc	- PowerPC sound hardware drivers
> > >   - linux/sound/synth	- generic synthesizer support code
> >
> > > We appreciate any comments regarding directory structure
> >
> > linux/sound is silly.  It's drivers so put it under linux/drivers/sound.
> > Everything else seems to be sane to me.
>
> One question: What happens with hardware both available in both isa & pci
> versions (or any other combination that doesn't fit into this
> sorting?!)

Right, the directory structure is mostly informative only, because it is
possible to get parts from single directories. For example: ALS4000 driver
uses pci/als4000.c and isa/sb/sb_common.c code. Both source files are
used for compilation. We can optimize Makefiles further for an exact
specification of such hardware cross-references and reduce directory
passes when cross-references are not active.

If you look to the Makefiles, there is (for ALS4000):

linux/sound/isa/sb/Makefile:

obj-$(CONFIG_SND_ALS4000) += snd-sb-common.o

linux/sound/pci/Makefile:

obj-$(CONFIG_SND_ALS4000) += snd-als4000.o


If something does not fit: we can create a new subdirectory.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


