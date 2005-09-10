Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVIJURT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVIJURT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVIJURT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:17:19 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:43136 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932277AbVIJURS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:17:18 -0400
Message-ID: <43233F48.6060406@gmail.com>
Date: Sat, 10 Sep 2005 22:17:12 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, mhw@wittsend.com
Subject: Re: [PATCH 1/10] drivers/char: pci_find_device remove (drivers/char/ip2main.c)
References: <200509101221.j8ACL8oq017230@localhost.localdomain>
In-Reply-To: <200509101221.j8ACL8oq017230@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: mhw@wittsend.com [maintainer]

Jiri Slaby napsal(a):

>Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
>
> ip2main.c |    8 +++++---
> 1 files changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
>--- a/drivers/char/ip2main.c
>+++ b/drivers/char/ip2main.c
>@@ -442,6 +442,7 @@ cleanup_module(void)
> #ifdef CONFIG_PCI
> 		if (ip2config.type[i] == PCI && ip2config.pci_dev[i]) {
> 			pci_disable_device(ip2config.pci_dev[i]);
>+			pci_dev_put(ip2config.pci_dev[i]);
> 			ip2config.pci_dev[i] = NULL;
> 		}
> #endif
>@@ -594,9 +595,10 @@ ip2_loadmain(int *iop, int *irqp, unsign
> 		case PCI:
> #ifdef CONFIG_PCI
> 			{
>-				struct pci_dev *pci_dev_i = NULL;
>-				pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
>-							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
>+				struct pci_dev *pci_dev_i;
>+				pci_dev_i = pci_get_device(
>+					PCI_VENDOR_ID_COMPUTONE,
>+					PCI_DEVICE_ID_COMPUTONE_IP2EX, NULL);
> 				if (pci_dev_i != NULL) {
> 					unsigned int addr;
> 
>  
>
