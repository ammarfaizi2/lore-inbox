Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbUCYW1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbUCYW1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:27:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:21920 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263676AbUCYW1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:27:51 -0500
Message-Id: <200403252226.i2PMQZu02326@owlet.beaverton.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3 
In-reply-to: Your message of "Thu, 25 Mar 2004 22:59:08 +0100."
             <20040325215908.GA19313@elte.hu> 
Date: Thu, 25 Mar 2004 14:26:35 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    There's no way the scheduler can figure out the scheduling and memory
    use patterns of the new tasks in advance.

True.  Four threads may want to stay on the same node because they are
sharing a lot of data and working on something in parallel, or they
may want to go to different nodes because the only thing they have in
common is a control structure that directs their (largely independent
but highly synchronized) efforts.

A while ago there was some effort at user-level page replication, which
meant you took a hit once but after that you'd effectively migrated a page
to your local memory.  The longer you stayed put, the more local your
RSS got.  I seem to recall some bugs or caveats, though.  Anybody know
the state of that?  It might take the burden off the scheduler using a
crystal ball and putting it on a 20/20-hindsight VM system instead.

Rick
