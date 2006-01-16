Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWAPLjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWAPLjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWAPLjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:39:47 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42509 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750978AbWAPLjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:39:46 -0500
Date: Mon, 16 Jan 2006 12:39:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: two (little) problems wit 2.6.15-git7 one with build, one with acpi
Message-ID: <20060116113942.GA3698@mars.ravnborg.org>
References: <20060112231528.025c3a0b.akpm@osdl.org> <200601132018.04013.volker.armin.hemmann@tu-clausthal.de> <20060115125546.GA16505@mars.ravnborg.org> <200601152148.02445.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601152148.02445.volker.armin.hemmann@tu-clausthal.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 09:48:02PM +0100, Hemmann, Volker Armin wrote:
 
> The kernel-sources directory has to be 'virgin'. As soon as I build a kernel 
> in it once, it worked without any problems - even after a make clean and make 
> mrproper.

This proved to be why it worked for me.
The fix was simple. We have to evaluate MODLIB late so we have
.kernelrelease created when evaluating MODLIB.
Following patch fixes it:

	Sam
	

diff --git a/Makefile b/Makefile
index 22e322f..37a4b67 100644
--- a/Makefile
+++ b/Makefile
@@ -545,7 +545,7 @@ export	INSTALL_PATH ?= /boot
 # makefile but the arguement can be passed to make if needed.
 #
 
-MODLIB	:= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
+MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 export MODLIB
 
 
