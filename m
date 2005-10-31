Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVJaSsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVJaSsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVJaSsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:48:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8310 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932405AbVJaSsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:48:52 -0500
Date: Mon, 31 Oct 2005 13:48:49 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: kernel library ordering
X-X-Sender: nico@localhost.localdomain
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510311333320.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the latest kernel, there is an optimized sha1 routine 
(arch/arm/lib/sha1.S) meant to override the generic one in lib/sha1.c.

The problem is that lib/lib.a is listed _before_ arch/arm/lib/lib.a in 
the link argument list so the architecture specific lib functions are 
not picked up in priority.

To work around this the following patch is needed:

--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -142,7 +142,7 @@ drivers-$(CONFIG_OPROFILE)      += arch/
 drivers-$(CONFIG_ARCH_CLPS7500)	+= drivers/acorn/char/
 drivers-$(CONFIG_ARCH_L7200)	+= drivers/acorn/char/
 
-libs-y				+= arch/arm/lib/
+libs-y				:= arch/arm/lib/ $(libs-y)
 
 # Default target when executing plain make
 ifeq ($(CONFIG_XIP_KERNEL),y)

However I was wondering if there should be a better and generic way to 
fix that.

Comments?


Nicolas
