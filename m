Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTAZTZJ>; Sun, 26 Jan 2003 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbTAZTZJ>; Sun, 26 Jan 2003 14:25:09 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:62159 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S266965AbTAZTZH>; Sun, 26 Jan 2003 14:25:07 -0500
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] isa_virt_to_bus and co on Alpha
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 26 Jan 2003 20:33:27 +0100
Message-ID: <wrpznpnln94.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Richard, Linus, lklm,

The following trivial patchlet (against 2.5.59) adds the missing
isa_virt_to_bus/isa_bus_to_virt API to the Alpha architecture.

This is at least needed by the aha1740 driver. With this patch, the
ol' good Jensen is back running 2.5 ;-).

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=io.h-patch
Content-Description: isa_vtb patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.879.82.8 -> 1.879.82.9
#	include/asm-alpha/io.h	1.9     -> 1.9.1.1
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/26	maz@hina.wild-wind.fr.eu.org	1.879.82.9
# Add isa_virt_to_bus/isa_bus_to_virt API.
# aha1740 driver wants it, so we can run 2.5 on the Jensen... :-)
# --------------------------------------------
#
diff -Nru a/include/asm-alpha/io.h b/include/asm-alpha/io.h
--- a/include/asm-alpha/io.h	Sun Jan 26 20:30:26 2003
+++ b/include/asm-alpha/io.h	Sun Jan 26 20:30:26 2003
@@ -84,6 +84,8 @@
 	return phys <= __direct_map_size ? bus : 0;
 }
 
+#define isa_virt_to_bus(a) virt_to_bus(a)
+
 static inline void *bus_to_virt(unsigned long address)
 {
 	void *virt;
@@ -95,6 +97,8 @@
 	virt = phys_to_virt(address);
 	return (long)address <= 0 ? NULL : virt;
 }
+
+#define isa_bus_to_virt(a) bus_to_virt(a)
 
 #else /* !__KERNEL__ */
 

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
