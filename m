Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUCIR4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbUCIR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:56:12 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51472
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262075AbUCIR4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:56:08 -0500
Date: Tue, 9 Mar 2004 18:56:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309175650.GO8193@dualathlon.random>
References: <20040309114924.GA4581@elte.hu> <Pine.LNX.4.44.0403091220360.7125-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403091220360.7125-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 12:22:07PM -0500, Rik van Riel wrote:
> Andrea may want to try a kd-tree instead of the linked
> lists, that could well fix the problem you're running
> into.

Yep.

Martin's idea of splitting the i_mmap into a multiple lists each
covering a certain range is one of those possibilities to make objrmap
scale.

We've lot of room for improvements.

The basic idea of objrmap vs rmap is that one single object (the vma)
allows us to index tons and tons of ptes, instead of requiring a per-pte
overhead of the pte_chains.

Right now we're not very efficient in finding the "interesting vmas"
especially for file mappings, but we can make that more finegrined over
time. For the anon_vmas work I'm doing that's already quite well
finegriend since it's like if they belong all to different inodes so the
problem is minor there.
