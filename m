Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbTGBXD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbTGBXCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:02:13 -0400
Received: from holomorphy.com ([66.224.33.161]:25786 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265552AbTGBXAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:00:46 -0400
Date: Wed, 2 Jul 2003 16:15:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, haveblue@us.ibm.com
Subject: Re: Overhead of highpte
Message-ID: <20030702231502.GJ26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>, haveblue@us.ibm.com
References: <574790000.1057186404@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574790000.1057186404@flay>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 03:53:24PM -0700, Martin J. Bligh wrote:
> Some people were saying they couldn't see an overhead with highpte.
> Seems pretty obvious to me still. It should help *more* on the NUMA
> box, as PTEs become node-local.
> The kmap_atomic is, of course, perfectly understandable. The increase
> in the rmap functions is a bit of a mystery to me.

The rmap functions perform kmap_atomic() internally while traversing
pte_chains and so will take various additional TLB misses and incur
various bits of computational expense with i386's kmap_atomic() semantics.

The observations I made were in combination with both highpmd and an as
of yet unmerged full 3-level pagetable cacheing patch.


-- wli
