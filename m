Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbUDGDzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 23:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbUDGDzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 23:55:22 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:38784 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264091AbUDGDzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 23:55:17 -0400
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
	CPU_DEAD handling
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, rusty@au1.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
In-Reply-To: <407277AE.2050403@yahoo.com.au>
References: <20040405121824.GA8497@in.ibm.com>
	 <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com>
	 <407277AE.2050403@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1081310073.5922.86.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 13:54:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 19:26, Nick Piggin wrote:
> Note there was already that check in the wakeup path, although
> I suspect it was someone being overly cautious and isn't required.

No, it really is required.

The stop_machine thread runs on the cpu, then kicks everyone else off,
then does a complete() (in stop_machine.c:do_stop()).  Without this
check, the complete() drags the sleeping process (which called
stop_machine) onto the dying CPU.

Hmm, maybe we could explicitly exclude downed cpu from calling task's
mask.  Kind of hacky: theoretically you should never modify a task's
affinity unless the user actually asked for it (since anyone can ask for
another tasks affinity).

Cheers!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

