Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTLKLxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 06:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTLKLxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 06:53:54 -0500
Received: from holomorphy.com ([199.26.172.102]:20197 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264899AbTLKLxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 06:53:52 -0500
Date: Thu, 11 Dec 2003 03:52:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031211115222.GC8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Anton Blanchard <anton@samba.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Mark Wong <markw@osdl.org>
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD8317B.4060207@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 07:57:31PM +1100, Nick Piggin wrote:
> OK, it is spinning on .text.lock.futex. The following results are
> top 10 profiles from a 120 rooms run and a 150 rooms run. The 150
> room run managed only 24.8% the throughput of the 120 room run.
> Might this be a JVM problem?
> I'm using Sun Java HotSpot(TM) Server VM (build 1.4.2_01-b06, mixed mode)
>            ROOMS          120             150
> PROFILES
> total                   100.0%          100.0%
> default_idle             81.0%           66.8%
> .text.lock.rwsem          4.6%            1.3%
> schedule                  1.9%            1.4%
> .text.lock.futex          1.5%           19.1%
> __wake_up                 1.1%            1.3%
> futex_wait                0.7%            2.8%
> futex_wake                0.7%            0.5%
> .text.lock.dev            0.6%            0.2%
> rwsem_down_read_failed    0.5%
> unqueue_me                                3.2%

If this thing is heavily threaded, it could be mm->page_table_lock.

-- wli
