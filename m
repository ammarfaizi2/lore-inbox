Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWJSJ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWJSJ35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWJSJ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:29:57 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:58193 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1030364AbWJSJ34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:29:56 -0400
Message-ID: <4537458D.4050107@tls.msk.ru>
Date: Thu, 19 Oct 2006 13:29:49 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH 3/6] video: use bitrev8
References: <20061018164420.GC21820@localhost>
In-Reply-To: <20061018164420.GC21820@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote:
> Use bitrev8 for nvidiafb, rivafb, and tgafb drivers
> 
> Cc: Antonino Daplas <adaplas@pol.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  drivers/video/Kconfig           |    3 ++
>  drivers/video/nvidia/nv_accel.c |   35 -------------------------
>  drivers/video/nvidia/nv_local.h |   11 +++++--
>  drivers/video/nvidia/nv_proto.h |    1 
>  drivers/video/riva/fbdev.c      |   44 +++----------------------------
>  drivers/video/tgafb.c           |   56 +++++++---------------------------------
>  6 files changed, 26 insertions(+), 124 deletions(-)
> 
> Index: work-fault-inject/drivers/video/riva/fbdev.c
> ===================================================================
> --- work-fault-inject.orig/drivers/video/riva/fbdev.c
> +++ work-fault-inject/drivers/video/riva/fbdev.c
[]
>  static inline void reverse_order(u32 *l)
>  {
>  	u8 *a = (u8 *)l;
> -	*a = byte_rev[*a], a++;
> -	*a = byte_rev[*a], a++;
> -	*a = byte_rev[*a], a++;
> -	*a = byte_rev[*a];
> +	a[0] = bitrev8(a[0]);
> +	a[1] = bitrev8(a[1]);
> +	a[2] = bitrev8(a[2]);
> +	a[3] = bitrev8(a[3]);
>  }

This looks like a good candidate for a common helper function, too.

/mjt
