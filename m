Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268148AbTBSHYF>; Wed, 19 Feb 2003 02:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbTBSHYE>; Wed, 19 Feb 2003 02:24:04 -0500
Received: from are.twiddle.net ([64.81.246.98]:26778 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S268148AbTBSHYD>;
	Wed, 19 Feb 2003 02:24:03 -0500
Date: Tue, 18 Feb 2003 23:33:52 -0800
From: Richard Henderson <rth@twiddle.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] alpha modutils update
Message-ID: <20030218233352.A24861@twiddle.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're now using srel32 in the exception handling macros.


r~



--- obj/obj_alpha.c.orig	2003-02-18 23:09:39.000000000 -0800
+++ obj/obj_alpha.c	2003-02-18 23:30:28.000000000 -0800
@@ -225,6 +225,14 @@
       *iloc = (*iloc & ~0x3fff) | (v & 0x3fff);
       break;
 
+    case R_ALPHA_SREL32:
+      v -= dot;
+      if ((Elf64_Sxword)v >= 0x80000000
+      	  || (Elf64_Sxword)v < -(Elf64_Sxword)0x80000000)
+	ret = obj_reloc_overflow;
+      *iloc = v;
+      break;
+
     default:
       ret = obj_reloc_unhandled;
       break;
