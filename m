Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVGMB5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVGMB5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVGMB5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:57:49 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:63940 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262248AbVGMB5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:57:38 -0400
Message-ID: <42D475D7.2090307@jp.fujitsu.com>
Date: Wed, 13 Jul 2005 11:00:55 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 07/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB6961.2060508@jp.fujitsu.com> <20050712211401.GF26607@austin.ibm.com>
In-Reply-To: <20050712211401.GF26607@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> On Wed, Jul 06, 2005 at 02:17:21PM +0900, Hidetoshi Seto was heard to remark:
> 
>>Touching poisoned data become a MCA, so now it directly means
> 
> Several questions: 
> 
> Is MCA an exception or fault of some sort, so at some point, 
> the kernel would catch a fault?
> 
> So when you say "Touching poisoned data become a MCA", you mean that
> if the CPU attempts to read poisoned data through the pci-to-host
> bridge, it will (at some point) catch an exception?

Yes.
More specifically, transferring poisoned data doesn't cause MCA,
but loading it to CPU register cause MCA. At the end of load,
CPU checks the data and deliver MCA if it was poisoned.

>>+	ia64_mca_barrier(ret);
> 
> I assume that the point of this barrier is to make sure that the fault,
> if any, is delivered before this routine returns?

Yes, that's what I expecting.

Thanks,
H.Seto

