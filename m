Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSHOCVF>; Wed, 14 Aug 2002 22:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSHOCVF>; Wed, 14 Aug 2002 22:21:05 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:56299 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S316465AbSHOCVE>; Wed, 14 Aug 2002 22:21:04 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'colpatch@us.ibm.com'" <colpatch@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, jgarzik@mandrakesoft.com,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>
Subject: RE: [patch] PCI Cleanup
Date: Wed, 14 Aug 2002 19:24:49 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Matthew Dobson [mailto:colpatch@us.ibm.com] 
> OK... Here's the latest version.  Sorry about that last 
> posting... Stupid line 
> wrapping broke the patch!  :(  This patch also removes the 
> pci_config_(read|write) function pointers.  People shouldn't 
> be using these (I 
> don't think) and should be using the pci_ops structure linked 
> through the 
> pci_dev structure.  These end up calling the same functions that the 
> pci_config_(read|write) pointers refer to anyway.  The only 
> places I can see 
> that these are being used in the kernel are in 
> drivers/acpi/osl.c...  Anyone 
> care to comment on the use there or if it can be changed?  
> I've cc'd the 
> authors of the file...

Hi Matthew,

ACPI needs access to PCI config space, and it doesn't have a struct pci_dev
to pass to access functions. It doesn't look like your patch exposes an
interface that 1) doesn't require a pci_dev and 2) abstracts the PCI config
access method, does it?

Regards -- Andy
