Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268703AbTCDAR7>; Mon, 3 Mar 2003 19:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268794AbTCDAR7>; Mon, 3 Mar 2003 19:17:59 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:15242 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S268703AbTCDAR6>; Mon, 3 Mar 2003 19:17:58 -0500
Date: Mon, 3 Mar 2003 18:28:20 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get()
In-Reply-To: <200303032220.h23MKVGi028878@locutus.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.44.0303031825240.16397-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, chas williams wrote:

> Index: linux/net/atm/Makefile
> ===================================================================
> RCS file: /home/chas/CVSROOT/linux/net/atm/Makefile,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 Makefile
> --- linux/net/atm/Makefile	20 Feb 2003 13:46:30 -0000	1.1.1.1
> +++ linux/net/atm/Makefile	3 Mar 2003 16:51:03 -0000
> @@ -3,12 +3,15 @@
>  #
>  
>  mpoa-objs	:= mpc.o mpoa_caches.o mpoa_proc.o
> +atm-objs	:= addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
>  
> -obj-$(CONFIG_ATM) := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
> +obj-$(CONFIG_ATM) += atm.o
>  
> -obj-$(CONFIG_ATM_CLIP) += clip.o ipcommon.o
> -obj-$(CONFIG_NET_SCH_ATM) += ipcommon.o
> -obj-$(CONFIG_PROC_FS) += proc.o
> +obj-$(CONFIG_ATM_CLIP) += clip.o
> +# obj-$(CONFIG_NET_SCH_ATM) += ipcommon.o
> +ifeq ($(CONFIG_PROC_FS),y)
> +atm-objs += proc.o
> +endif
>  
>  obj-$(CONFIG_ATM_LANE) += lec.o
>  obj-$(CONFIG_ATM_MPOA) += mpoa.o


Not terribly important, but you can write this as:


obj-$(CONFIG_ATM)	+= atm.o

atm-y			+= addr.o pvc.o signaling.o svc.o ...
atm-$(CONFIG_PROC_FS)	+= proc.o


which looks a bit nicer ;)

--Kai


