Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUDNXnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDNXkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:40:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16364
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262065AbUDNXj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:39:28 -0400
Date: Thu, 15 Apr 2004 01:39:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <20040414233931.GU2150@dualathlon.random>
References: <20040414162700.GS2150@dualathlon.random> <Pine.LNX.4.44.0404141836570.3975-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404141836570.3975-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 06:48:40PM +0100, Hugh Dickins wrote:
> This is just your guess at present, isn't it, Andrea?  Any evidence?

the evidence is pretty obvious, the single fact it's painful to remove
the page_table_lock with anonmm around the vma manipulations, and the
little benefit that the vma->page_table_lock provides with anonmm is
quite a tangible measurements, I'm talking about the 256 ways here, any
UP measurements is pretty useless.

Last but not the least, you cannot know if any important app is going to
be hurted with mremap doing copies and invalidating important
optimizations for any application doing similar things that kde is doing
to save memory and speedup startup times (we don't even know yet if kde
itself is going to be hurted), you can take these risks with mainline, I
cannot risk with -aa, and anon-vma provides other minor benefits too
that we already discussed plus the IMHO important scalability point above.

So I don't see why should mainline go with an inferior solution when
I've already sorted out a better one.
