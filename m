Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbUCLRFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUCLRFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:05:36 -0500
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:39623 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262332AbUCLRFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:05:31 -0500
Date: Fri, 12 Mar 2004 12:05:27 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
In-Reply-To: <20040310135012.GM30940@dualathlon.random>
Message-ID: <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
References: <20040310080000.GA30940@dualathlon.random>
 <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
 <20040310135012.GM30940@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> have a devastating effect on vma usage, yes) issue of vma merging, but
>> what about the (mandatory) vma splitting? ...[snip]

> you're right about vma_split, the way I implemented it is wrong,
> basically the as.vma/PageDirect idea is falling apart with vma_split.

Why do you have to fix up all page structs' PageDirect and as.vma
fields when a vma_split or vma_merge occurs.

Can't you do it lazily on the next page_referenced or page_add_rmap,
etc. Anyway we can get to the anon_vma using as.vma->anon_vma.

I understand that currenly your code assumes that if PageDirect is
set, then there cannot be an anon_vma corresponding to the page.

Rajesh
