Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUBBKHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 05:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUBBKHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 05:07:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17077 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263571AbUBBKHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 05:07:44 -0500
Date: Mon, 2 Feb 2004 11:08:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 1/4] 2.6.2-rc2-mm2 CPU Hotplug: cpu_active_map
Message-ID: <20040202100827.GA28870@elte.hu>
References: <20040131141937.EB2752C086@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131141937.EB2752C086@lists.samba.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> D: When CPUs are going down, there is a time when cpu_online(cpu) is
> D: false, but they are still scheduling and responding to interrupts
> D: (we are migrating things off the CPU, shutting down per-cpu
> D: threads, etc).  It turns out that RCU cares about these CPUs, so
> D: the decision was made to expose this mask (previously internal to x86,
> D: and only used for IPIs).

these kinds of problems could be avoided by making the CPU-off as much
of an atomic operation as possible. The less atomic it is, the more
kernel code is exposed to the transitional state - and since this is a
rare situation it will always have quality problems. Is there any killer
argument that makes it impossible to down a CPU atomically? Kernel
threads can get their callbacks on other CPUs just fine. Other tasks
should not care. If the migrate-off operation is done 100% atomically
then zero knowledge is needed by unrelated scheduler code about the act
of disabling a CPU.

	Ingo
