Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275252AbTHMPkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275253AbTHMPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:39:08 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:51213 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275252AbTHMPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:37:35 -0400
Message-ID: <3F3A5EAA.5070000@techsource.com>
Date: Wed, 13 Aug 2003 11:52:10 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Greg KH <greg@kroah.com>, Matthew Wilcox <willy@debian.org>,
       jgarzik@pobox.com, davem@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <20030812235324.GA12953@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Jones wrote:
> On Tue, Aug 12, 2003 at 11:01:58AM -0700, Greg KH wrote:
> 
> What would be *really* nice, would be the ability to do something
> to the effect of..
> 
> 	{
> 		.vendor		= PCI_VENDOR_ID_BROADCOM,
> 		.devices	= {
> 			PCI_DEVICE_ID_TIGON3_5700,
> 			PCI_DEVICE_ID_TIGON3_5701,
> 			PCI_DEVICE_ID_TIGON3_5702,
> 			PCI_DEVICE_ID_TIGON3_5703,
> 			PCI_DEVICE_ID_TIGON3_5704,
> 			PCI_DEVICE_ID_TIGON3_5702FE,
> 			PCI_DEVICE_ID_TIGON3_5702X,
> 			PCI_DEVICE_ID_TIGON3_5703X,
> 			PCI_DEVICE_ID_TIGON3_5704S,
> 			PCI_DEVICE_ID_TIGON3_5702A3,
> 			PCI_DEVICE_ID_TIGON3_5703A3,
> 		},
> 		.subvendor	= PCI_ANY_ID,
> 		.subdevice	= PCI_ANY_ID

[snip]

That's not a bad idea.  Is there a way the structures could be filled so 
that code comes in at boot time and fills structures out?

Or even better, could there be an array of devices for each vendor, and 
the single vendor structure points to that list?


struct devicelist BROADCOM_devs[] {
	PCI_DEVICE_ID_TIGON3_5700,
	PCI_DEVICE_ID_TIGON3_5701,
	PCI_DEVICE_ID_TIGON3_5702,
	PCI_DEVICE_ID_TIGON3_5703,
	PCI_DEVICE_ID_TIGON3_5704,
	PCI_DEVICE_ID_TIGON3_5702FE,
	PCI_DEVICE_ID_TIGON3_5702X,
	PCI_DEVICE_ID_TIGON3_5703X,
	PCI_DEVICE_ID_TIGON3_5704S,
	PCI_DEVICE_ID_TIGON3_5702A3,
	PCI_DEVICE_ID_TIGON3_5703A3,
	LIST_TERMINATOR};

struct pci_table VENCOR_list[] {
	.vendor		= PCI_VENDOR_ID_BROADCOM,
	.devices	= &BROADCOM_devs,
	.subvendor 	= PCI_ANY_ID
	..........

};


