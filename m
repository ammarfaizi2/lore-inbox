Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTKIRLS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTKIRLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:11:18 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:48816 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262686AbTKIRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:11:12 -0500
Date: Sun, 09 Nov 2003 09:10:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Davide Libenzi <davidel@xmailserver.org>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Message-ID: <125870000.1068397851@[10.10.2.4]>
In-Reply-To: <200311100307.40127.kernel@kolivas.org>
References: <Pine.LNX.4.44.0311090801130.12198-100000@bigblue.dev.mdolabs.com> <200311100307.40127.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the same vein ... this looks odd:

         * We fend off statistical fluctuations in runqueue lengths by
         * saving the runqueue length during the previous load-balancing
         * operation and using the smaller one the current and saved lengths.
         * If a runqueue is long enough for a longer amount of time then
         * we recognize it and pull tasks from it.
...
        if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
                nr_running = this_rq->nr_running;
        else
                nr_running = this_rq->prev_cpu_load[this_cpu];

It says we uses the smaller of the two in the comment, but then it seems to
use the > of the two in the code? Unless I'm losing it, which is likely ;-)

Later, we do "*imbalance = (max_load - nr_running) / 2;" ... to "fend off 
statistical fluctuations", we want to reduce imbalance, which would mean
a larger nr_running .... so to my mind, it's the comment that's wrong?

M.


