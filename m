Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315227AbSEKXE4>; Sat, 11 May 2002 19:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSEKXEz>; Sat, 11 May 2002 19:04:55 -0400
Received: from surf.viawest.net ([216.87.64.26]:19451 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315227AbSEKXEy>;
	Sat, 11 May 2002 19:04:54 -0400
Date: Sat, 11 May 2002 16:04:32 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] opl3 OSS emulation compile fixes
Message-ID: <20020511230432.GA6165@wizard.com>
In-Reply-To: <20020511061746.GA1845@wizard.com> <Pine.LNX.4.44.0205111347320.29678-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 3:30pm  up 13:20,  2 users,  load average: 0.06, 0.04, 0.01
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 01:51:33PM +0200, Zwane Mwaikambo wrote:
> On Fri, 10 May 2002, A Guy Called Tyketto wrote:
> 
> >         No problem.. modprobe ran cleanly without any unresolved symbols. 
> > however, with those programs needing OSS opl3 emulation (xmms, mpg123, 
> > realplayer to name a few), this won't do much good less they forsake OSS 
> > altogether. The 3 programs above (except xmms, which I believe works with 
> > ALSA) depend on /dev/dsp existing for them to run. /dev/dsp gets created 
> > (using DevFS here) when snd-pcm-oss.o is inserted at modprobe time. Hence, the 
> > below:
> > 
> > root@bellicha:~# modprobe snd-fm801
> > modprobe: Can't locate module snd-pcm-oss
> > /lib/modules/2.5.15/kernel/sound/pci/snd-fm801.o: post-install snd-fm801 failed
> > /lib/modules/2.5.15/kernel/sound/pci/snd-fm801.o: insmod snd-fm801 failed
> 
> But isn't that PCM OSS emulation? Did you compile with CONFIG_SND_PCM_OSS? 
> >From what i see opl3_oss is WIP.
> 
> Forgive me if i'm missing something fundamental...

        You're right. I did:

CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

        But, according to sound/core/Config.in:

dep_bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND
 if [ "$CONFIG_SND_OSSEMUL" = "y" ]; then
   dep_tristate '    OSS Mixer API' CONFIG_SND_MIXER_OSS $CONFIG_SND
   dep_tristate '    OSS PCM API' CONFIG_SND_PCM_OSS $CONFIG_SND
  if [ "$CONFIG_SND_SEQUENCER" != "n" ]; then
    dep_tristate '    OSS Sequencer API' CONFIG_SND_SEQUENCER_OSS $CONFIG_SND_SEQUENCER
  fi
fi

        If I'm reading this right, CONFIG_SND_PCM_OSS would depend on 
CONFIG_SND_OSSEMUL being set.

        Interestingly enough, I just ran a diff -uNr between the sound/ TLDs 
of the 2.5.15 and 2.5.7 trees, and there hasn't been a change in 
sound/drivers/opl3/opl3_oss.c, although it could have changed between 2.5.7 
and 2.5.14. It was 2.5.14 where I originally noticed the breakage.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

