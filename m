Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUEGJpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUEGJpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUEGJpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:45:46 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:7403 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263348AbUEGJpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 05:45:41 -0400
From: "Sourav Sen" <souravs@india.hp.com>
To: "'Greg KH'" <greg@kroah.com>, "'Sourav Sen'" <souravs@india.hp.com>
Cc: <Matt_Domsch@dell.com>, <matthew.e.tolentino@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
Date: Fri, 7 May 2004 15:15:30 +0530
Message-ID: <006901c43418$095436f0$39624c0f@india.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20040506164040.GA15371@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

+ -----Original Message-----
+ From: Greg KH [mailto:greg@kroah.com]
+ Sent: Thursday, May 06, 2004 10:11 PM
+ To: Sourav Sen
+ Cc: Matt_Domsch@dell.com; matthew.e.tolentino@intel.com;
+ linux-ia64@vger.kernel.org; linux-kernel@vger.kernel.org
+ Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
+
+
+ On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
+ >
+ > The following simple patch creates a read-only file
+ > "memmap" under <mount point>/firmware/efi/ in sysfs
+ > and exposes the efi memory map thru it.
+
+ No, data in this kind of format does not belong in sysfs.

	Please tell me more. In Documentation/filesystems/sysfs.txt
I get:

"Attributes should be ASCII text files, preferably with only one value
per file. It is noted that it may not be efficient to contain only
value per file, so it is socially acceptable to express an array of
values of the same type."

Here we have "Array of values of same types". And it does not do much
nifty formatting either. Is that not acceptable?

If that is not, how about the following.

	1. Create a directory "memmap" under firmware/efi/
	2. Create files "map_start", "map_size" and "mapdesc_size" under
         that exposing ia64_boot_param->efi_memmap,
ia64_boot_param->efi_memmap_size
	   and ia64_boot_param->efi_memdesc_size respectively.

Userland can make meaning out of them by knowing the values and knowing
about
"efi_memory_desc_t" which is already there in /usr/include/asm/efi.h


Thanks
Sourav

PS: BTW, Your slides on "Dealing with the Linux Kernel Community" at:
http://www.kroah.com/linux/talks/cgl_talk_2002_10_16/mgp00001.html
is kind of useful to me. This is my first time :-)


