Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVJQUO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVJQUO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJQUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:14:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751316AbVJQUO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:14:57 -0400
Date: Mon, 17 Oct 2005 13:14:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <4353FDE8.8070909@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
 <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
 <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org>
 <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org>
 <4353FDE8.8070909@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Eric Dumazet wrote:
> 
> What about call_rcu_bh() which I left unchanged ? At least one of my
> production machine cannot live very long unless I have maxbatch = 300, because
> of an insane large tcp route cache (and one of its CPU almost filled by
> softirq NIC processing)

I think we'll have to release 2.6.14 with maxbatch at the high value 
(10000).

Yes, it may screw up some latency stuff, but quite frankly, even with your 
patch and even ignoring the call_rcu_bh case, I'm convinced you can easily 
get into the situation where softirqd just doesn't run soon enough.

But at least I think I understand _why_ rcu processing was delayed.

I think a real fix might have to involve more explicit knowledge of 
tasklet behaviour and softirq interaction.

		Linus
