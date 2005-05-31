Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVEaQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVEaQVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVEaQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:20:31 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:32452 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261940AbVEaQSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:18:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K/H3byDZSj0izxtKtvhI/vDuwJe/zPpbPsooWsK4UfcAos8R++E1GytmD5sk2vlp4wK2i3/rlgmNxN40sx+JeBXfxRN7DAIFrPAQRxHT4RN1PJVkSYqVW6QWYTUNQCygBmnE5Y+16bD4BxxvhdAdnrmenD2DjYmX/plebTcFEWw=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Subject: Re: pcdp-build-fix.patch added to -mm tree
Date: Tue, 31 May 2005 20:22:44 +0400
User-Agent: KMail/1.7.2
Cc: peterc@gelato.unsw.edu.au, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
References: <200505310925.j4V9PNoS009318@shell0.pdx.osdl.net>
In-Reply-To: <200505310925.j4V9PNoS009318@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505312022.44479.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 13:24, akpm@osdl.org wrote:
> --- 25/drivers/firmware/pcdp.c~pcdp-build-fix
> +++ 25-akpm/drivers/firmware/pcdp.c
> @@ -11,6 +11,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/config.h>
>  #include <linux/acpi.h>

Does this patch make sense?
===========================
Recent restoration of quirk_via_irqpic() #ifdef'fed whole include/linux/acpi.h
with CONFIG_ACPI. So, if acpi.h is unlucky enough to be included before
config.h, bad things happen:

		[tested, patch fixes the warning]

	drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
	drivers/serial/8250_acpi.c:51: warning: implicit declaration of
	function `acpi_register_gsi'

or even

		[untested]

	In file included from drivers/firmware/pcdp.c:18:
	drivers/firmware/pcdp.h:48: error: field 'addr' has incomplete type

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-vanilla/include/linux/acpi.h	2005-05-28 02:59:59.000000000 +0400
+++ linux-8250/include/linux/acpi.h	2005-05-28 03:39:25.000000000 +0400
@@ -25,6 +25,8 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#include <linux/config.h>
+
 #ifdef	CONFIG_ACPI
 
 #ifndef _LINUX
