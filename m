Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTB0He2>; Thu, 27 Feb 2003 02:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTB0He2>; Thu, 27 Feb 2003 02:34:28 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:55141
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261660AbTB0He1>; Thu, 27 Feb 2003 02:34:27 -0500
Date: Thu, 27 Feb 2003 02:42:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: _N3X_ <n3x@coders.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: serial_cs with devfs
In-Reply-To: <20030227073433.GA20856@unreal.coders.eu.org>
Message-ID: <Pine.LNX.4.50.0302270241450.9788-100000@montezuma.mastecende.com>
References: <20030227073433.GA20856@unreal.coders.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003, _N3X_ wrote:

> in serial_cs.c there is a hardcoded device name in the code, stating
> ttySx, that's not the right thing with devfs..
> here's a patch of my own (should work also on the latest prepatch),
> just to show the problem, i think that the defines around it could be
> more carefully chosen, but what's the deal.. have a nice day.
> _N3X_ <n3x@coders.eu.org>
> 
> diff -ru linux-2.4.19/drivers/char/pcmcia/serial_cs.c linux-2.4.19-fix/drivers/char/pcmcia/serial_cs.c
> --- linux-2.4.19/drivers/char/pcmcia/serial_cs.c	2001-12-21 18:41:54.000000000 +0100
> +++ linux-2.4.19-fix/drivers/char/pcmcia/serial_cs.c	2002-11-06 10:14:07.000000000 +0100
> @@ -256,7 +256,11 @@
>      }
>      
>      info->line[info->ndev] = line;
> +#ifdef CONFIG_DEVFS_FS
> +    sprintf(info->node[info->ndev].dev_name, "tts/%d", line);
> +#else
>      sprintf(info->node[info->ndev].dev_name, "ttyS%d", line);
> +#endif /* CONFIG_DEVFS_FS */
>      info->node[info->ndev].major = TTY_MAJOR;
>      info->node[info->ndev].minor = 0x40+line;
>      if (info->ndev > 0)

*cough* All that patch does is accentuate is one thing...

	Zwane
-- 
function.linuxpower.ca
