Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVLHUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVLHUwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVLHUwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:52:54 -0500
Received: from cantor2.suse.de ([195.135.220.15]:46297 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751098AbVLHUwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:52:53 -0500
Date: Thu, 8 Dec 2005 21:52:41 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 3/3] Zone reclaim V3: Frequency of failed reclaim attempts
Message-ID: <20051208205241.GR11190@wotan.suse.de>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com> <20051208203717.30456.17434.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208203717.30456.17434.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (zone->last_unsuccessful_zone_reclaim == get_jiffies_64())
> +		return 0;


and

>  
> +	unsigned long		last_unsuccessful_zone_reclaim;

For long you don't need get_jiffies_64. On 32bit it would be 32bit
anyways and on 64bit even normal jiffies is 64bit. So normal
jiffies would be suffice.

But I suspect it would be better to just merge the proper patch
with the full accounting instead of this kludge.

-Andi
