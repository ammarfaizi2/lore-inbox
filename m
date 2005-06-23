Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVFWKOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVFWKOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVFWKK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:10:57 -0400
Received: from iris-63.mc.com ([63.96.239.141]:43414 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S262631AbVFWJ43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:56:29 -0400
Subject: [PATCH] proposed patch for scripts/kconfig/mconf.c
From: Jean-Christophe Dubois <jdubois@mc.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Content-Type: text/plain
Organization: Mercury Computer Systems
Date: Thu, 23 Jun 2005 11:56:22 +0200
Message-Id: <1119520582.27150.36.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2005 09:56:23.0855 (UTC) FILETIME=[D07033F0:01C577D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried Linux 2.6.12 and I had to change one file in "script"
because my compilation failed on mcconf.c. I tried to contact Arnaldo
Carvalho de Melo about the proposed change because he changed this file
recently adding, among other things, a call to setlocale(). But the
corresponding header file ("locale.h") is not
listed in the files to #include.

This is failing on my cross-compilation environment (From a solaris
system) using gcc-3.4.1 (as the compiler can't find a prototype for the
setlocale() function).

I am not sure who is the "maintainer" of this part of the build system,
so I am now broadcasting it to a larger audience. I hope that's OK.
Sorry if this has already been found/fixed but my "googling" for it
didn't report any hit.

Thanks

JC

=====================================================================

Add <locale.h> in the list of included files to allow the compiler to
find the setlocale() prototype.

Signed-off-by: Jean-Christophe Dubois <jdubois@mc.com>

--- linux-2.6.12/scripts/kconfig/mconf.c        2005-06-17
15:48:29.000000000 -0400
+++ linux-2.6.12.mrcy/scripts/kconfig/mconf.c   2005-06-20
12:34:49.509259000 -0400
@@ -20,6 +20,7 @@
 #include <string.h>
 #include <termios.h>
 #include <unistd.h>
+#include <locale.h>
 
 #define LKC_DIRECT_LINK
 #include "lkc.h"

