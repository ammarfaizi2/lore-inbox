Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbVJEXjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbVJEXjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbVJEXjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:39:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40577
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030440AbVJEXjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:39:01 -0400
Date: Wed, 05 Oct 2005 16:38:47 -0700 (PDT)
Message-Id: <20051005.163847.73221396.davem@davemloft.net>
To: mel@csn.ul.ie
Cc: linux-mm@kvack.org, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/7] Fragmentation Avoidance V16: 002_usemap
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051005144557.11796.2110.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	<20051005144557.11796.2110.sendpatchset@skynet.csn.ul.ie>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mel@csn.ul.ie>
Date: Wed,  5 Oct 2005 15:45:57 +0100 (IST)

> +	unsigned int type = 0;
 ...
> +	bitidx = pfn_to_bitidx(zone, pfn);
> +	usemap = pfn_to_usemap(zone, pfn);
> +

There seems no strong reason not to use "unsigned long" for "type" and
besides that will provide the required alignment for the bitops
interfaces.  "unsigned int" is not sufficient.

Then we also don't need to thing about "does this work on big-endian
64-bit" and things of that nature.

Please audit your other bitops uses for this issue.

Thanks.
