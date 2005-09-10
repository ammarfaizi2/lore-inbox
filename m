Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVIJUQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVIJUQR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVIJUQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:16:17 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:37249 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932275AbVIJUQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:16:17 -0400
Message-ID: <43233ED6.2080101@gmail.com>
Date: Sat, 10 Sep 2005 22:15:18 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, nils@kernelconcepts.de
Subject: Re: [PATCH 10/10] drivers/char: pci_find_device remove (drivers/char/watchdog/i8xx_tco.c)
References: <200509101221.j8ACLAOV017267@localhost.localdomain>
In-Reply-To: <200509101221.j8ACLAOV017267@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: nils@kernelconcepts.de [maintainer]

Jiri Slaby napsal(a):

>Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
>
> i8xx_tco.c |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
>--- a/drivers/char/watchdog/i8xx_tco.c
>+++ b/drivers/char/watchdog/i8xx_tco.c
>@@ -414,12 +414,11 @@ static unsigned char __init i8xx_tco_get
> 	 *      Find the PCI device
> 	 */
> 
>-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
>+	for_each_pci_dev(dev)
> 		if (pci_match_id(i8xx_tco_pci_tbl, dev)) {
> 			i8xx_tco_pci = dev;
> 			break;
> 		}
>-	}
> 
> 	if (i8xx_tco_pci) {
> 		/*
>@@ -535,6 +534,8 @@ static void __exit watchdog_cleanup (voi
> 	misc_deregister (&i8xx_tco_miscdev);
> 	unregister_reboot_notifier(&i8xx_tco_notifier);
> 	release_region (TCOBASE, 0x10);
>+
>+	pci_dev_put(i8xx_tco_pci);
> }
> 
> module_init(watchdog_init);
>  
>

