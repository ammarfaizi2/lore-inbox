Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269401AbUIIKWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269401AbUIIKWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUIIKWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:22:49 -0400
Received: from ozlabs.org ([203.10.76.45]:61623 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269401AbUIIKWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:22:47 -0400
Subject: Re: [patch 2/2] cpu hotplug notifier for updating sched domains
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <413E6C49.5080106@cyberone.com.au>
References: <200409071849.i87Inw3f143238@austin.ibm.com>
	 <413E55D8.8030608@cyberone.com.au> <1094608996.8015.5.camel@booger>
	 <413E6C49.5080106@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1094725124.25639.18.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 20:18:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 12:19, Nick Piggin wrote:
> Nathan Lynch wrote:
> >Well, we have to "lie" to arch_init_sched_domains a little bit when
> >bringing a cpu online, by setting the soon-to-be-online cpu's bit in the
> >argument mask.  So I think the first patch is still necessary.

I'm still a little surprised that you don't change the domains while the
machine is frozen (ie in take_cpu_down()).  This should avoid any races,
since noone can be looking at the domains at this time.

> Do you have a theoretical race here? Can we hotplug a CPU before the notifier
> is registered? (I know we *can't* because it is still earlyish boot).

No, init has so many serial assumptions that this is the least of our
worries.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

