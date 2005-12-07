Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVLGXei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVLGXei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbVLGXeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:34:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26604 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750754AbVLGXeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:34:37 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andy Whitcroft <andyw@uk.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1133997772.21841.62.camel@localhost.localdomain>
References: <1133995060.21841.56.camel@localhost.localdomain>
	 <43976AA4.2060606@uk.ibm.com>
	 <1133997772.21841.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 15:34:15 -0800
Message-Id: <1133998455.30387.67.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 15:22 -0800, Badari Pulavarty wrote:
> On Wed, 2005-12-07 at 23:05 +0000, Andy Whitcroft wrote:
> > Badari Pulavarty wrote:
> > > Hi Andy,
> > > 
> > > I getting a panic while doing "cat /proc/<pid>/smaps" on
> > > a process. I debugged a little to find out that faulting
> > > IP is in _nr_to_section() - seems to be getting somehow
> > > called by  pte_offset_map_lock() from smaps_pte_range
> > > (which show_smaps) calls.
> > > 
> > > Any ideas on why or how to debug further ? 
> > 
> > From dave's call graph I'd ask the question whether we should be calling
> > pfn_valid() before pfn_to_page().  When I reviewed the proposed
> > pfn_to_page() implementation I only recall one use and that already had
> > the pfn_valid() in it.  I'll review -rc4 in the morning.
> 
> BTW, the problem seems to be while dealing with shared memory areas
> that are backed by largepages.

Should you even be making it into the pte function with large pages?
Don't they just stop at the pmd level?

Maybe smaps_pmd_range() needs a pmd_huge() check.

-- Dave

