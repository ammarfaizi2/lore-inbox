Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbTF2CEH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 22:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTF2CEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 22:04:07 -0400
Received: from holomorphy.com ([66.224.33.161]:18843 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265512AbTF2CEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 22:04:04 -0400
Date: Sat, 28 Jun 2003 19:18:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030629021809.GA26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030627202130.066c183b.akpm@digeo.com> <20030628155436.GY20413@holomorphy.com> <20030628170837.A10514@infradead.org> <56960000.1056846845@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56960000.1056846845@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 05:34:05PM -0700, Martin J. Bligh wrote:
> Last time I measured it, it had about a 10% overhead in kernel time.
> Seems like a good thing to keep as an option to me. Bill said he
> had some other code to alleviate the overhead, but I don't think
> it's merged ... I'd rather see UKVA (permanently map the pagetables
> on a per-process basis) merged before it becomes "not an option" -
> that gets rid of all the kmapping.

There are several orthogonal things going on here. One is dropping the
hooks in the right places to get various concrete tasks done. Another
is general resource scalability vs. raw overhead tradeoffs. The last
one is gathering a wide enough repertoire of core hooks that arches can
use "advanced" techniques like recursive pagetables when they require
various kinds of intervention by the kernel to use.

This is just another set of hooks we'll need for our end goal, with a
fully functional implementation. It has direct applications and is
completely usable now for resource scalability albeit with some
overhead. Things are all headed in the appropriate directions; the
hooks do not conflict with and do not require any core modifications
whatsoever in order to use in combination with recursive pagetables;
they can simply recover information from already-available places and
transparently replace the highpmd and highpte arch code.

I can work directly with Dave to arrange a proper demonstration of this
(i.e. fully functional implementation) if need be. I've largely avoided
interceding in recursive pagetable mechanics in order not to duplicate
work.


-- wli
