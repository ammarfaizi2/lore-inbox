Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132065AbQLPPTE>; Sat, 16 Dec 2000 10:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLPPSx>; Sat, 16 Dec 2000 10:18:53 -0500
Received: from d-dialin-158.addcom.de ([62.96.159.166]:1519 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129340AbQLPPSt>; Sat, 16 Dec 2000 10:18:49 -0500
Date: Sat, 16 Dec 2000 15:45:13 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: test13-pre2 fails "make xconfig" in isdn/Config.in
In-Reply-To: <3A3B53BE.41C31B99@t-online.de>
Message-ID: <Pine.LNX.4.30.0012161542010.1839-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000, Gunther Mayer wrote:

> apply this patch if like to fix this obvious error
> with "make xconfig" on plain tree:
> 	./tkparse < ../arch/i386/config.in >> kconfig.tk
> 	drivers/isdn/Config.in: 98: can't handle dep_bool/dep_mbool/dep_tristate condition
> 	make[1]: *** [kconfig.tk] Error 1
> 	make[1]: Leaving directory `/usr/src/linux/scripts'
>
> --- linux/drivers/isdn/Config.in-240t13pre2-orig        Sat Dec 16 12:20:59 2000
> +++ linux/drivers/isdn/Config.in        Sat Dec 16 12:21:48 2000
> @@ -95,7 +95,7 @@
>        dep_bool  '    Eicon PCI DIVA Server BRI/PRI/4BRI support' CONFIG_ISDN_DRV_EICON_PCI $CONFIG_PCI
>        bool      '    Eicon S,SX,SCOM,Quadro,S2M support' CONFIG_ISDN_DRV_EICON_ISA
>     fi
> -   dep_tristate '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
> +   bool '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
>  fi
>
>  # CAPI subsystem

Sorry, my bad. (Note to myself: Always test changes before submitting with
make menuconfig and make xconfig).

However, the correct fix is:

Only in linux-2.4.0-test13-pre2.work/: .menuconfig.log
diff -ur linux-2.4.0-test13-pre2/drivers/isdn/Config.in linux-2.4.0-test13-pre2.work/drivers/isdn/Config.in
--- linux-2.4.0-test13-pre2/drivers/isdn/Config.in	Sat Dec 16 15:36:21 2000
+++ linux-2.4.0-test13-pre2.work/drivers/isdn/Config.in	Sat Dec 16 15:39:47 2000
@@ -95,7 +95,7 @@
       dep_bool  '    Eicon PCI DIVA Server BRI/PRI/4BRI support' CONFIG_ISDN_DRV_EICON_PCI $CONFIG_PCI
       bool      '    Eicon S,SX,SCOM,Quadro,S2M support' CONFIG_ISDN_DRV_EICON_ISA
    fi
-   dep_tristate '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
+   tristate '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
 fi

 # CAPI subsystem

BTW: There's probably issues with ISDN built non-modular, because that
patch didn't have much testing yet. I'll go through different cases now.

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
