Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752280AbWKGTZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbWKGTZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbWKGTZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:25:16 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:31839 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1752190AbWKGTZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:25:13 -0500
X-IronPort-AV: i="4.09,397,1157353200"; 
   d="scan'208"; a="755234781:sNHT47996868"
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page mode
X-Message-Flag: Warning: May contain useful information
References: <200611052141.29030.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 07 Nov 2006 11:25:12 -0800
In-Reply-To: <200611052141.29030.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's message of "Sun, 5 Nov 2006 21:41:28 +0100")
Message-ID: <aday7qngiuf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Nov 2006 19:25:12.0332 (UTC) FILETIME=[71F704C0:01C702A2]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > -	*mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
 > +	*mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
 > +		(physaddr & (~PAGE_MASK));

I'm confused -- shouldn't ioremap() do the right thing even if
physaddr isn't page-aligned?  Why is this needed?

 - R.
