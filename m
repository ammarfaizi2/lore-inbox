Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVCaHEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVCaHEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVCaHEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:04:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:58501 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262501AbVCaHEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:04:09 -0500
Date: Thu, 31 Mar 2005 09:03:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331070349.GB14952@elte.hu>
References: <1112137487.5386.33.camel@mindpipe> <1112138283.11346.2.camel@lade.trondhjem.org> <1112192778.17365.2.camel@mindpipe> <1112194256.10634.35.camel@lade.trondhjem.org> <20050330115640.0bc38d01.akpm@osdl.org> <1112217299.10771.3.camel@lade.trondhjem.org> <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org> <1112237239.26732.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112237239.26732.8.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > Is a bunch of gobbledygook.  Hows about you interpret it for us?
> 
> Sorry.  When I summarized them before, Ingo just asked for the full 
> verbose trace.

please send non-verbose traces if possible. The verbose traces are 
useful when it's not clear which portion of a really large function is 
the call site - but they are also alot harder to read.  Verbose traces 
are basically just a debugging mechanism for me, not meant for public 
consumption.

i can add back the instruction-'offset' to the non-verbose trace, that 
will make even the ext3 traces easily interpretable in the non-verbose 
format.

> The 7 ms are spent in this loop:
> 
>  radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
>  radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
>  radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
>  radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)
>  radix_tree_tag_clear+0xe/0xd0 <c01e040e> (nfs_scan_lock_dirty+0xb2/0xf0 <c01c3a22>)

the trace shows thousands of pages getting submitted - each of the line 
above is at least one new page. The loop is not preemptible right now 
but that should be easy to bound. Note that your earlier traces showed 
the list sorting overhead for a _single page_. So it's a huge difference 
and a huge step forward.

	Ingo
