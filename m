Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVAYOwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVAYOwC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVAYOwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:52:02 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:13575 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261966AbVAYOvr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:51:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] drivers/block/cpqarray.c: small cleanups
Date: Tue, 25 Jan 2005 08:51:44 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC01E9@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/block/cpqarray.c: small cleanups
Thread-Index: AcUC0QDDOcdusGASQVWMLR5Gt6btdgAHEzcw
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "ISS StorageDev" <iss_storagedev@hp.com>
X-OriginalArrivalTime: 25 Jan 2005 14:51:46.0634 (UTC) FILETIME=[647CEAA0:01C502ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----

> This patch contains the following cleanups:
> - make cpqarray_pci_device_id static
> - merge cpqarray_init_step2 into cpqarray_init and make it static
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> ---
> 
>  drivers/block/cpqarray.c |   13 ++-----------
>  1 files changed, 2 insertions(+), 11 deletions(-)
> 
> This patch was already sent on:
> - 29 Nov 2004
> 
> --- linux-2.6.10-rc1-mm3-full/drivers/block/cpqarray.c.old	
> 2004-11-06 19:51:42.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-full/drivers/block/cpqarray.c	
> 2004-11-06 19:53:16.000000000 +0100
> @@ -97,7 +97,7 @@
>  };
>  
>  /* define the PCI info for the PCI cards this driver can control */
> -const struct pci_device_id cpqarray_pci_device_id[] =
> +static const struct pci_device_id cpqarray_pci_device_id[] =
>  {
>  	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_COMPAQ_42XX,
>  		0x0E11, 0x4058, 0, 0, 0},       /* SA431 */
> @@ -135,7 +135,6 @@
>  /* Debug Extra Paranoid... */
>  #define DBGPX(s) do { } while(0)
>  
> -int cpqarray_init_step2(void);
>  static int cpqarray_pci_init(ctlr_info_t *c, struct pci_dev *pdev);
>  static void __iomem *remap_pci_mem(ulong base, ulong size);
>  static int cpqarray_eisa_detect(void);
> @@ -312,14 +311,6 @@
>  
>  module_param_array(eisa, int, NULL, 0);
>  
> -/* This is a bit of a hack,
> - * necessary to support both eisa and pci
> - */
> -int __init cpqarray_init(void)
> -{
> -	return (cpqarray_init_step2());
> -}
> -
>  static void release_io_mem(ctlr_info_t *c)
>  {
>  	/* if IO mem was not protected do nothing */
> @@ -560,7 +551,7 @@
>   *  This is it.  Find all the controllers and register them.
>   *  returns the number of block devices registered.
>   */
> -int __init cpqarray_init_step2(void)
> +static int __init cpqarray_init(void)
>  {
>  	int num_cntlrs_reg = 0;
>  	int i;
> 
> 
