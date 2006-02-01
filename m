Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423013AbWBAXL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423013AbWBAXL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423015AbWBAXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:11:56 -0500
Received: from amdext3.amd.com ([139.95.251.6]:12734 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1423013AbWBAXLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:11:55 -0500
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Wed, 1 Feb 2006 16:13:40 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
Subject: [PCI] Optional pre-fetchable memory registers
Message-ID: <20060201231340.GA4996@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Feb 2006 23:11:17.0123 (UTC)
 FILETIME=[CDF59D30:01C62784]
X-WSS-ID: 6FFF9F9F1F44348272-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been going back and forth with one of my BIOS guys for a while, 
and I need some clarity on a decision in the PCI probe code...

According to the PCI-to-PCI bridge spec (v1.1), the prefetchable memory base
register and prefetchable memory limit registers are optional, and if
the bridge does not implement a prefetchable memory address range, then the
registers must be implemented as read-only registers which return zero
when read [1].

So, as far as I can tell, drivers/pci/probe.c:312 assumes if
base <= limit (which it would, if both returned zero), then it will go 
ahead and set up the region (line 313-315), which
would cause pcibios_allocate_bus_resources in i386.c to allocate the region, 
and print a nice little error message when base turned out to be zero.  
Now, the end result is the same (area disabled), but it would seem that 
we could avoid any grief at all by assuming that 0x0 for base on 
probe.c:312 means that the prefetchable region doesn't exist.

Or am I barking up the wrong tree?

Regards,
Jordan

[1] Section 3.2.5.9

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

