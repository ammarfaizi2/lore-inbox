Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVAFOuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVAFOuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVAFOuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:50:22 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:21257 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S262848AbVAFOuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:50:10 -0500
From: "Ville Hallik" <ville@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9+ keyboard LED problem
In-Reply-To: <200501060143.13428.dtor_core@ameritech.net>
User-Agent: tin/1.5.12-20020311 ("Toxicity") (UNIX) (Linux/2.4.18-1-686-smp (i686))
Message-Id: <20050106145008.E3F6E14C47@ondatra.tartu-labor>
Date: Thu,  6 Jan 2005 16:50:08 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200501060143.13428.dtor_core@ameritech.net> you wrote:

> Actually it is ACK processing hardening that is very useful at setup stage
> but is getting in our way once keyboard is initialized and commands are
> intermixed with good data.

> Could you please try the patch below? It is just a quick hack, just to prove
> the idea. If it works for you I will prepare the proper fix later.

> -- 
> Dmitry

> ===== drivers/input/serio/libps2.c 1.2 vs edited =====
> --- 1.2/drivers/input/serio/libps2.c    2004-10-20 03:13:08 -05:00
> +++ edited/drivers/input/serio/libps2.c 2005-01-06 01:20:11 -05:00
> @@ -250,7 +250,7 @@
>                        }
>                        /* Fall through */
>                default:
> -                       return 1;
> +                       return 0;
>        }
> 
>        if (!ps2dev->nak && ps2dev->cmdcnt)

This quick hack works for me too. Thanks!

However, it is still easy to make PS/2 keyboard and mouse completely
unusable with the following "sleepless" shell script (but it probably does
not qualify as DoS because access to PS/2 keyboard is limited to local user
only):

while : ; do xset led 3 ; xset -led 3 ; done

Even after killing this over network login, both keyboard and mouse are
still unresponsive for about 10..20 seconds. It was not that fatal with 2.6.8.

-- 

Ville Hallik
