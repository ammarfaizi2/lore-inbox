Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWFVOyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWFVOyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWFVOyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:54:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:61613 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751399AbWFVOyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:54:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=GAiW8huuG2NdisbE6fNZQrvZDfEvHMQD3T21nKtJWPFGg0/nWrwYeCvNcnIhj5E7nv/rqluRDPykVZ1KhFdnglZKxs3b6wqkrVnXpnvg+Ui1RNBk+7HmG733wYWJewmcKCPYJ2ai+sliUSw1HoCME+95GKuAQ46qYLg59I++tlI=
Message-ID: <449AB01A.5000608@innova-card.com>
Date: Thu, 22 Jun 2006 16:58:34 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, mel@csn.ul.ie
CC: linux-kernel@vger.kernel.org, Franck <vagabon.xyz@gmail.com>
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org>
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Andrew Morton wrote:
> 
> 
> All 1738 patches:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/patch-list
> 

Is the following patch really needed ?

flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch

"""
The FLATMEM memory model assumes that memory is in one contigious area
based at pfn 0.  If we initialise node 0 to start at any other offset we
will incorrectly map pfn's to the wrong struct page *.  The key to the
memory model is the contigious nature of the memory not the location of it.
Relax the requirement for the area to start at 0.
"""

Should ARCH_PFN_OFFSET macro be used instead in order to make pfn/page
convertions work when node 0 start offset do not start at 0 ?

My physical memory start at 0x20000000. So node 0 starts at an offset
different from 0. I setup ARCH_PFN_OFFSET this way

	#define ARCH_PFN_OFFSET    (0x20000000 << PAGE_SHIFT)

Until now (2.6.17), it works well, but this patch breaks my machine.

If you need more details about my memory mapping, feel free to ask.

Thanks

		Franck
