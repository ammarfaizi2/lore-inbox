Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUCXUBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUCXUBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:01:08 -0500
Received: from holomorphy.com ([207.189.100.168]:17285 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263809AbUCXUBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:01:03 -0500
Date: Wed, 24 Mar 2004 12:00:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040324200054.GJ791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]> <20040321235207.GC3649@dualathlon.random> <1684742704.1079970781@[10.10.2.4]> <20040324061957.GB2065@dualathlon.random> <24560000.1080143798@[10.10.2.4]> <20040324162116.GQ2065@dualathlon.random> <35130000.1080146145@[10.10.2.4]> <20040324170841.GT2065@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324170841.GT2065@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 06:08:41PM +0100, Andrea Arcangeli wrote:
> nitpick, it's not PAE but highmem that makes it worse (even with PAE off).

Please give me a little more credit than that. This is largely over,
but when assessing it, do note:

#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM4G)
typedef u32 pte_addr_t;
#endif

#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM64G)
typedef u64 pte_addr_t;
#endif

#if !defined(CONFIG_HIGHPTE)
typedef pte_t *pte_addr_t;
#endif

Yes, I also realized that in principle, one could have only used
PG_direct if the pagetable fell into the lower 32GB or stuffed the 33rd
bit into PG_arch and so on and so forth wrt. the 33rd bit.

-- wli
