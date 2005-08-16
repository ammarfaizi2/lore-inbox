Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVHPWMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVHPWMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVHPWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:12:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34280 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751115AbVHPWMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:12:48 -0400
Date: Tue, 16 Aug 2005 17:12:23 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jack Steiner <steiner@sgi.com>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
Message-ID: <20050816221223.GA9991@sgi.com>
References: <1123796188.17269.127.camel@localhost.localdomain> <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org> <1123951810.3187.20.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org> <1123953924.3187.22.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org> <1123957087.3187.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123957087.3187.31.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2005 at 08:18:07PM +0200, Arjan van de Ven wrote:
| On Sat, 2005-08-13 at 10:37 -0700, Linus Torvalds wrote:
| > Actually, the more I looked at that mmap_kmem() function, the less I liked 
| > it.  Let's get that sucker fixed better first. It's still not wonderful, 
| > but at least now it tries to verify the whole _range_ of the mapping.
| 
| actually if that is your goal this just isn't enough... assume the
| situation of a 1 page "forbidden gap", if you mmap 3 pages with the gap
| in the middle.... then the code you send still doesn't cope. At which
| point... it gets messy...

mmap_mem suffers from a lack of proper checks as well.  For example, on
Altix page 0 of each node is reserved for prom and a read or write to it
will cause an MCA.  mmaping /dev/mem with offset 0 will nicely explode.
Would adding a pfn_valid test in mmap_mem be the best bet, or could we
consolidate the checks currently in mmap_kmem into mmap_mem?

Greg
