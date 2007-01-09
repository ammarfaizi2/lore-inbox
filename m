Return-Path: <linux-kernel-owner+w=401wt.eu-S1751153AbXAII1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXAII1U (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 03:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAII1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 03:27:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:53547 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXAII1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 03:27:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EvdBJdkzdkx4/BUgH9qibJIfNQXRLBZqlDhgp7vhpMFVKe1SMv1w+k60/GqZvC+Xr3+ku8WNGt8HgCsL+NS6FrWwQHLIzZ2MpniuTb8icFS40khzdFnRPY/Ibn1dbY8HBEaeRxwXjfIAo62IZNEsmpJqG9qhXnBLZdZRyCmI9Vg=
Message-ID: <4df04b840701090027l41fb777chcda084d1426c951a@mail.gmail.com>
Date: Tue, 9 Jan 2007 16:27:18 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Cc: pavel@ucw.cz, rdunlap@xenotime.net, akpm@osdl.org
In-Reply-To: <000a01c7311e$ca8c4a00$ec10480a@IBMF0038A435B7>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <000a01c7311e$ca8c4a00$ec10480a@IBMF0038A435B7>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe, there should be a memory maintainer in linux kernel group.

Here, I show some content from my patch (Documentation/vm_pps.txt). In brief, I
make a revolution about Linux swap subsystem, the idea is described that
SwapDaemon should scan and reclaim pages on UserSpace::vmalist other than
current zone::active/inactive. The change will conspicuously enhance swap
subsystem performance by

1) SwapDaemon can collect the statistic of process acessing pages and by it
   unmaps ptes, SMP specially benefits from it for we can use flush_tlb_range
   to unmap ptes batchly rather than frequently TLB IPI interrupt per a page in
   current Linux legacy swap subsystem. In fact, in some cases, we can even
   flush TLB without sending IPI.
2) Page-fault can issue better readahead requests since history data shows all
   related pages have conglomerating affinity. In contrast, Linux page-fault
   readaheads the pages relative to the SwapSpace position of current
   page-fault page.
3) It's conformable to POSIX madvise API family.
