Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUDFEnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 00:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUDFEnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 00:43:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:42409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263325AbUDFEnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 00:43:47 -0400
Date: Mon, 5 Apr 2004 21:43:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hch@infradead.org, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040405214330.05e4ecd7.akpm@osdl.org>
In-Reply-To: <20040406042222.GP2234@dualathlon.random>
References: <20040402195927.A6659@infradead.org>
	<20040402192941.GP21341@dualathlon.random>
	<20040402205410.A7194@infradead.org>
	<20040402203514.GR21341@dualathlon.random>
	<20040403094058.A13091@infradead.org>
	<20040403152026.GE2307@dualathlon.random>
	<20040403155958.GF2307@dualathlon.random>
	<20040403170258.GH2307@dualathlon.random>
	<20040405105912.A3896@infradead.org>
	<20040405131113.A5094@infradead.org>
	<20040406042222.GP2234@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Then there's the pagebuf_associate_memory that rings
>  an extremely *loud* bell, pagebuf_get_no_daddr and XBUF_SET_PTR sounds
>  even more, then I go on with xlog_get_bp and tons of other things doing
>  pagebuf I/O with kmalloced memory with variable size of the kmalloc. Too
>  many concidences for this not being an xfs bug.

It does pagebuf I/O with kmalloced memory?  Wow.  Pretty much anything
which goes from kmalloc virtual addresses back to pageframes is a big fat
warning sign.

Do you see any reason why we shouldn't flip things around and make the
hugetlb code explicitly request the compound page metadata when allocating
the pages?
