Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTA2WWe>; Wed, 29 Jan 2003 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTA2WWe>; Wed, 29 Jan 2003 17:22:34 -0500
Received: from holomorphy.com ([66.224.33.161]:24751 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262258AbTA2WWd>;
	Wed, 29 Jan 2003 17:22:33 -0500
Date: Wed, 29 Jan 2003 14:28:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernbench: 2.5.59 vs 2.5.59-mm6 vs 2.5.59-mjb2
Message-ID: <20030129222855.GO780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@zip.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <62800000.1043878411@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62800000.1043878411@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 02:13:31PM -0800, Martin J. Bligh wrote:
> not sure what's causing the pfn_to_nid and pgd_alloc improvements?)

pgd's and pmd's are in the slab, so the zeroing hit is only taken once
per pgd and pmd (best case). It's my patch that does this.

pfn_to_nid() is surely a random cache and/or ITLB gain from link
ordering, alignment in the final link, or some such nonsense.
pfn_to_nid() is a single shift, quite excessive for a function call.
It'd be best to inline this and get the random ITLB etc. misses out
of the profiles esp. as they aren't reproducible.

-- wli
