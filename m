Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbUCZAnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUCZAf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:35:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:61325 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263879AbUCZATR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:19:17 -0500
Date: Thu, 25 Mar 2004 16:18:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <33780000.1080260332@flay>
In-Reply-To: <20040325155117.60dbc0e1.akpm@osdl.org>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk><20040325130433.0a61d7ef.akpm@osdl.org><41997489.1080257240@42.150.104.212.access.eclipse.net.uk> <20040325155117.60dbc0e1.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it's simply:
> 
> - Make normal overcommit logic skip hugepages completely
> 
> - Teach the overcommit_memory=2 logic that hugepages are basically
>   "pinned", so subtract them from the arithmetic.
> 
> And that's it.  The hugepages are semantically quite different from normal
> memory (prefaulted, preallocated, unswappable) and we've deliberately
> avoided pretending otherwise.

It would be nice (to fix some of the posted problems) if hugepages didn't
have to be prefaulted ... if they had their own overcommit pool (that we
used whether normal overcommit was on or not), that'd be unnecessary.

Specifically:

1) SGI found that requesting oodles of large pages took forever.
2) NUMA allocation API wants to be able to specify policies, which
means not prefaulting them.

I'd agree that fixing stopping hugepages from using the main overcommit
pool is the first priority, but it'd be nice to go one stage further.

M.

