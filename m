Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265949AbTGBXsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbTGBXsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:48:50 -0400
Received: from holomorphy.com ([66.224.33.161]:52922 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265949AbTGBXsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:48:42 -0400
Date: Wed, 2 Jul 2003 17:02:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, haveblue@us.ibm.com
Subject: Re: Overhead of highpte
Message-ID: <20030703000259.GL26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>, haveblue@us.ibm.com
References: <574790000.1057186404@flay> <20030702231502.GJ26348@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702231502.GJ26348@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 03:53:24PM -0700, Martin J. Bligh wrote:
>> Some people were saying they couldn't see an overhead with highpte.
>> Seems pretty obvious to me still. It should help *more* on the NUMA
>> box, as PTEs become node-local.
>> The kmap_atomic is, of course, perfectly understandable. The increase
>> in the rmap functions is a bit of a mystery to me.

On Wed, Jul 02, 2003 at 04:15:02PM -0700, William Lee Irwin III wrote:
> The rmap functions perform kmap_atomic() internally while traversing
> pte_chains and so will take various additional TLB misses and incur
> various bits of computational expense with i386's kmap_atomic() semantics.
> The observations I made were in combination with both highpmd and an as
> of yet unmerged full 3-level pagetable cacheing patch.

Actually they were made with something approaching 0.5MB of diff vs.
the core VM and i386 arch code, so it isn't in the least bit remotely
likely to resemble any results on mainline.

Now, OTOH, my test was done on the same tree with different .config
settings, so it wasn't completely useless.


-- wli
