Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUEFSr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUEFSr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUEFSr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:47:58 -0400
Received: from fmr11.intel.com ([192.55.52.31]:62596 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S261865AbUEFSrx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:47:53 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 11:47:38 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEB1B@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.6 PATCH] Exposing EFI memory map
Thread-Index: AcQzjL5FavTXh6V4T3OG07SHslVr6gADPtKQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Dave Hansen" <haveblue@us.ibm.com>, "Sourav Sen" <souravs@india.hp.com>
Cc: "HELGAAS,BJORN (HP-Ft. Collins)" <bjorn_helgaas@am.exch.hp.com>,
       "Matt Domsch" <Matt_Domsch@dell.com>, <linux-ia64@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 06 May 2004 18:47:39.0441 (UTC) FILETIME=[9B29E210:01C4339A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2004-05-06 at 09:25, Sourav Sen wrote:
> > From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
> > + For this application, the EFI memory map isn't what you want.
> > + It's a pretty good approximation today, but the day when we'll
> > + be able to hot-add memory is fast approaching, and the EFI map
> > + won't mention anything added after boot.  We'll discover all
> > + that via ACPI (on ia64).
> >
> > 	Why not also update the efi memory table on a hotplug :-)
> 
> That's actually what ppc64 does.  But, they do it via /proc (not even
> from inside the kernel).  I'm not very fond of that solution :)

Interesting. What does ppc64 do with the memmap after that?  

> >  and there may be some truncation (just as efi_memmap_walk()
> > does today). And it isn't help us if we get to know about those
> > extents. Additionally we get to know about various mmio ranges and
> > other ranges thru that table -- may be useful opportunistically.
> 
> There can be some pretty generic (although asynchronous) events given
> via /sbin/hotplug.  I'm currently planning on having the 
> memory hotplug
> "drivers" get the hot-added memory ready, but keep it 
> offline.  It then
> creates some kobjects, which generate hotplug events, and *then* the
> decision can be made in the hotplug scripts about what to do with it.

So, allocate the page structs which constitute the new memmap, set up
the nonlinear sections, and then wait for hotplug events in order to 
clear the appropriate bits in the pages for a given range?  Is that 
what you're thinking?

matt
