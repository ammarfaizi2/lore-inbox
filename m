Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUA0BiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUA0BiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:38:00 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:27654 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262566AbUA0Bh4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:37:56 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpqarray update
Date: Mon, 26 Jan 2004 16:32:28 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E15965@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update
Thread-Index: AcPkSWAKrSqANbYXSfK7SsAY8XN2GgAEe2Ow
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jan 2004 22:32:29.0908 (UTC) FILETIME=[48630940:01C3E45C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You need to check the return value of pci_module_init() for errors.
No, because the return value is determined from number of ctrls found,
and not from function return.

int __init cpqarray_init(void)
{
...
	pci_module_init(&cpqarray_pci_driver);
	cpqarray_eisa_detect();

	for(i=0;i<MAX_CTLR;i++) {
		if(hba[i] != NULL)
			num_ctlrs_reg++
	}

	return (num_ctlrs_reg);
}

int __init cpqarray_init_module(void)
{
	if (cpqarray_init() == 0)
		return -ENODEV;
	return 0;
}

regards,
-francis-



> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Monday, January 26, 2004 2:15 PM
> To: Linux Kernel Mailing List; Wiran, Francis
> Subject: Re: [PATCH] cpqarray update
> 
> 
> Linux Kernel Mailing List wrote:
> > ChangeSet 1.1288, 2004/01/26 16:58:21-02:00, francis.wiran@hp.com
> > 
> > 	[PATCH] cpqarray update
> > 	
> > 	Yes, we should. I usually ask Mike Miller in our group 
> to send my
> > 	patches since he's been doing that and more known in 
> the community, but
> > 	since you already got a hold of it ...yes, please :)
> > 	
> > 	CHANGELOG:
> > 	
> > 	   * Fix for eisa card not detecting partitions properly
> > 	   * Use pci_module_init instead of pci_register_device 
> to handle hotplug
> > 	     scenario and unregister if the driver can't find 
> pci controller
> > 	   * Add BLKSSZGET ioctl
> [...]
> > @@ -616,7 +623,7 @@
> >  
> >  	/* detect controllers */
> >  	printk(DRIVER_NAME "\n");
> > -	pci_register_driver(&cpqarray_pci_driver);
> > +	pci_module_init(&cpqarray_pci_driver);
> >  	cpqarray_eisa_detect();
> >  
> >  	for(i=0; i< MAX_CTLR; i++) {
> 
> You need to check the return value of pci_module_init() for errors.
> 
> 	Jeff
> 
> 
> 
> 
