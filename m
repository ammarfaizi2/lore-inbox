Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSFIRWy>; Sun, 9 Jun 2002 13:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSFIRWy>; Sun, 9 Jun 2002 13:22:54 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:15 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S313687AbSFIRWw>; Sun, 9 Jun 2002 13:22:52 -0400
Message-ID: <3D038E60.7030105@megapathdsl.net>
Date: Sun, 09 Jun 2002 10:20:32 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Skip Ford <skip.ford@verizon.net,LKML" 
	<linux-kernel@vger.kernel.org>
Subject: Re: 2.5.21 -- emumpu401.c:309: parse error before "emu10k1_midi_init"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford wrote:
 >
 > I guess this file also needs init.h
 >
 >
 > --- linux/sound/pci/emu10k1/emumpu401.c~        Sun Jun  9 04:30:46 2002
 > +++ linux/sound/pci/emu10k1/emumpu401.c Sun Jun  9 04:31:51 2002
 > @@ -22,6 +22,7 @@
 >  #define __NO_VERSION__
 >  #include <sound/driver.h>
 >  #include <linux/time.h>
 > +#include <linux/init.h>
 >  #include <sound/core.h>
 >  #include <sound/emu10k1.h>

After applying your patch, I get:

   gcc -Wp,-MD,.emupcm.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -nostdinc -iwithprefix include -DMODULE 
-DKBUILD_BASENAME=emupcm   -c -o emupcm.o emupcm.c
emupcm.c:964: parse error before "snd_emu10k1_pcm"
emupcm.c:965: warning: return type defaults to `int'
emupcm.c:1012: parse error before "snd_emu10k1_pcm_mic"
emupcm.c:1013: warning: return type defaults to `int'
emupcm.c:1115: parse error before "snd_emu10k1_pcm_efx"
emupcm.c:1116: warning: return type defaults to `int'
make[3]: *** [emupcm.o] Error 1
make[3]: Leaving directory `/usr/src/linux/sound/pci/emu10k1'

CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

#
# PCI devices
#
CONFIG_SND_EMU10K1=m

