Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbTLHODt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265430AbTLHODt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:03:49 -0500
Received: from holomorphy.com ([199.26.172.102]:21211 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265429AbTLHODr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:03:47 -0500
Date: Mon, 8 Dec 2003 06:03:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-ID: <20031208140346.GH8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031204200120.GL19856@holomorphy.com> <20031208135737.GG8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208135737.GG8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 12:01:20PM -0800, William Lee Irwin III wrote:
>> Successfully tested on a Thinkpad T21. Any feedback regarding
>> performance would be very helpful. Desktop users should notice top(1)
>> is faster, kernel hackers that kernel compiles are faster, and highmem
>> users should see much less per-process lowmem overhead.

On Mon, Dec 08, 2003 at 05:57:37AM -0800, William Lee Irwin III wrote:
> Woops, I missed the target by a few bytes. Probably a bit overwrought:

These THREAD_SIZE bits are cropping up all over.


-- wli

--- wli-2.6.0-test11-37/arch/i386/kernel/traps.c	2003-11-26 12:43:09.000000000 -0800
+++ wli-2.6.0-test11-38/arch/i386/kernel/traps.c	2003-12-08 04:58:08.000000000 -0800
@@ -119,7 +119,7 @@ void show_trace_task(struct task_struct 
 	unsigned long esp = tsk->thread.esp;
 
 	/* User space on another CPU? */
-	if ((esp ^ (unsigned long)tsk->thread_info) & (PAGE_MASK<<1))
+	if ((esp ^ (unsigned long)tsk->thread_info) & ~(THREAD_SIZE - 1))
 		return;
 	show_trace(tsk, (unsigned long *)esp);
 }
