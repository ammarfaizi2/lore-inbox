Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVK0M27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVK0M27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 07:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVK0M27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 07:28:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57021 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751020AbVK0M27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 07:28:59 -0500
Date: Sun, 27 Nov 2005 13:28:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn,
       levon@movementarian.org
Subject: Re: [PATCH] Make RCU task_struct safe for oprofile
Message-ID: <20051127122814.GA22692@elte.hu>
References: <20051126210726.GA5277@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126210726.GA5277@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> Applying RCU to the task structure broke oprofile, because 
> free_task_notify() can now be called from softirq.  This means that 
> the task_mortuary lock must be acquired with irq disabled in order to 
> avoid intermittent self-deadlock.  Since irq is now disabled, the 
> critical section within process_task_mortuary() has been restructured 
> to be O(1) in order to maximize scalability and minimize realtime 
> latency degradation.
> 
> Kudos to Wu Fengguang for finding this problem!

thanks, i applied this to the -rt tree.

	Ingo
