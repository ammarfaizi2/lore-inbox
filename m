Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUEEJGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUEEJGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUEEJGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:06:44 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:3086 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262337AbUEEJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:06:42 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Date: Wed, 5 May 2004 10:57:06 +0200
User-Agent: KMail/1.6.2
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       bunk@fs.tum.de, marcelo.tosatti@cyclades.com
References: <20040503230911.GE7068@logos.cnet> <20040504205659.GA17583@havoc.gtf.org> <20040504201832.1c8d07a3.davem@redhat.com>
In-Reply-To: <20040504201832.1c8d07a3.davem@redhat.com>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ixKmAFSuHT/GlqZ"
Message-Id: <200405051057.06222@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ixKmAFSuHT/GlqZ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 05 May 2004 05:18, David S. Miller wrote:

Hi Dave,

> > I would rather add the simple patch to 2.4.x core, since tg3 isn't the
> > only driver that continues to be heavily used in 2.4, and thus will
> > continue to be actively maintained for a while...

> I agree, anyone cooking up a patch for this?


Like this?

ciao, Marc

--Boundary-00=_ixKmAFSuHT/GlqZ
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

--Boundary-00=_ixKmAFSuHT/GlqZ--
