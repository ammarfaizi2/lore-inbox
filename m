Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUDHUR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUDHT4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:56:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17591
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262518AbUDHTwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:52:41 -0400
Date: Thu, 8 Apr 2004 21:52:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Hugh Dickins <hugh@veritas.com>, mbligh@aracnet.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-ID: <20040408195238.GS31667@dualathlon.random>
References: <1IL3l-1dP-35@gated-at.bofh.it> <1IMik-2is-37@gated-at.bofh.it> <Pine.LNX.4.58.0404081503110.28416@ruby.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404081503110.28416@ruby.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 03:20:22PM -0400, Rajesh Venkatasubramanian wrote:
> 8 extra bytes for prio_tree. If anon_vma is merged, then I can easily
> point my finger at 12 more bytes added by anon_vma and be happy :)

those 12 more bytes payoff providing better swapping performance, handle
mremap transparently and make the code scale better, allowing even to
_trivially_ move the page_table_lock into the vma without any downside
(I mean performance downside, per-vma lock will cost one more bit of
info in every vma).

There's no way to remove those 12 bytes without falling in the downsides
of anonmm.

I don't see a real need to shrink the size of the prio_tree right now
though if something useless and can be removed that's fine with me, what
I'm trying to tell is that pointing the finger at 12 bytes of anon_vma
doesn't sound a good argument since there's no way to remove them
without falling back in the anonmm downsides.
