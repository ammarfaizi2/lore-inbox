Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUBTNMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUBTMyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:54:04 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.178]:16025 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id S261221AbUBTMx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:53:29 -0500
X-Biglobe-Sender: <hangar-18@mub.biglobe.ne.jp>
Message-ID: <40360343.6090803@mub.biglobe.ne.jp>
Date: Fri, 20 Feb 2004 21:53:23 +0900
From: masami ichikawa <hangar-18@mub.biglobe.ne.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.4.1) Gecko/20031114
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm2
References: <20040220014437.0bf6d47f.akpm@osdl.org>
In-Reply-To: <20040220014437.0bf6d47f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got the following compile error
drivers/parport/parport_pc.c: In function `parport_pc_unregister_port':
drivers/parport/parport_pc.c:2337: error: `priv' undeclared (first use 
in this function)
drivers/parport/parport_pc.c:2337: error: (Each undeclared identifier is 
reported only once
drivers/parport/parport_pc.c:2337: error: for each function it appears in.)
make[2]: *** [drivers/parport/parport_pc.o] Error 1
make[1]: *** [drivers/parport] Error 2
make: *** [drivers] Error 2

I add "#ifdef CONFIG_PARPORT_PC_FIFO" and "#endif"

diff -aur  linux-mm/drivers/parport/parport_pc.c 
linux-mm-new/drivers/parport/parport_pc.c
--- linux-mm/drivers/parport/parport_pc.c       2004-02-20 
20:40:13.000000000 +0900
+++ linux-mm-new/drivers/parport/parport_pc.c   2004-02-20 
21:15:10.434866156 +0900
@@ -2333,9 +2333,13 @@
  #endif /* CONFIG_PARPORT_PC_FIFO */
         struct parport_operations *ops = p->ops;
         parport_remove_port(p);
+
+#ifdef CONFIG_PARPORT_PC_FIFO
         spin_lock(&ports_lock);
         list_del_init(&priv->list);
         spin_unlock(&ports_lock);
+#endif /* CONFIG_PARPORT_PC_FIFO */
+
         if (p->dma != PARPORT_DMA_NONE)
                 free_dma(p->dma);
         if (p->irq != PARPORT_IRQ_NONE)


-- 
/*
  * masami ichikawa
  * mailto:hangar-18@mub.biglobe.ne.jp
  */

