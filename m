Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUCSBsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCSBsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:48:20 -0500
Received: from palrel13.hp.com ([156.153.255.238]:31157 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261434AbUCSBsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:48:14 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16474.20827.21678.283540@napali.hpl.hp.com>
Date: Thu, 18 Mar 2004 17:48:11 -0800
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [3/3] claim PCI resources on ia64
In-Reply-To: <20040318235250.GK25059@parcelfarce.linux.theplanet.co.uk>
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
	<20040318235250.GK25059@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew tells me that applying this patch without the others will result
in error messages (harmless, but still...).  I'm OK with the patch, so
I'd appreciate it if whoever takes the other patches could apply this
one, too.

Thanks,

-----------------------------------------------------------------------
From: Matthew Wilcox <willy@debian.org>
Sender: <willy@www.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
        Greg KH <greg@kroah.com>, David Mosberger <davidm@hpl.hp.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [3/3] claim PCI resources on ia64
Date: Thu, 18 Mar 2004 23:52:50 +0000


Call pci_claim_resources() so we can see what PCI resources are being used.

Index: arch/ia64/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/pci/pci.c,v
retrieving revision 1.7
diff -u -p -r1.7 pci.c
--- a/arch/ia64/pci/pci.c	16 Mar 2004 15:39:51 -0000	1.7
+++ b/arch/ia64/pci/pci.c	18 Mar 2004 23:40:52 -0000
@@ -367,6 +366,7 @@ pcibios_fixup_device_resources (struct p
 				dev->resource[i].end   += window->offset;
 			}
 		}
+		pci_claim_resource(dev, i);
 	}
 }
 

-- 
