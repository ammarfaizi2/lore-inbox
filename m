Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUBBMqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUBBMqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:46:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47521 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265479AbUBBMqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:46:11 -0500
Date: Mon, 2 Feb 2004 07:45:32 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
In-Reply-To: <20040202111224.DE5402C26D@lists.samba.org>
Message-ID: <Pine.LNX.4.58.0402020741250.16748@devserv.devel.redhat.com>
References: <20040202111224.DE5402C26D@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Feb 2004, Rusty Russell wrote:

> Unfortunately the __migrate_task() check won't go away: someone may have
> asked to move from CPU 0 to 1, and by the time migration thread on 0
> gets to the request, 1 has gone down.  We don't want all the callers to
> hold the cpucontrol lock, because now the NUMA scheduler uses migration
> as a common case 8(

well, when a CPU goes down it could process the migration request queue as
well. (this would be a pretty natural thing to do if CPU-down executes in
the migration-thread context.)

Another question is user-space semantics - if user-space relies on CPU
affinity, is the kernel allowed to violate it or should the process be
notified. Sending it a signal (SIGTERM or anything similar) if the
affinity was non-generic might be a good thing to do.

	Ingo
