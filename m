Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTEEGnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 02:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTEEGnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 02:43:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60885 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261969AbTEEGnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 02:43:17 -0400
Date: Mon, 5 May 2003 08:55:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Vlad@geekizoid.com" <vlad@geekizoid.com>, levon@movementarian.org
Cc: "Lkml \(E-mail\)" <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
Subject: [2.5 patch] fix oprofile/init.c compilation
Message-ID: <20030505065542.GH9794@fs.tum.de>
References: <000701c312c2$e14ab1b0$0200a8c0@wsl3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c312c2$e14ab1b0$0200a8c0@wsl3>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 11:57:50PM -0500, Vlad@geekizoid.com wrote:
> I get the following error trying to compile 2.5.69.  This is the same config as 2.5.68, make with 'make oldconfig' and 'make bzlilo && make modules modules_install'.
> 
> Config and config.old attached.
> 
> Error:
> arch/i386/oprofile/init.c: In function `oprofile_arch_init':
> arch/i386/oprofile/init.c:25: `ENODEV' undeclared (first use in this function)
> arch/i386/oprofile/init.c:25: (Each undeclared identifier is reported only once
> arch/i386/oprofile/init.c:25: for each function it appears in.)
> arch/i386/oprofile/init.c:27: warning: control reaches end of non-void function
> make[1]: *** [arch/i386/oprofile/init.o] Error 1
> make: *** [arch/i386/oprofile] Error 2


The following patch should fix it:

--- linux-2.5.69-full/arch/i386/oprofile/init.c.old	2003-05-05 08:51:10.000000000 +0200
+++ linux-2.5.69-full/arch/i386/oprofile/init.c	2003-05-05 08:51:37.000000000 +0200
@@ -9,6 +9,7 @@
 
 #include <linux/oprofile.h>
 #include <linux/init.h>
+#include <linux/errno.h>
  
 /* We support CPUs that have performance counters like the Pentium Pro
  * with the NMI mode driver.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

