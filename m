Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTLAW7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTLAW7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:59:09 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:2496 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264229AbTLAW7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:59:06 -0500
Date: Mon, 01 Dec 2003 14:57:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>
cc: Jack Steiner <steiner@sgi.com>, jes@trained-monkey.org, viro@math.psu.edu,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <113980000.1070319472@flay>
In-Reply-To: <20031201210601.GC22620@krispykreme>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125130741.108bf57c.akpm@osdl.org> <20031201210601.GC22620@krispykreme>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It would be very nice to have some confirmation that the size of these
>> tables is being appropriately chosen, too.  Maybe we should shrink 'em 32x
>> and see who complains...
> 
> Why dont we just do node round robin allocations during boot? This
> should mean the static boot time hashes would at least end up on
> different nodes.

We could probably implement a generic striped allocate, which would
do a vmalloc or similar on 64 bit, and either the magic boottime
node-alloc hack, or just a straight node 0 alloc on 32 bit (ie use
vmalloc where needed, without crippling other platforms).

Someone had a patch to do round-robin already (Manfred?) - IMHO doing
it from the node with the most free mem each time would be better, if
we're not going to stripe. 
 
> 0 248652
> 1 7374

...

but yes, that does look utterly screwed ;-)

M.

