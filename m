Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131134AbQLVELV>; Thu, 21 Dec 2000 23:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbQLVELL>; Thu, 21 Dec 2000 23:11:11 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:63246 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S131134AbQLVEK5>; Thu, 21 Dec 2000 23:10:57 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200012220340.VAA14005@mako.theneteffect.com>
Subject: Re: Linux 2.2.19pre3
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 21 Dec 2000 21:40:17 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu> from "Alan Cox" at Dec 22, 2000 12:52:32 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.2.19pre3
[snip]
> o	Optimise kernel compiler detect, kgcc before	(Peter Samuelson)
> 	gcc272 also

I get an endless stream of this:

kgcc:gcc272:cc:gcc: not found
kgcc:gcc272:cc:gcc: not found
/bin/sh: -D__KERNEL__: command not found
/bin/sh: -D__KERNEL__: command not found
/bin/sh: -D__KERNEL__: command not found
/bin/sh: -D__KERNEL__: command not found


I think the Makefile optimisation needs to be (cut-n-paste):

--- Makefile~   Thu Dec 21 21:35:39 2000
+++ Makefile    Thu Dec 21 21:35:54 2000
@@ -28,7 +28,7 @@
 #      gcc272 for Debian
 #      otherwise 'cc'
 #
-CCFOUND :=$(shell $(CONFIG_SHELL) scripts/kwhich kgcc gcc272 cc gcc)
+CCFOUND :=$(shell $(CONFIG_SHELL) scripts/kwhich kgcc:gcc272:cc:gcc)
 ## Faster, but requires GNU make 3.78, which postdates Linux 2.2.0
 ##CC   =$(if $(CROSS_COMPILE),$(CROSS_COMPILE)gcc,$(CCFOUND)) -D__KERNEL__ -I$(HPATH)
 CC     =$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else echo $(CCFOUND); fi) \


	M
(what's the old saying - the first rule of optimization is don't or
something like that... ;)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
