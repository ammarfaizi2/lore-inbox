Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbSAHKUW>; Tue, 8 Jan 2002 05:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285130AbSAHKUD>; Tue, 8 Jan 2002 05:20:03 -0500
Received: from gate.perex.cz ([194.212.165.105]:45577 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S284659AbSAHKT5>;
	Tue, 8 Jan 2002 05:19:57 -0500
Date: Tue, 8 Jan 2002 11:18:34 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Takashi Iwai <tiwai@suse.de>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>,
        "sound-hackers@zabbo.net" <sound-hackers@zabbo.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <s5hk7utgnh3.wl@alsa1.suse.de>
Message-ID: <Pine.LNX.4.31.0201081116300.482-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Takashi Iwai wrote:

> At Tue, 08 Jan 2002 10:52:16 +0100,
> Abramo wrote:
> >
> > "J.A. Magallon" wrote:
> > >
> > > On 20020108 Linus Torvalds wrote:
> > > >
> > > >On Mon, 7 Jan 2002, Alan Cox wrote:
> > > >> > Would't it be better to split drivers:
> > > >> >
> > > >> > sound/core.c
> > > >> > sound/alsa/alsa-core.c
> > > >> > sound/alsa/drivers/alsa-emu10k.c
> > > >> > sound/oss/oss-core.c
> > > >> > sound/oss/drivers/oss-emu10k.c
> > > >>
> > > >> Thats much harder to do randomg greps on and to find stuff,than drivers
> > > >> first
> > > >
> > > >I agree. Put drivers separately, let's not split it up more than that.
> > > >
> > >
> > > What would you do with drivers with the same name (source code file)
> > > in alsa and oss ?
> > > Sound is special because you have two implementations of the same subsystem
> > > living together. And eventually in a (near?) future, the oss subtree
> > > will be killed and the alsa one would go up one level, just as is. Much
> > > cleaner. And you will end with
> > >
> > > sound/alsa-core.c
> > > sound/drivers/alsa-driver.c
> >
> > I think it's better to face this big change once and to move the OSS
> > stuff now in its definitive place (where it might be removed in future).
> >
> > So we'd have:
> > sound/
> > sound/oss_native
> > sound/oss_emul
> > sound/synth
> > sound/include
> > drivers/sound/i2c
> > drivers/sound/isa
> > drivers/sound/pci
> > drivers/sound/ppc
>
> On the list above, to where OSS (hw specific) codes come?  Into a
> single directory, sound/oss_native?  Or both ALSA and OSS drivers are
> mixed into drivers/sound/*?
> I'd like to see ALSA and OSS codes are separated into different
> directories...  Otherwise it's too confusing.
>
> And how about drivers/sound/generic for generic hardware codes such as
> ac97_codec.c?
>
>
> > I still have some doubts about hardware specific include files:
> > a) sound/include
> > b) drivers/sound/{i2c,isa,pci,ppc}
> > c) drivers/sound/include
> >
> > Currently my vote would go for b), but I see drawbacks for this solution
> > (for generic chip include files, like ac97 or ak4531 ones). Perhaps it's
> > better to have a mixed solution (partly b) and partly c)
>
> Agreed.  The hw specific header files should be bound with *.c code
> together.

The problem is that we should export some header files to user space as
well to allow access to hardware related features.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org

