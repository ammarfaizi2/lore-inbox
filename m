Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVLVIko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVLVIko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVLVIko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:40:44 -0500
Received: from witte.sonytel.be ([80.88.33.193]:58297 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965136AbVLVIko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:40:44 -0500
Date: Thu, 22 Dec 2005 09:40:30 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-m68k@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/36] m68k: switch mac/misc.c to direct use of appropriate
 cuda/pmu/maciisi requests
In-Reply-To: <E1EpIOK-0004q9-FT@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0512220939090.17836@pademelon.sonytel.be>
References: <E1EpIOK-0004q9-FT@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: 1134918770 -0500
> 
> kill ADBREQ_RAW use, replace adb_read_time(), etc. with per-type variants,
> eliminated remapping from pmu ones, fix the ifdefs (PMU->PMU68K)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

> +	switch(macintosh_config->adb_type) {
> +	case MAC_ADB_IISI:
> +		func = maciisi_read_pram; break;
> +	case MAC_ADB_PB1:
> +	case MAC_ADB_PB2:
> +		func = pmu_read_pram; break;
> +	case MAC_ADB_CUDA:
> +		func = cuda_read_pram; break;
> +	default:
>  		func = via_read_pram;
>  	}

Wouldn't it be better to just have an ops structure with function pointers and
data fields, so we just have to initialize that once, instead of having `switch
(macintosh_config->adb_type) { ...}' in multiple places?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
