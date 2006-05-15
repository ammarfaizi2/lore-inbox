Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWEOXuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWEOXuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWEOXuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:50:23 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:18087 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750821AbWEOXuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:50:22 -0400
X-IronPort-AV: i="4.05,131,1146466800"; 
   d="scan'208"; a="277217853:sNHT2753304328"
To: "Caitlin Bestler" <caitlinb@broadcom.com>
Cc: "Grant Grundler" <iod00d@hp.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org,
       "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [openib-general] Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
X-Message-Flag: Warning: May contain useful information
References: <54AD0F12E08D1541B826BE97C98F99F149F34B@NT-SJCA-0751.brcm.ad.broadcom.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 16:50:11 -0700
In-Reply-To: <54AD0F12E08D1541B826BE97C98F99F149F34B@NT-SJCA-0751.brcm.ad.broadcom.com> (Caitlin Bestler's message of "Mon, 15 May 2006 16:40:35 -0700")
Message-ID: <adabqtyrgp8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 23:50:12.0653 (UTC) FILETIME=[4E9775D0:01C6787A]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Caitlin> True, but how does that constrain the local interfaces by
    Caitlin> which the driver is informed of the set of pages that
    Caitlin> back a given memory region? The driver must still
    Caitlin> ultimately provide dma accessible addresses to the
    Caitlin> device. RDMA just changes the timing of the steps, albeit
    Caitlin> radically, but not what the steps are.

It's only a problem for "reserved L_Key" types of things, where the
device is supposed to just use the address given in a work request
without translating it.  No translation means that work requests have
to contain "bus addresses" -- addresses that are what the device would
put on the bus to access memory.  But if a device needs to simulate
DMA in software, then it really needs a kernel virtual address, not a
bus address.  But it's pretty ugly to have to put that knowledge in
every consumer.

 - R.
