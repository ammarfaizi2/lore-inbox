Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263377AbTC2C0R>; Fri, 28 Mar 2003 21:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263378AbTC2C0R>; Fri, 28 Mar 2003 21:26:17 -0500
Received: from [12.47.58.223] ([12.47.58.223]:18082 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263377AbTC2C0Q>; Fri, 28 Mar 2003 21:26:16 -0500
Date: Fri, 28 Mar 2003 18:38:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, vortex@scyld.com
Subject: Re: Bad PCI IDs-Names table in 3c59x.c
Message-Id: <20030328183836.36ccd14b.akpm@digeo.com>
In-Reply-To: <20030329013022.GA2711@werewolf.able.es>
References: <20030329013022.GA2711@werewolf.able.es>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2003 02:37:28.0301 (UTC) FILETIME=[23BBD1D0:01C2F59C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> +	{ 0x10B7, 0x1201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982A },
> +	{ 0x10B7, 0x1202, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982B },

OK.  I'm a bit mystified as to how these ID's got lost.  They do not appear
in Donald's latest driver, so I assume the catchall PCI ID match picked them
up.  

The mainstream PCI code does not have the catchall capability.

Keeping that big device table in sync is a real pain, which is why it has
been kept grouped into batches of five entries.  

Donald's driver describes 0x9805 as a "3c982 Server Tornado".  What makes you
think it is a "3c980 Python-T"?


Can you please retest with this (against 2.4.20-pre5).  I didn't change
0x9805.  Probably Donald's driver is right, but I'd like some confirmation.


diff -puN drivers/net/3c59x.c~3c59x-980-support drivers/net/3c59x.c
--- 24/drivers/net/3c59x.c~3c59x-980-support	2003-03-28 18:19:01.000000000 -0800
+++ 24-akpm/drivers/net/3c59x.c	2003-03-28 18:19:01.000000000 -0800
@@ -442,6 +442,8 @@ enum vortex_chips {
 	CH_3CCFEM656_1,
 	CH_3C450,
 	CH_3C920,
+	CH_3C982A,
+	CH_3C982B,
 };
 
 
@@ -535,6 +537,11 @@ static struct vortex_chip_info {
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
 	{"3c920 Tornado",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },
+	{"3c982 Hydra Dual Port A",
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+	{"3c982 Hydra Dual Port B",
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
+
 	{0,}, /* 0 terminated list. */
 };
 
@@ -579,6 +586,8 @@ static struct pci_device_id vortex_pci_t
 	{ 0x10B7, 0x6564, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3CCFEM656_1 },
 	{ 0x10B7, 0x4500, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C450 },
 	{ 0x10B7, 0x9201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C920 },
+	{ 0x10B7, 0x1201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982A },
+	{ 0x10B7, 0x1202, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982B },
 	{0,}						/* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, vortex_pci_tbl);

_

