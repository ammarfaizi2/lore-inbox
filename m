Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264801AbUFGPwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbUFGPwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFGPwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:52:47 -0400
Received: from may.priocom.com ([213.156.65.50]:51674 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S264801AbUFGPwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:52:18 -0400
Subject: Re: [PATCH] 2.6.6 memory allocation checks in
	drivers/pci/hotplug/shpchprm_acpi.c
From: Yury Umanets <torque@ukrpost.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040606105106.01c2fec9.rddunlap@osdl.org>
References: <1086538851.2793.90.camel@firefly>
	 <20040606105106.01c2fec9.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1086623550.20964.16.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Jun 2004 18:52:31 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 20:51, Randy.Dunlap wrote:
> On Sun, 06 Jun 2004 19:20:51 +0300 Yury Umanets wrote:
> 
> | Adds memory allocation checks in acpi_get__hpp()
> | 
> |  ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c |    2 ++
> |  1 files changed, 2 insertions(+)
> | 
> | Signed-off-by: Yury Umanets <torque@ukrpost.net>
> | 
> | diff -rupN ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c
> | ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
> | --- ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c	Mon May 10
> | 05:32:28 2004
> | +++ ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c	Wed Jun 
> | 2 14:28:07 2004
> | @@ -218,6 +218,8 @@ static void acpi_get__hpp ( struct acpi_
> |  	}
> |  
> |  	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
> | +	if (!ab->_hpp)
> | +		goto free_and_return;
> |  	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
> |  
> |  	ab->_hpp->cache_line_size	= nui[0];
> | 
> | -- 
> 
> All other failure paths in this function use err() to inform the
> console about what's happening...  so flip a coin, I guess:
> add a message or say that ACPI already has too many messages.  :(

Hello Randy!

Fixed versions for both (shpchprm_acpi.c and pciehprm_acpi.c) are below:

 ./linux-2.6.6-modified/drivers/pci/hotplug/pciehprm_acpi.c |    4 ++++
 1 files changed, 4 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/pci/hotplug/pciehprm_acpi.c
./linux-2.6.6-modified/drivers/pci/hotplug/pciehprm_acpi.c
--- ./linux-2.6.6/drivers/pci/hotplug/pciehprm_acpi.c	Mon May 10
05:33:19 2004
+++ ./linux-2.6.6-modified/drivers/pci/hotplug/pciehprm_acpi.c	Mon Jun 
7 18:40:15 2004
@@ -218,6 +218,10 @@ static void acpi_get__hpp ( struct acpi_
 	}
 
 	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
+	if (!ab->_hpp) {
+		err ("acpi_pciehprm:%s alloc for _HPP fail\n", path_name);
+		goto free_and_return;
+	}
 	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
 
 	ab->_hpp->cache_line_size	= nui[0];


 ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -rupN ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c
./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
--- ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c	Mon May 10
05:32:28 2004
+++ ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c	Mon Jun 
7 18:39:01 2004
@@ -218,6 +218,10 @@ static void acpi_get__hpp ( struct acpi_
 	}
 
 	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
+	if (!ab->_hpp) {
+		err ("acpi_shpchprm:%s alloc for _HPP fail\n", path_name);
+		goto free_and_return;
+	}
 	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
 
 	ab->_hpp->cache_line_size	= nui[0];


-- 
umka

