Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUA0WI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbUA0WGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:06:35 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:18094 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265630AbUA0WGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:06:25 -0500
To: marcelo.tosatti@cyclades.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL PATCH] 2.4.25pre7 warning fix
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 27 Jan 2004 22:28:12 +0100
Message-ID: <m3u12hcc9f.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patch fixes the following warning msg:

time.c:435: warning: `do_gettimeoffset_cyclone' defined but not used

There is no need to define functions which do just { return 0; } and
which aren't called by anything.

(In case CONFIG_X86_SUMMIT is defined, there is another (real)
do_gettimeoffset_cyclone() function, and it is referenced - but
it's simply not related to this empty function).

Please apply to 2.4 kernel tree. Thanks.
-- 
Krzysztof Halasa, B*FH

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=time-2.4.23pre9.patch

--- linux-2.4.orig/arch/i386/kernel/time.c	2003-10-24 22:48:15.000000000 +0200
+++ linux-2.4/arch/i386/kernel/time.c	2003-11-09 17:38:18.000000000 +0100
@@ -430,7 +430,6 @@
 
 const int use_cyclone = 0;
 static void mark_timeoffset_cyclone(void) {}
-static unsigned long do_gettimeoffset_cyclone(void) {return 0;}
 static void init_cyclone_clock(void) {}
 void __cyclone_delay(unsigned long loops) {}
 #endif /* CONFIG_X86_SUMMIT */

--=-=-=--
