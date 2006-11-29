Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758812AbWK2JkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758812AbWK2JkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758811AbWK2JkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:40:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758809AbWK2JkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:40:14 -0500
Date: Wed, 29 Nov 2006 01:39:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Mingming Cao <cmm@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
Message-Id: <20061129013922.053482f9.akpm@osdl.org>
In-Reply-To: <20061129092023.GA23101@flint.arm.linux.org.uk>
References: <20061114113120.d4c22b02.akpm@osdl.org>
	<Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	<20061115214534.72e6f2e8.akpm@osdl.org>
	<455C0B6F.7000201@us.ibm.com>
	<20061115232228.afaf42f2.akpm@osdl.org>
	<20061116123448.GA28311@flint.arm.linux.org.uk>
	<20061125145915.GB13089@flint.arm.linux.org.uk>
	<20061129074000.GA21352@flint.arm.linux.org.uk>
	<20061129003036.dd27f01e.akpm@osdl.org>
	<20061129092023.GA23101@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 09:20:24 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> What I'm looking for is confirmation of the semantics of
> find_next_zero_bit()

What are the existing semantics?  I see no documentation in any of the
architectures I've looked at.  That's my point.

>From a quick read of fs/ext2/balloc.c

	ext2_find_next_zero_bit(base, size, offset)

appears to expect that base is the start of the memory buffer, size is the
number of bits at *base and offset is the bit at which to start the search,
relative to base.  If a zero bit is found it will return the offset of that
bit relative to base.  It will return some number greater than `size' if no
zero-bit was found.  

Whether that's how all the implementors interpreted it is anyone's guess. 
Presumably the architectures all do roughly the same thing.

> <extremely frustrated>

Well likewise.  It appears that nobody (and about 20 people have
implemented these things) could be bothered getting off ass and documenting
the pathetic thing.

