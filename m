Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUGSMvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUGSMvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGSMvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 08:51:12 -0400
Received: from mail.convergence.de ([212.84.236.4]:16321 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265082AbUGSMvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 08:51:10 -0400
Date: Mon, 19 Jul 2004 14:51:06 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] modpost warnings with external modules w/o modversions
Message-ID: <20040719125106.GA29131@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@germaschewski.name>,
	Sam Ravnborg <sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when building external modules (DVB drivers in this case)
for a kernel without CONFIG_MODVERSIONS I get a number of:

make[1]: Entering directory `/usr/src/linux-2.6.8-rc1'
  Building modules, stage 2.
  MODPOST
*** Warning: "dvb_unregister_frontend_new" [.../dvb-kernel/build-2.6/ves1x93.ko] has no CRC!


I believe that there is a small bug in modpost.c which the
patch below attempts to fix.


--- linux-2.6.8-rc1/scripts/modpost.c.orig	2004-07-16 19:22:24.000000000 +0200
+++ linux-2.6.8-rc1/scripts/modpost.c	2004-07-16 19:22:37.000000000 +0200
@@ -649,7 +649,6 @@ read_dump(const char *fname)
 
 		if (!(mod = find_module(modname))) {
 			if (is_vmlinux(modname)) {
-				modversions = 1;
 				have_vmlinux = 1;
 			}
 			mod = new_module(NOFAIL(strdup(modname)));

Johannes
