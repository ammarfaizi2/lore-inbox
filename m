Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVBPQSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVBPQSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBPQPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:15:12 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:4028
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262065AbVBPQOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:14:50 -0500
Date: Wed, 16 Feb 2005 08:11:43 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: mgross@linux.intel.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time
 preemption2.6.11-rc2-RT-V0.7.37-03
Message-Id: <20050216081143.50d0a9d6.davem@davemloft.net>
In-Reply-To: <20050216051645.GB15197@elte.hu>
References: <200502141240.14355.mgross@linux.intel.com>
	<200502141429.11587.mgross@linux.intel.com>
	<20050215104153.GB19866@elte.hu>
	<200502151006.44809.mgross@linux.intel.com>
	<20050216051645.GB15197@elte.hu>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005 06:16:45 +0100
Ingo Molnar <mingo@elte.hu> wrote:


> Maybe the networking
> stack would break if we allowed the TIMER softirq (thread) to preempt
> the NET softirq (threads) (and vice versa)?

The major assumption is that softirq's run indivisibly per-cpu.
Otherwise the per-cpu queues of RX and TX packet work would
get corrupted.

See net/core/dev.c:softnet_data
