Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTLHTgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTLHTgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:36:50 -0500
Received: from holomorphy.com ([199.26.172.102]:15581 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261965AbTLHTgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:36:48 -0500
Date: Mon, 8 Dec 2003 11:36:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <20031208193643.GN14258@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031117021511.GA5682@averell> <Pine.LNX.4.56.0311231300290.16152@earth> <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth> <20031208175622.GY19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208175622.GY19856@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 09:56:22AM -0800, William Lee Irwin III wrote:
> Furthermore, sched_map_runqueue() is performed after all the idle
> threads are running and all the notifiers have kicked the migration
> threads, but does no locking whatsoever.

Not quite true for migration threads; they're kicked off smp_init(),
called strictly after smp_prepare_cpus(), so all's well with them.
The idle threads shouldn't enter schedule() either, since
start_secondary() spins until smp_init() sets the smp_commenced_mask
bits in cpu_up().

So the important parts of all that were unfortunately all wrong. I'll
look again.


-- wli
