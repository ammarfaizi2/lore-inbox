Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbTFUHjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTFUHjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:39:25 -0400
Received: from gate.perex.cz ([194.212.165.105]:62726 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S265087AbTFUHjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:39:24 -0400
Date: Sat, 21 Jun 2003 09:53:02 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Fabio Bracci <fabio@hoendiep.ath.cx>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: 2.5: wrong CONFIG_SND_SEQUENCER logic in several drivers
In-Reply-To: <20030621011210.GS29247@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0306210951500.9621-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003, Adrian Bunk wrote:

> @Jaroslav:
> Several drivers have a wrong logic for CONFIG_SND_SEQUENCER. The correct 
> solution is something like the following:
> 
> --- sound/pci/emu10k1/emu10k1.c.old	2003-06-21 03:02:04.000000000 +0200
> +++ sound/pci/emu10k1/emu10k1.c	2003-06-21 03:02:31.000000000 +0200
> @@ -35,7 +35,7 @@
>  MODULE_DEVICES("{{Creative Labs,SB Live!/PCI512/E-mu APS},"
>  	       "{Creative Labs,SB Audigy}}");
>  
> -#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
> +#if defined(CONFIG_SND_SEQUENCER) || (defined (MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
>  #define ENABLE_SYNTH
>  #include <sound/emu10k1_synth.h>
>  #endif
> 
> If you comfirm this is correct I'll send a fix for all affected drivers.

Yes, it's correct. I fixed our code. The fix will be in the next ALSA 
2.5 update. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

