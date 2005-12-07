Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbVLGXWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbVLGXWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbVLGXWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:22:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:34739 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751821AbVLGXWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:22:36 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andy Whitcroft <andyw@uk.ibm.com>
Cc: haveblue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43976AA4.2060606@uk.ibm.com>
References: <1133995060.21841.56.camel@localhost.localdomain>
	 <43976AA4.2060606@uk.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 15:22:52 -0800
Message-Id: <1133997772.21841.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 23:05 +0000, Andy Whitcroft wrote:
> Badari Pulavarty wrote:
> > Hi Andy,
> > 
> > I getting a panic while doing "cat /proc/<pid>/smaps" on
> > a process. I debugged a little to find out that faulting
> > IP is in _nr_to_section() - seems to be getting somehow
> > called by  pte_offset_map_lock() from smaps_pte_range
> > (which show_smaps) calls.
> > 
> > Any ideas on why or how to debug further ? 
> 
> From dave's call graph I'd ask the question whether we should be calling
> pfn_valid() before pfn_to_page().  When I reviewed the proposed
> pfn_to_page() implementation I only recall one use and that already had
> the pfn_valid() in it.  I'll review -rc4 in the morning.

BTW, the problem seems to be while dealing with shared memory areas
that are backed by largepages.


db2inst1@elm3b157:~> cat /proc/12030/maps
...
100000000-101598000 rw-s 00000000 00:07
589826                           /SYSV2a079461 (deleted)
...

db2inst1@elm3b157:~> cat /proc/12030/smaps
...
100000000-101598000 rw-s 00000000 00:07 5Segmentation fault


Thanks,
Badari

