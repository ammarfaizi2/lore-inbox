Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUG0Arx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUG0Arx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUG0Arx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:47:53 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:34569 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S266166AbUG0Arb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:47:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Date: Mon, 26 Jul 2004 17:46:31 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F95EF@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Thread-Index: AcRzcjFWkJH3jwJsRkWb7SsMTQek4gAABr5Q
From: "Andrew Chew" <achew@nvidia.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
X-OriginalArrivalTime: 27 Jul 2004 00:47:21.0910 (UTC) FILETIME=[46C70D60:01C47373]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sincerely apologize about the mangled patch.  I'll be more careful
next time (and check my mailer settings).

The #ifdef was for consistency (I noticed that there were other IDs
similarly defined in intel8x0.c).  I don't see why we'd need it, either.
We should probably remove PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO and
PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO #defines from intel8x0.c as well, as
they're similarly redundant.  For that matter, why not remove all of the
PCI_DEVICE_ID_* #defines from the intel8x0.c driver, and make sure the
device IDs are defined in pci_ids.h.

Want me to submit a patch for that?

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org] 
> Sent: Monday, July 26, 2004 5:38 PM
> To: Andrew Chew
> Cc: linux-kernel@vger.kernel.org; jgarzik@pobox.com
> Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 
> audio support
> 
> 
> "Andrew Chew" <achew@nvidia.com> wrote:
> >
> > This patch updates include/linux/pci_ids.h with the CK804 audio  
> > controller ID, and adds the CK804 audio controller to the  
> > sound/pci/intel8x0.c audio driver.
> 
> I'm getting many workwrapped and tab-replaced patches 
> nowadays.  Could people pleeeeze ensure that their email 
> clients are sending unmangled patches?
> 
> I fixed this one up.  I usually do :(
> 
> 
> >  --- linux-2.6.8-rc2/include/linux/pci_ids.h	2004-07-21
> >  15:22:57.000000000 -0700
> >  +++ linux/include/linux/pci_ids.h	2004-07-20 18:49:22.000000000
> >  -0700
> >  @@ -1071,6 +1071,7 @@
> >   #define PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2	0x0055
> >   #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
> >   #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
> >  +#define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
> >   #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
> >   #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
> >   #define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
> >  --- linux-2.6.8-rc2/sound/pci/intel8x0.c	2004-07-21
> >  15:22:59.000000000 -0700
> >  +++ linux/sound/pci/intel8x0.c	2004-07-20 
> 18:52:07.000000000 -0700
> >  @@ -155,6 +155,9 @@
> >   #ifndef PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO
> >   #define PCI_DEVICE_ID_NVIDIA_CK8S_AUDIO	0x00ea
> >   #endif
> >  +#ifndef PCI_DEVICE_ID_NVIDIA_CK804_AUDIO
> >  +#define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO 0x0059
> >  +#endif
> >   
> 
> Why does the driver need this ifdef?  We just added the ID to 
> pci_ids.h?
> 
