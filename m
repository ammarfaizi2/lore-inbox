Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVJQQRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVJQQRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVJQQRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:17:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751423AbVJQQRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:17:02 -0400
Date: Mon, 17 Oct 2005 09:16:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Dipankar Sarma <dipankar@in.ibm.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <4353CADB.8050709@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Eric Dumazet wrote:
> 
> I would just remove it. If the limit is wrong, we crash again. And the
> realtime guys already are pissed off by batch=10000 anyway.

Normally I would too, but I'm still hoping I could do a 2.6.14 tonight. I 
guess that's unreasonable (swtlb issues etc), but for now I just committed 
the one-liner. 

> Absolutely. Keeping a count of (percpu) queued items is basically free if kept
> in the cache line used by list head, so the 'queue length on this cpu' is a
> cheap metric.

Yes. I did something broken like that before Dipankar pointed me at 
batching.

The only downside to TIF_RCUUPDATE is that those damn TIF-flags are 
per-architecture (probably largely unnecessary, but while most 
architectures don't care at all, others seem to have optimized their 
layout so that they can test the work bits more efficiently). So it's a 
matter of each architecture being updated with its TIF_xyz flag and their 
work function.

Anybody willing to try? Dipankar apparently has a lot on his plate, this 
_should_ be fairly straightforward. Eric?

		Linus
