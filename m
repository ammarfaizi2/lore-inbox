Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUFXTOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUFXTOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUFXTNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:13:05 -0400
Received: from fmr03.intel.com ([143.183.121.5]:4992 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S265198AbUFXTK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:10:26 -0400
Message-Id: <200406241908.i5OJ8rY20620@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.7-mm2 build failure
Date: Thu, 24 Jun 2004 12:10:18 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRaHR2xF8OwKsFtTnmYOWjoOyJ8kAAAJClg
In-Reply-To: <20040624115640.5f01ce20.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Begin forwarded message:
>
> Date: Thu, 24 Jun 2004 07:43:58 -0700
> From: "Martin J. Bligh" <mbligh@aracnet.com>
> To: Andrew Morton <akpm@osdl.org>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: 2.6.7-mm2 build failure
>
>
> drivers/base/node.c: In function `node_read_meminfo':
> drivers/base/node.c:56: warning: implicit declaration of function
> `hugetlb_report_node_meminfo'
> drivers/built-in.o(.text+0x1f615): In function `node_read_meminfo':
> : undefined reference to `hugetlb_report_node_meminfo'
> make: *** [.tmp_vmlinux1] Error 1
>
> Hmmm. I wonder if anyone tested that patch ;-)
>

Sorry, missing a #include.  Tested with/without hugetlb config'ed.  Previous
patch was tested with hugetlb page configured.


diff -Nur linux-2.6.7.orig/drivers/base/node.c linux-2.6.7/drivers/base/node.c
--- linux-2.6.7.orig/drivers/base/node.c	2004-06-15 22:18:59.000000000 -0700
+++ linux-2.6.7/drivers/base/node.c	2004-06-24 12:01:48.000000000 -0700
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/node.h>
+#include <linux/hugetlb.h>
 #include <linux/cpumask.h>
 #include <linux/topology.h>


