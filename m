Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbSAHJy3>; Tue, 8 Jan 2002 04:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282861AbSAHJyU>; Tue, 8 Jan 2002 04:54:20 -0500
Received: from smtp2.libero.it ([193.70.192.52]:6554 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S282482AbSAHJyF>;
	Tue, 8 Jan 2002 04:54:05 -0500
Message-ID: <3C3AC150.BE4FFAFE@alsa-project.org>
Date: Tue, 08 Jan 2002 10:52:16 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Jaroslav Kysela <perex@suse.cz>
Cc: "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <20020108102833.A2927@werewolf.able.es> <20020108103046.A3545@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> On 20020108 Linus Torvalds wrote:
> >
> >On Mon, 7 Jan 2002, Alan Cox wrote:
> >> > Would't it be better to split drivers:
> >> >
> >> > sound/core.c
> >> > sound/alsa/alsa-core.c
> >> > sound/alsa/drivers/alsa-emu10k.c
> >> > sound/oss/oss-core.c
> >> > sound/oss/drivers/oss-emu10k.c
> >>
> >> Thats much harder to do randomg greps on and to find stuff,than drivers
> >> first
> >
> >I agree. Put drivers separately, let's not split it up more than that.
> >
> 
> What would you do with drivers with the same name (source code file)
> in alsa and oss ?
> Sound is special because you have two implementations of the same subsystem
> living together. And eventually in a (near?) future, the oss subtree
> will be killed and the alsa one would go up one level, just as is. Much
> cleaner. And you will end with
> 
> sound/alsa-core.c
> sound/drivers/alsa-driver.c

I think it's better to face this big change once and to move the OSS
stuff now in its definitive place (where it might be removed in future).

So we'd have:
sound/
sound/oss_native
sound/oss_emul
sound/synth
sound/include
drivers/sound/i2c
drivers/sound/isa
drivers/sound/pci
drivers/sound/ppc

I still have some doubts about hardware specific include files:
a) sound/include
b) drivers/sound/{i2c,isa,pci,ppc}
c) drivers/sound/include

Currently my vote would go for b), but I see drawbacks for this solution
(for generic chip include files, like ac97 or ak4531 ones). Perhaps it's
better to have a mixed solution (partly b) and partly c)

Will this solution be able to satisfy everybody? ;-)

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
