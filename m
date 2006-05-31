Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWEaE70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWEaE70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWEaE70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:59:26 -0400
Received: from xenotime.net ([66.160.160.81]:47584 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751700AbWEaE7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:59:25 -0400
Date: Tue, 30 May 2006 22:02:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 12/12] input: use -ENOSPC instead of -ENOMEM in iforce
 when device full
Message-Id: <20060530220205.103536b1.rdunlap@xenotime.net>
In-Reply-To: <20060530110137.412646000@gmail.com>
References: <20060530105705.157014000@gmail.com>
	<20060530110137.412646000@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 13:57:17 +0300 Anssi Hannula wrote:

> Use -ENOSPC instead of -ENOMEM when the iforce device doesn't have enough free
> memory for the new effect. All other drivers are already been using -ENOSPC,
> so this makes the behaviour coherent.

Could all of the others be wrong?

ENOSPC: No space left on device
ENOMEM: Not enough space [!?!?!?] or Out of memory


> Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
> 
> ---
>  drivers/input/joystick/iforce/iforce-ff.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-ff.c
> ===================================================================
> --- linux-2.6.17-rc4-git12.orig/drivers/input/joystick/iforce/iforce-ff.c	2006-05-26 16:55:12.000000000 +0300
> +++ linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-ff.c	2006-05-26 16:57:13.000000000 +0300
> @@ -47,7 +47,7 @@ static int make_magnitude_modifier(struc
>  			iforce->device_memory.start, iforce->device_memory.end, 2L,
>  			NULL, NULL)) {
>  			mutex_unlock(&iforce->mem_mutex);
> -			return -ENOMEM;
> +			return -ENOSPC;
>  		}
>  		mutex_unlock(&iforce->mem_mutex);
>  	}
> @@ -80,7 +80,7 @@ static int make_period_modifier(struct i
>  			iforce->device_memory.start, iforce->device_memory.end, 2L,
>  			NULL, NULL)) {
>  			mutex_unlock(&iforce->mem_mutex);
> -			return -ENOMEM;
> +			return -ENOSPC;
>  		}
>  		mutex_unlock(&iforce->mem_mutex);
>  	}
> @@ -120,7 +120,7 @@ static int make_envelope_modifier(struct
>  			iforce->device_memory.start, iforce->device_memory.end, 2L,
>  			NULL, NULL)) {
>  			mutex_unlock(&iforce->mem_mutex);
> -			return -ENOMEM;
> +			return -ENOSPC;
>  		}
>  		mutex_unlock(&iforce->mem_mutex);
>  	}
> @@ -157,7 +157,7 @@ static int make_condition_modifier(struc
>  			iforce->device_memory.start, iforce->device_memory.end, 2L,
>  			NULL, NULL)) {
>  			mutex_unlock(&iforce->mem_mutex);
> -			return -ENOMEM;
> +			return -ENOSPC;
>  		}
>  		mutex_unlock(&iforce->mem_mutex);
>  	}
> 
> --


---
~Randy
