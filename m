Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUJNToY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUJNToY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJNTn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:43:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:10145 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267396AbUJNTgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:36:42 -0400
Message-ID: <416ED349.9090307@osdl.org>
Date: Thu, 14 Oct 2004 12:28:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       davej@codemonkey.org.uk
Subject: [PATCH] intel_agp: dangling devexit reference
Content-Type: multipart/mixed;
 boundary="------------010604040602020606020807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010604040602020606020807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix error found by 'scripts/reference_discarded.pl':
Error: ./drivers/char/agp/intel-agp.o .data refers to 00000914 
R_386_32          .exit.text

-- 
~Randy

--------------010604040602020606020807
Content-Type: text/x-patch;
 name="intel_agp_devexit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intel_agp_devexit.patch"


Fix error found by 'scripts/reference_discarded.pl':
Error: ./drivers/char/agp/intel-agp.o .data refers to 00000914 R_386_32          .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/char/agp/intel-agp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/char/agp/intel-agp.c~intel_agp_devexit ./drivers/char/agp/intel-agp.c
--- ./drivers/char/agp/intel-agp.c~intel_agp_devexit	2004-10-11 21:09:57.000000000 -0700
+++ ./drivers/char/agp/intel-agp.c	2004-10-12 22:14:55.289864744 -0700
@@ -1778,7 +1778,7 @@ static struct pci_driver agp_intel_pci_d
 	.name		= "agpgart-intel",
 	.id_table	= agp_intel_pci_table,
 	.probe		= agp_intel_probe,
-	.remove		= agp_intel_remove,
+	.remove		= __devexit_p(agp_intel_remove),
 	.resume		= agp_intel_resume,
 };
 

--------------010604040602020606020807--
