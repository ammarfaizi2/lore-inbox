Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314228AbSEXHYx>; Fri, 24 May 2002 03:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSEXHYw>; Fri, 24 May 2002 03:24:52 -0400
Received: from gate.perex.cz ([194.212.165.105]:24076 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S314228AbSEXHYv> convert rfc822-to-8bit;
	Fri, 24 May 2002 03:24:51 -0400
Date: Fri, 24 May 2002 09:24:06 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?= <ilmari@ping.uio.no>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Latest ALSA code available for tests
In-Reply-To: <d8ju1oynut3.fsf@thrir.ifi.uio.no>
Message-ID: <Pine.LNX.4.33.0205240922090.746-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Dagfinn Ilmari [iso-8859-1] Mannsåker wrote:

> Jaroslav Kysela <perex@suse.cz> writes:
> 
> > Hi all,
> >
> > 	the latest ALSA -> kernel patch is available for tests at
> >
> > ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-2002-05-23-1-linux-2.5.17-cs1.582.patch.gz
> >
> > 	I'd like to ask interested people to test this patch and report
> > especially compilation problems, because there are some fixes in code
> > dependency for OSS emulation layer. Also Hammerfall DSP code was recently
> > added.
> 
> It all compiled fine here, and depmod doesn't complain about any
> unresolved symbols. However, when I try to load snd.o, it tells that
> snd_mixer_oss_notify_callback is unresolved. The relevant config
> parameters are:
> 
> CONFIG_SOUND=y
> CONFIG_SND=m
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> CONFIG_SND_RTCTIMER=m
> CONFIG_SND_MAESTRO3=m

Thanks. Bellow patch (apply in sound/core directory) should fix this 
problem:

Index: init.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/init.c,v
retrieving revision 1.8
diff -u -r1.8 init.c
--- init.c      23 May 2002 08:20:38 -0000      1.8
+++ init.c      24 May 2002 06:57:41 -0000
@@ -33,7 +33,7 @@
 snd_card_t *snd_cards[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = NULL};
 rwlock_t snd_card_rwlock = RW_LOCK_UNLOCKED;

-#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS)
+#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
 int (*snd_mixer_oss_notify_callback)(snd_card_t *card, int free_flag);
 #endif


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

