Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUA0Eug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 23:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUA0Eug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 23:50:36 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:25863 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261931AbUA0Eud convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 23:50:33 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpqarray update
Date: Mon, 26 Jan 2004 22:50:31 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E15967@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update
Thread-Index: AcPkeP4fFRtohlQWRQOrXeFPjVwFIgAF/OAw
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jan 2004 04:50:32.0368 (UTC) FILETIME=[182FC300:01C3E491]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Then again, maybe leaving that part alone would be ok too? i.e: keep
using pci_module_init() ... Any opinions?

thanks
-francis-

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Monday, January 26, 2004 7:52 PM
> To: Wiran, Francis
> Cc: Linux Kernel Mailing List
> Subject: Re: [PATCH] cpqarray update
> 
> 
> Wiran, Francis wrote:
> >>You need to check the return value of pci_module_init() for errors.
> > 
> > No, because the return value is determined from number of 
> ctrls found,
> > and not from function return.
> > 
> > int __init cpqarray_init(void)
> > {
> > ...
> > 	pci_module_init(&cpqarray_pci_driver);
> > 	cpqarray_eisa_detect();
> > 
> > 	for(i=0;i<MAX_CTLR;i++) {
> > 		if(hba[i] != NULL)
> > 			num_ctlrs_reg++
> > 	}
> > 
> > 	return (num_ctlrs_reg);
> > }
> > 
> > int __init cpqarray_init_module(void)
> > {
> > 	if (cpqarray_init() == 0)
> > 		return -ENODEV;
> > 	return 0;
> > }
> 
> 
> Nope, this needs to be turned inside out.  The proper PCI 
> driver looks like
> 
> static int __init cp_init (void)
> {
>          return pci_module_init (&cp_driver);
> }
> 
> static void __exit cp_exit (void)
> {
>          pci_unregister_driver (&cp_driver);
> }
> 
> We already handle the cases you describe.  The cpqarray code -breaks- 
> the API design by doing it this way.
> 
> cpqarray does not fully support the pci_ids features and 
> hotplug without 
> this.
> 
> 	Jeff
> 
> 
> 
> 
