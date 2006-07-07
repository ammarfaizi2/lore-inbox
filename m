Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWGGDgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWGGDgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWGGDgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:36:52 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:27779 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751170AbWGGDgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:36:51 -0400
Date: Fri, 7 Jul 2006 05:36:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060707033630.GA15967@mars.ravnborg.org>
References: <20060706163728.GN26941@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706163728.GN26941@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 06:37:28PM +0200, Adrian Bunk wrote:
> Currently, using an undeclared function gives a compile warning, but it 
> can lead to a nasty to debug runtime stack corruptions if the prototype 
> of the function is different from what gcc guessed.
> 
> With -Werror-implicit-function-declaration we are getting an immediate
> compile error instead.
This patch broke (-rc1):

sparc allnoconfig build
ia64 allnoconfig build
ppc64 allnoconfig build

x86_64 succeded an allnoconfig build

I did not try other architectures. We need to fix the allnoconfig cases
at least for the popular architectures before applying this patch
otherwise it will create too much trouble/noise.

linux-arch copied in the hope that the arch maintaines may try it out
and fix their issues.

	Sam

---

 Makefile                               |    3 ++-
 drivers/input/joystick/iforce/Makefile |    2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.17-mm6-full/Makefile.old	2006-07-06 12:17:02.000000000 +0200
+++ linux-2.6.17-mm6-full/Makefile	2006-07-06 12:18:52.000000000 +0200
@@ -318,7 +318,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common \
+		   -Werror-implicit-function-declaration
 # Force gcc to behave correct even for buggy distributions
 CFLAGS          += $(call cc-option, -fno-stack-protector-all \
                                      -fno-stack-protector)
--- linux-2.6.17-mm6-full/drivers/input/joystick/iforce/Makefile.old	2006-07-06 12:19:08.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/input/joystick/iforce/Makefile	2006-07-06 12:19:16.000000000 +0200
@@ -16,5 +16,3 @@
 ifeq ($(CONFIG_JOYSTICK_IFORCE_USB),y)
 	iforce-objs += iforce-usb.o
 endif
-
-EXTRA_CFLAGS = -Werror-implicit-function-declaration


