Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUHZC71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUHZC71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 22:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUHZC70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 22:59:26 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:34784 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S266798AbUHZC7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 22:59:25 -0400
Subject: Re: 2.6.8.1-mm4 - more cpu hotplug breakage
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <1093475339.7056.6.camel@pants.austin.ibm.com>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <1093299523.5284.70.camel@pants.austin.ibm.com>
	 <1093475339.7056.6.camel@pants.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1093488887.13514.2363.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 12:54:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 09:09, Nathan Lynch wrote:
> My apologies if this is getting annoying, but it occurred to me that any
> user of stop_machine_run is broken similarly... which means that
> unloading a module will also hang your machine.  I have verified this on
> 2.6.8.1-mm4 on ppc64.

My apologies for not responding earlier.

I've been chasing this, and I realized that both my previous patch and
the one in -mm4 are broken.  They fix the case where we release_task
ourselves, then a CPU goes down, but not the case where our parent
release_tasks us and the CPU goes down.

The correct fix is for the hotplug CPU code to scan the dead CPU's
runqueue as well, and migrate those.

I'll patch soon,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

