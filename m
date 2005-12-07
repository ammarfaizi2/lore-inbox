Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVLGXFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVLGXFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbVLGXFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:05:06 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:9107 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751778AbVLGXFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:05:04 -0500
Message-ID: <43976AA4.2060606@uk.ibm.com>
Date: Wed, 07 Dec 2005 23:05:08 +0000
From: Andy Whitcroft <andyw@uk.ibm.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: haveblue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
References: <1133995060.21841.56.camel@localhost.localdomain>
In-Reply-To: <1133995060.21841.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Hi Andy,
> 
> I getting a panic while doing "cat /proc/<pid>/smaps" on
> a process. I debugged a little to find out that faulting
> IP is in _nr_to_section() - seems to be getting somehow
> called by  pte_offset_map_lock() from smaps_pte_range
> (which show_smaps) calls.
> 
> Any ideas on why or how to debug further ? 

>From dave's call graph I'd ask the question whether we should be calling
pfn_valid() before pfn_to_page().  When I reviewed the proposed
pfn_to_page() implementation I only recall one use and that already had
the pfn_valid() in it.  I'll review -rc4 in the morning.

-apw
