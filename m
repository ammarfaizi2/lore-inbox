Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUIMGPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUIMGPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUIMGPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:15:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9425 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266117AbUIMGPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:15:36 -0400
Date: Mon, 13 Sep 2004 08:16:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040913061641.GA11276@elte.hu>
References: <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random> <1095025000.22893.52.camel@krustophenia.net> <20040912220720.GC3049@dualathlon.random> <1095027951.22893.69.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095027951.22893.69.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
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

> Yes, on a server you would probably disable threading for the disk and
> network IRQs (the VP patch lets you set this via /proc).  This feature
> effectively gives you IPLs on Linux, albeit only two of them. [...]

nono, this has no relation to IPLs. IPLs are a pretty crude hack to
implement exclusion on a very (and too) broad level. IRQ threading is a
way to serialize hardirq contexts into a process context and to make
them schedulable and preemptable. It basically 'flattens out' all the
hardirq nesting (and parallelism) that may happen on a default kernel
and together with softirq 'flattening' it creates a deterministic
execution environment.

it is not intended for servers, due to the overhead of redirection. It's
for realtime workloads and for latency-sensitive audio desktop
workloads. For servers and normal desktops the current IRQ and softirq
model is pretty OK.

	Ingo
