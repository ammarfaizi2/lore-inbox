Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSGUXx7>; Sun, 21 Jul 2002 19:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGUXx6>; Sun, 21 Jul 2002 19:53:58 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:24456 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315265AbSGUXxX>; Sun, 21 Jul 2002 19:53:23 -0400
Date: Sun, 21 Jul 2002 18:56:24 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 net/core/Makefile
In-Reply-To: <29446.1025944229@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0207211853130.16927-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2002, Keith Owens wrote:

> The valid combination of CONFIG_NET=n, CONFIG_LLC undefined incorrectly
> builds ext8022.o and gets unresolved references because there is no
> network code.  Detected by kbuild 2.5, not detected by the existing
> build system.
> 
> Index: 25.1/net/core/Makefile
> --- 25.1/net/core/Makefile Wed, 19 Jun 2002 14:11:35 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
> +++ 25.1(w)/net/core/Makefile Sat, 06 Jul 2002 18:27:16 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
> @@ -16,7 +16,7 @@ obj-$(CONFIG_FILTER) += filter.o
>  
>  obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o utils.o
>  
> -ifneq ($(CONFIG_LLC),n)
> +ifneq ($(subst n,,$(CONFIG_LLC)),)
>  obj-y += ext8022.o
>  endif

Makes sense to me. However, the CONFIG_ variables used in the Makefiles 
are never "n", they are "y", "m" or undefined.

In Config.in scripts you have to cater for "n" or "", and I've seen 
various people on l-k carry this behavior into the Makefiles, but there 
it's unnecessary for all I can tell.

So

ifdef CONFIG_LLC
obj-y += ext8022.o
endif

should do the job just fine.

--Kai


