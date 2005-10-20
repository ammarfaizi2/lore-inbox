Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVJTL1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVJTL1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 07:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJTL1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 07:27:25 -0400
Received: from wireless-99.fi.muni.cz ([147.251.51.99]:51096 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932069AbVJTL1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 07:27:24 -0400
Message-ID: <43577F1F.3070209@gmail.com>
Date: Thu, 20 Oct 2005 13:27:27 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] `unaligned access' in acpi get_root_bridge_busnr()
References: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
In-Reply-To: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb napsal(a):

>In drivers/acpi/glue.c the address of an integer is cast to the
>address of an unsigned long.  This breaks on systems where a long is
>larger than an int --- for a start the int can be misaligned; for a
>second the assignment through the pointer will overwrite part of the
>next variable.
>
>Patch is against linux-2.6.14-rc4
>
>Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>
>
>Index: linux-2.6-import/drivers/acpi/glue.c
>===================================================================
>--- linux-2.6-import.orig/drivers/acpi/glue.c	2005-09-09 09:08:49.928854100 +1000
>+++ linux-2.6-import/drivers/acpi/glue.c	2005-10-20 13:32:32.126445742 +1000
>@@ -89,46 +89,46 @@ static int acpi_find_bridge_device(struc
> /* Get PCI root bridge's handle from its segment and bus number */
> struct acpi_find_pci_root {
> 	unsigned int seg;
> 	unsigned int bus;
> 	acpi_handle handle;
> };
> 
> static acpi_status
> do_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
> {
>-	int *busnr = (int *)data;
>+	unsigned long *busnr = (unsigned long *)data;
>  
>
Is the cast here really needed?

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E

