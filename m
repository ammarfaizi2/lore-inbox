Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbUEFQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUEFQZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUEFQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:25:51 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:24808 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261184AbUEFQZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:25:47 -0400
From: "Sourav Sen" <souravs@india.hp.com>
To: "HELGAAS,BJORN (HP-Ft. Collins)" <bjorn_helgaas@am.exch.hp.com>,
       "'Sourav Sen'" <souravs@india.hp.com>
Cc: "'Matt Domsch'" <Matt_Domsch@dell.com>, <matthew.e.tolentino@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <tony.luck@intel.com>
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 21:55:35 +0530
Message-ID: <004f01c43386$c3301900$39624c0f@india.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <200405060908.39311.bjorn.helgaas@hp.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+ -----Original Message-----
+ From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
+ Sent: Thursday, May 06, 2004 8:39 PM
+ To: Sourav Sen
+ Cc: 'Matt Domsch'; matthew.e.tolentino@intel.com;
+ linux-ia64@vger.kernel.org; linux-kernel@vger.kernel.org;
+ tony.luck@intel.com
+ Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
+ 
+ 
+ On Thursday 06 May 2004 7:20 am, Sourav Sen wrote:
+ > + 1) Why does userspace / humans need to know this?  For 
+ > + debugging firmware?
+ > 	
+ > 	Maybe. But the point I had in mind is, say for example
+ > memory diagnostics applications/exercisers which reads (Blind
+ > reads, without caring about contents) memory
+ > to uncover errors (single bit errors)  can use
+ > this to know the usable ranges and map them thru /dev/mem and
+ > read those ranges.
+ 
+ For this application, the EFI memory map isn't what you want.
+ It's a pretty good approximation today, but the day when we'll
+ be able to hot-add memory is fast approaching, and the EFI map
+ won't mention anything added after boot.  We'll discover all
+ that via ACPI (on ia64).
+ 

	Why not also update the efi memory table on a hotplug :-)
(Now also it gets modified a little on a call to efi_memmap_walk()).
Otherwise clients of efi_memmap_walk() will also get stale 
information after a hotplug, isn't it (assuming they want to
know about available physical ranges)?

	Also, kernel may not exactly use all the memory added via
hotplug and there may be some truncation (just as efi_memmap_walk()
does today). And it isn't help us if we get to know about those
extents. Additionally we get to know about various mmio ranges and
other ranges thru that table -- may be useful opportunistically.

--Sourav
