Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264309AbUEDUzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbUEDUzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUEDUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:55:41 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:26374 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264321AbUEDUzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:55:37 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Date: Tue, 4 May 2004 22:53:11 +0200
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jgarzik@pobox.com,
       davem@redhat.com
References: <20040503230911.GE7068@logos.cnet> <20040504204633.GB8643@fs.tum.de>
In-Reply-To: <20040504204633.GB8643@fs.tum.de>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3KAmASsqFNyW7qO"
Message-Id: <200405042253.11133@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3KAmASsqFNyW7qO
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 04 May 2004 22:46, Adrian Bunk wrote:

Hi Adrian,

> drivers/net/net.o(.text+0x60293): In function `tg3_get_strings':
> : undefined reference to `WARN_ON'
> make: *** [vmlinux] Error 1
> There's no WARN_ON in 2.4.

yep. Either we backport WARN_ON ;) or simply do the attached.

ciao, Marc

--Boundary-00=_3KAmASsqFNyW7qO
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="564_tg3-2.4.27-pre2-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="564_tg3-2.4.27-pre2-1.patch"

--- old/drivers/net/tg3.c	2004-05-04 14:30:22.000000000 +0200
+++ new/drivers/net/tg3.c	2004-05-04 14:49:58.000000000 +0200
@@ -51,6 +51,10 @@
 #define TG3_TSO_SUPPORT	0
 #endif
 
+#ifndef WARN_ON
+#define	WARN_ON(x)	do { } while (0)
+#endif
+
 #include "tg3.h"
 
 #define DRV_MODULE_NAME		"tg3"

--Boundary-00=_3KAmASsqFNyW7qO--
