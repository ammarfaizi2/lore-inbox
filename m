Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUFFR4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUFFR4x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFFRzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:55:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:27603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263898AbUFFRzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:55:40 -0400
Date: Sun, 6 Jun 2004 10:51:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Yury Umanets <torque@ukrpost.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 memory allocation checks in
 drivers/pci/hotplug/shpchprm_acpi.c
Message-Id: <20040606105106.01c2fec9.rddunlap@osdl.org>
In-Reply-To: <1086538851.2793.90.camel@firefly>
References: <1086538851.2793.90.camel@firefly>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2004 19:20:51 +0300 Yury Umanets wrote:

| Adds memory allocation checks in acpi_get__hpp()
| 
|  ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c |    2 ++
|  1 files changed, 2 insertions(+)
| 
| Signed-off-by: Yury Umanets <torque@ukrpost.net>
| 
| diff -rupN ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c
| ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
| --- ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c	Mon May 10
| 05:32:28 2004
| +++ ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c	Wed Jun 
| 2 14:28:07 2004
| @@ -218,6 +218,8 @@ static void acpi_get__hpp ( struct acpi_
|  	}
|  
|  	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
| +	if (!ab->_hpp)
| +		goto free_and_return;
|  	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
|  
|  	ab->_hpp->cache_line_size	= nui[0];
| 
| -- 

All other failure paths in this function use err() to inform the
console about what's happening...  so flip a coin, I guess:
add a message or say that ACPI already has too many messages.  :(

--
~Randy
