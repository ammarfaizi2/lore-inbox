Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131916AbQKVXGv>; Wed, 22 Nov 2000 18:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131938AbQKVXGl>; Wed, 22 Nov 2000 18:06:41 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:10250 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S131916AbQKVXGZ>;
        Wed, 22 Nov 2000 18:06:25 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for linux-2.4.0-test11/drivers/block 
In-Reply-To: Your message of "Wed, 22 Nov 2000 14:01:36 -0800."
             <200011222201.OAA29131@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 09:36:08 +1100
Message-ID: <3702.974932568@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 14:01:36 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	Just to avoid duplication of effort, I am posting this preliminary
>patch which adds PCI MODULE_DEVICE_TABLE declarations to the three PCI
>drivers in linux-2.4.0-test11/drivers/block.  In response to input from
>Christoph Hellwig, I have reduced my threshhold on using named initializers
>to three entries, although I think that may be going to far, as I would
>really like to keep the number of files that initialize the pci_device_id
>arrays this way low so that changing struct pci_device_id remains feasible.

No need for named initializers.  Always add any new fields in struct
pci_device_id at the end.  It does matter if you use named or unnamed
initializers, the new fields will be zero on all existing declarations.
Introducing new fields in the middle of pci_device_id introduces
version skew problems for modutils and all code that reads
modules.pcimap.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
