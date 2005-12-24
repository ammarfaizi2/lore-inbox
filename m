Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbVLXBU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbVLXBU7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 20:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbVLXBU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 20:20:58 -0500
Received: from gold.veritas.com ([143.127.12.110]:31920 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1161148AbVLXBU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 20:20:58 -0500
Date: Sat, 24 Dec 2005 01:21:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: torvalds@osdl.org, michael.bishop@APPIQ.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
In-Reply-To: <20051223.154509.86780332.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0512240104440.17764@goblin.wat.veritas.com>
References: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
 <20051223.111940.17674086.davem@davemloft.net> <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
 <20051223.154509.86780332.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Dec 2005 01:20:53.0938 (UTC) FILETIME=[48C76920:01C60828]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2005, David S. Miller wrote:
> 
> So I think something as simple as returning -EINVAL in the SBUS
> framebuffer mmap() driver if VM_SHARED is not set would be sufficient
> to deal with this.

That certainly gets my vote: it should work around the bug correctly
and effectively without adding any complexity.

Though really the check ought to be in the sparc and sparc64
io_remap_pfn_range, which are the guilty parties giving shared write
access even when none has been asked for.  But I guess it's too risky
to add failures or change behaviour down there at this stage.

Those "prot = __pgprot(pg_iobits);" lines - any idea why they ever
got inserted?  I guess to add _PAGE_E in the sparc64 case, and
whatever the equivalent was in the earlier sparc cases?
Can they safely be corrected early in 2.6.16?

Hugh
