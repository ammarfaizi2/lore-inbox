Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUJTRke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUJTRke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUJTRkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:40:13 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:45320 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267363AbUJTRio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:38:44 -0400
Message-ID: <4176A555.3000400@techsource.com>
Date: Wed, 20 Oct 2004 13:50:13 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@novell.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random> <1095025000.22893.52.camel@krustophenia.net> <20040912220720.GC3049@dualathlon.random> <1095027951.22893.69.camel@krustophenia.net> <20040913061641.GA11276@elte.hu>
In-Reply-To: <20040913061641.GA11276@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

> 
> it is not intended for servers, due to the overhead of redirection. It's
> for realtime workloads and for latency-sensitive audio desktop
> workloads. For servers and normal desktops the current IRQ and softirq
> model is pretty OK.
> 


I commented previously about the preemption allowing the kernel to keep 
more resources busy.  So if you have 6 disk controllers and 4 NICs, the 
preemption can allow the kernel to keep more of them busier at the same 
time, while without preemption, one resource might get starved while 
non-preemptable code is servicing another.

This makes the overhead very much worth it.

Are there test results which demonstrate that this theory doesn't apply 
practically to real-world server loads?

I would expect a very busy server to be helped by this in a noticable 
way, but then I am often short-sighted.  :)

