Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUJJF2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUJJF2n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 01:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUJJF2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 01:28:43 -0400
Received: from fmr06.intel.com ([134.134.136.7]:9941 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268128AbUJJF2l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 01:28:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: promise controller resource alloc problems with ~2.6.8
Date: Sun, 10 Oct 2004 13:28:08 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305754575A3@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: promise controller resource alloc problems with ~2.6.8
Thread-Index: AcSnoarcsKEgDf6sT/yY/iPI6C0eegG52PYw
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "CaT" <cat@zip.com.au>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
X-OriginalArrivalTime: 10 Oct 2004 05:28:09.0772 (UTC) FILETIME=[EDDE06C0:01C4AE89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Sep 30, 2004 at 04:56:21PM -0700, Linus Torvalds wrote:
>> Now, the reason for using "insert_resource()" in arch/i386/pci/i386.c
>> should go away with Shaohua Li's patch, so I'd love to hear if
applying
>> Li's patch _and_ making the "insert_resource()" be a
"request_resource()"
>> fixes the problem for you.
>
>You meant this, right?
>
>if (!pr || insert_resource(pr, r) < 0)
>	printk(KERN_ERR "PCI: Cannot allocate resource region %d of
bridge
 
^^^^^^^^^
>%s\n", idx, pci_name(dev));
I go through the thread again and I guess you changed the wrong place. 
in line 114:
				if (!pr || request_resource(pr, r) < 0)
					printk(KERN_ERR "PCI: Cannot
allocate resource region %d of bridge %s\n", idx, pci_name(dev));

In line 145:
		if (!pr || insert_resource(pr, r) < 0) {
					printk(KERN_ERR "PCI: Cannot
allocate resource region %d of device %s\n", idx, pci_name(dev));
Please don't touch line 114, and change 'insert_resource' to '
request_resource' in line 145. Sorry for my bad mail client.

Thanks,
Shaohua
