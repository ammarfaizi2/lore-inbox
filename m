Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315625AbSEJGXu>; Fri, 10 May 2002 02:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315816AbSEJGXt>; Fri, 10 May 2002 02:23:49 -0400
Received: from surf.viawest.net ([216.87.64.26]:15057 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315625AbSEJGXt>;
	Fri, 10 May 2002 02:23:49 -0400
Date: Thu, 9 May 2002 23:23:33 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] opl3 OSS emulation compile fixes
Message-ID: <20020510062333.GA10020@wizard.com>
In-Reply-To: <Pine.LNX.4.44.0205091419590.6271-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 11:00pm  up 2 days, 19:08,  2 users,  load average: 1.24, 1.17, 0.62
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        IMHO, this isn't good. I just gave this a run with 2.5.15, and 
opl3_oss.c wasn't even touched during compile (either into the kernel or as a 
module); it's completely passed over. more than likely when inserted with 
modprobe, OSS emulation would fail from functions not being there. I haven't 
tried that yet, but this would be my guess..

                                                        BL.
On Thu, May 09, 2002 at 02:21:32PM +0200, Zwane Mwaikambo wrote:
> Not so sure wether the ifeq change is what you want though...
> 
> --- linux-2.5/sound/drivers/opl3/Makefile.orig	Thu May  9 12:38:42 2002
> +++ linux-2.5/sound/drivers/opl3/Makefile	Thu May  9 12:39:20 2002
> @@ -9,7 +9,7 @@
>  
>  snd-opl3-lib-objs := opl3_lib.o opl3_synth.o
>  snd-opl3-synth-objs := opl3_seq.o opl3_midi.o opl3_drums.o
> -ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
> +ifeq ($(subst m,y,$(CONFIG_SND_OSSEMUL)),y)
>  snd-opl3-synth-objs += opl3_oss.o
>  endif
>  
> --- linux-2.5/include/sound/opl3.h.orig	Thu May  9 12:34:10 2002
> +++ linux-2.5/include/sound/opl3.h	Thu May  9 12:34:18 2002
> @@ -287,8 +287,10 @@
>  	snd_seq_device_t *seq_dev;	/* sequencer device */
>  	snd_midi_channel_set_t * chset;
>  
> +#ifdef CONFIG_SND_OSSEMUL
>  	snd_seq_device_t *oss_seq_dev;	/* OSS sequencer device, WIP */
>  	snd_midi_channel_set_t * oss_chset;
> +#endif
>   
>  	snd_seq_kinstr_ops_t fm_ops;
>  	snd_seq_kinstr_list_t *ilist;
> 
> -- 
> http://function.linuxpower.ca
> 		
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

