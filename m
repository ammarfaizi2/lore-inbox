Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUDZM0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUDZM0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUDZM0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:26:11 -0400
Received: from [203.14.152.115] ([203.14.152.115]:11019 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264526AbUDZM0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:26:06 -0400
Date: Mon, 26 Apr 2004 22:23:14 +1000
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, 241107@bugs.debian.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       t-kochi@bq.jp.nec.com
Subject: Re: Bug#241107: Acknowledgement (kernel-image-2.4.24-1-686: 8139too ethernet driver's iomem resource not freed up on rmmod.)
Message-ID: <20040426122314.GA7545@gondor.apana.org.au>
References: <E1B8Okk-0000VO-4C@lkcl.net> <handler.241107.B.108067442320316.ack@bugs.debian.org> <20040413194259.GA8607@lkcl.net> <20040424211004.GA2585@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20040424211004.GA2585@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 24, 2004 at 09:10:04PM +0000, Luke Kenneth Casson Leighton wrote:
>
> Apr 24 21:01:33 localhost kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
> Apr 24 21:02:00 localhost kernel: cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.7
> Apr 24 21:02:08 localhost kernel: shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x1001
> Apr 24 21:02:13 localhost kernel: acpi: Unknown symbol acpi_processor_unregister_performance
> Apr 24 21:02:13 localhost kernel: acpi: Unknown symbol acpi_processor_register_performance
> Apr 24 21:02:44 localhost kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
> Apr 24 21:02:44 localhost kernel: Unable to handle kernel paging request at virtual address d0a95cf8
> Apr 24 21:02:44 localhost kernel:  printing eip:
> Apr 24 21:02:44 localhost kernel: c01c8d35
> Apr 24 21:02:44 localhost kernel: *pde = 0fa26067
> Apr 24 21:02:44 localhost kernel: *pte = 00000000
> Apr 24 21:02:44 localhost kernel: Oops: 0000 [#1]
> Apr 24 21:02:44 localhost kernel: PREEMPT 
> Apr 24 21:02:44 localhost kernel: CPU:    0
> Apr 24 21:02:44 localhost kernel: EIP:    0060:[acpi_pci_register_driver+25/92]    Not tainted

Thanks.

The first load of acpiphp didn't clean up properly.  This patch should
fix it.

You can get the updated acpiphp module for that kernel at

http://gondor.apana.org.au/debian/kernel/binary/2.6.5/686/

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/pci/hotplug/acpiphp_glue.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/pci/hotplug/acpiphp_glue.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	5 Apr 2004 09:49:33 -0000	1.1.1.8
+++ b/drivers/pci/hotplug/acpiphp_glue.c	26 Apr 2004 12:18:46 -0000
@@ -1113,6 +1113,8 @@
 
 		kfree(bridge);
 	}
+
+	acpi_pci_unregister_driver(&acpi_pci_hp_driver);
 }
 
 

--bg08WKrSYDhXBjb5--
