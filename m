Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUEEQbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUEEQbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUEEQbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:31:03 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:3347 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264720AbUEEQar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:30:47 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Date: Wed, 5 May 2004 18:28:55 +0200
User-Agent: KMail/1.6.2
Cc: Carson Gaspar <carson@taltos.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marco Fais <marco.fais@abbeynet.it>
References: <406D3E8F.20902@abbeynet.it> <20040504010714.GA8028@logos.cnet> <765880000.1083774300@taltos.ny.ficc.gs.com>
In-Reply-To: <765880000.1083774300@taltos.ny.ficc.gs.com>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HZRmA3PrA3/C0wI"
Message-Id: <200405051828.55572@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_HZRmA3PrA3/C0wI
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 05 May 2004 18:25, Carson Gaspar wrote:

Hi Carson,

> I'd love to. However 2.4.27-pre2 broke the tg3 driver. tg3.c contains
> WARN_ON(1). Sadly, WARN_ON doesn't exist in 2.4.x, so depmod correctly
> complains about an unresolved symbol.
> I'm beginning to wonder if anyone actually builds these pre releases... I
> mean, I know the tg3 driver is really obscure, and only used by 2 people,
> but...

by 2 people? you have to be kidding.

Anyway, attached is 2.4 WARN_ON. Apply it and use tg3 :p

ciao, Marc

--Boundary-00=_HZRmA3PrA3/C0wI
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-WARN_ON.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.4-WARN_ON.patch"

--- old/include/linux/kernel.h	2004-05-04 21:48:24.000000000 +0200
+++ new/include/linux/kernel.h	2004-05-05 10:53:32.000000000 +0200
@@ -196,4 +196,11 @@ struct sysinfo {
 
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif /* _LINUX_KERNEL_H */

--Boundary-00=_HZRmA3PrA3/C0wI--
