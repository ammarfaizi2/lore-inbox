Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTAGW7L>; Tue, 7 Jan 2003 17:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbTAGW7L>; Tue, 7 Jan 2003 17:59:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28143 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267542AbTAGW7K>; Tue, 7 Jan 2003 17:59:10 -0500
Date: Wed, 8 Jan 2003 00:07:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>, rusty@rustcorp.com.au,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] MODULE_FORCE_UNLOAD must depend on MODULE_UNLOAD
Message-ID: <20030107230742.GO6626@fs.tum.de>
References: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 02:55:01PM -0500, Robert P. J. Day wrote:

>...
> Loadable module support
>     
>     Does "Module unloading" mean whether or not I can run "rmmod"?
>   And if I deselect this, why can I still select "Forced module
>   unloading"?  Either I can unload or I can't, no?
>...

Thanks for spotting this, after reading kernel/module.c it seems obvious 
to me that you are right. The following simple patch fixes it:

--- linux-2.5.54/init/Kconfig.old	2003-01-08 00:05:12.000000000 +0100
+++ linux-2.5.54/init/Kconfig	2003-01-08 00:05:38.000000000 +0100
@@ -127,7 +127,7 @@
 
 config MODULE_FORCE_UNLOAD
 	bool "Forced module unloading"
-	depends on MODULES && EXPERIMENTAL
+	depends on MODULE_UNLOAD && EXPERIMENTAL
 	help
 	  This option allows you to force a module to unload, even if the
 	  kernel believes it is unsafe: the kernel will remove the module


> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

