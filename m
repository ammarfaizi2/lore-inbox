Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVIJUUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVIJUUG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVIJUUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:20:05 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:4224 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932279AbVIJUUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:20:04 -0400
Message-ID: <43233FEC.2020802@gmail.com>
Date: Sat, 10 Sep 2005 22:19:56 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH 5/10] drivers/char: pci_find_device remove (drivers/char/specialix.c)
References: <200509101221.j8ACL9XI017246@localhost.localdomain>
In-Reply-To: <200509101221.j8ACL9XI017246@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: R.E.Wolff@BitWizard.nl [maintainer]

Jiri Slaby napsal(a):

>Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
>
> specialix.c |    9 ++++++---
> 1 files changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
>--- a/drivers/char/specialix.c
>+++ b/drivers/char/specialix.c
>@@ -2502,9 +2502,9 @@ static int __init specialix_init(void)
> 				i++;
> 				continue;
> 			}
>-			pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
>-			                        PCI_DEVICE_ID_SPECIALIX_IO8, 
>-			                        pdev);
>+			pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX,
>+					PCI_DEVICE_ID_SPECIALIX_IO8,
>+					pdev);
> 			if (!pdev) break;
> 
> 			if (pci_enable_device(pdev))
>@@ -2517,7 +2517,10 @@ static int __init specialix_init(void)
> 			sx_board[i].flags |= SX_BOARD_IS_PCI;
> 			if (!sx_probe(&sx_board[i]))
> 				found ++;
>+
> 		}
>+		if (i >= SX_NBOARD)
>+			pci_dev_put(pdev);
> 	}
> #endif
> 
>  
>
