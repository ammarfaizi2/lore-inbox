Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317339AbSGTDc4>; Fri, 19 Jul 2002 23:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317340AbSGTDc4>; Fri, 19 Jul 2002 23:32:56 -0400
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.148]:14314 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S317339AbSGTDcz>; Fri, 19 Jul 2002 23:32:55 -0400
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Fri, 19 Jul 2002 20:36:52 -0700
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [Pcihpd-discuss] [PATCH] ACPI PCI Hotplug driver update for 2.4.19-rc2-ac2
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       greg@kroah.com
In-Reply-To: <20020719192313.GD22862@kroah.com>
References: <20020719192313.GD22862@kroah.com>
Message-Id: <20020719203206.2062.T-KOUCHI@mvf.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My colleague pointed out that the patch was missing this critical patch.
Please include this also.

On Fri, 19 Jul 2002 12:23:13 -0700
Greg KH <greg@kroah.com> wrote:

> Here's a patch against 2.4.19-rc2-ac2 that updates the ACPI PCI Hotplug
> driver to the latest version.  This patch was written by Takayoshi KOCHI
> <t-kouchi@mvf.biglobe.ne.jp> and has been tested on some IBM i386, NEC
> i386, and some unnammed ia64 machines.

Thanks for update, Greg!

--- linux-2419-rc2-ac2/drivers/hotplug/acpiphp_glue.c.orig	Fri Jul 19 20:08:32 2002
+++ linux-2419-rc2-ac2/drivers/hotplug/acpiphp_glue.c	Fri Jul 19 20:11:29 2002
@@ -377,12 +377,13 @@
 		if (b->number == bus)
 			return b;
 
-		if (!list_empty(&b->children))
+		if (!list_empty(&b->children)) {
 			/* XXX recursive call */
 			b = find_pci_bus(&b->children, bus);
 
-		if (b)
-			return b;
+			if (b)
+				return b;
+		}
 	}
 
 	return 0;


Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

