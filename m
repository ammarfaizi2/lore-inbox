Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263274AbTCNIjS>; Fri, 14 Mar 2003 03:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263275AbTCNIjS>; Fri, 14 Mar 2003 03:39:18 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:10167 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263274AbTCNIjR>;
	Fri, 14 Mar 2003 03:39:17 -0500
Date: Fri, 14 Mar 2003 09:49:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: vojtech@suse.cz, linux-kernel@vger.kernel.org, janekh@cvotech.com
Subject: Re: [PATCH] 2.5.62: /proc/ide/via reads return incomplete data, Bug #374
Message-ID: <20030314094953.A28232@ucw.cz>
References: <20030220215519.GA1181@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030220215519.GA1181@ttnet.net.tr>; from faikuygur@ttnet.net.tr on Thu, Feb 20, 2003 at 11:55:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:55:19PM +0200, Faik Uygur wrote:
> 
> This patch fixes the incomplete data return problem of /proc/ide/via and 
> addresses Bug #374 of Bugzilla.
> 
> When the number of consecutive read bytes are smaller than the total data 
> in via_get_info(), the second read() returns 0.
> 
> --- linux-2.5.62-vanilla/drivers/ide/pci/via82cxxx.c    Thu Feb 20 18:51:52 2003
> +++ linux-2.5.62/drivers/ide/pci/via82cxxx.c    Thu Feb 20 23:09:23 2003
> @@ -145,6 +145,7 @@
>                  uen[4], udma[4], umul[4], active8b[4], recover8b[4];
>         struct pci_dev *dev = bmide_dev;
>         unsigned int v, u, i;
> +       int len;
>         u16 c, w;
>         u8 t, x;
>         char *p = buffer;
> @@ -274,7 +275,10 @@
>                 speed[i] / 1000, speed[i] / 100 % 10);
> 
>         /* hoping it is less than 4K... */
> -       return p - buffer;
> +       len = (p - buffer) - offset;
> +       *addr = buffer + offset;
> +
> +       return len > count ? count : len;
>  }
> 
>  #endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */

Thanks; applied.

-- 
Vojtech Pavlik
SuSE Labs
