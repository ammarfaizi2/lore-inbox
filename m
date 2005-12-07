Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbVLGWwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbVLGWwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVLGWwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:52:41 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:6078 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030418AbVLGWwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:52:37 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andy Whitcroft <andyw@uk.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1133995060.21841.56.camel@localhost.localdomain>
References: <1133995060.21841.56.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 14:52:15 -0800
Message-Id: <1133995935.30387.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 14:37 -0800, Badari Pulavarty wrote:
> Hi Andy,
> 
> I getting a panic while doing "cat /proc/<pid>/smaps" on
> a process. I debugged a little to find out that faulting
> IP is in _nr_to_section() - seems to be getting somehow
> called by  pte_offset_map_lock() from smaps_pte_range
> (which show_smaps) calls.
> 
> Any ideas on why or how to debug further ? 

You're sure it's inside of the pte_offset_map_lock()?

It's probably this call chain:

        pte_offset_map_lock()
        pte_offset_map()
        pmd_page()
        pfn_to_page()
        __pfn_to_section()
        __nr_to_section()

I'd probably take a hard look at the PMD first to make sure it looks
good.  Then, maybe go through some of the conversions in
pte_offset_map_lock() from that chain and print out each step inside of
smaps_pte_range().  Can you trigger it easily?

-- Dave

