Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTKTQiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 11:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTKTQiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 11:38:50 -0500
Received: from ajax.xo.com ([207.155.248.44]:34498 "EHLO ajax.xo.com")
	by vger.kernel.org with ESMTP id S262038AbTKTQis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 11:38:48 -0500
Message-ID: <3FBCEDF7.7030807@katana-technology.com>
Date: Thu, 20 Nov 2003 11:38:15 -0500
From: Larry Sendlosky <lsendlosky@katana-technology.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: patch for current cvs of microkernel for interrupt delivery
Content-Type: multipart/mixed;
 boundary="------------000603060105030009030508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000603060105030009030508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes are in mainline linux for "public" ethernet support (device
config support).  Currently, the attached patch is needed in
the microkernel for interrupt delivery to work.

larry

ps: nfs root mounting cheat will come shortly.


--------------000603060105030009030508
Content-Type: text/plain;
 name="kma.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kma.c.patch"

Index: kma.c
===================================================================
RCS file: /src/microkernel/sys/ds/kma/kma.c,v
retrieving revision 1.54
diff -C8 -u -r1.54 kma.c
--- kma.c	18 Nov 2003 19:31:37 -0000	1.54
+++ kma.c	20 Nov 2003 16:35:35 -0000
@@ -1773,17 +1773,17 @@
  * Returns:
  *	none
  */
 static inline void
 kma_deliver_queued_int(struct trapframe *frame)
 {
         u_int index = vs_deliver_int(curvs, PCPU_GET(cpuid));
         if (index < KMA_VI_MAX_INTERRUPT)
-                kma_propagate_int(index + KMA_VI_IRQ_BASE, frame);
+                kma_propagate_int(index, frame);
         return;
 }
 
 
 /* 
  * KMA internal interface
  *
  */

--------------000603060105030009030508--

