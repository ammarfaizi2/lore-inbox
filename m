Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261667AbTCMAqy>; Wed, 12 Mar 2003 19:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbTCMAqx>; Wed, 12 Mar 2003 19:46:53 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:9222
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261477AbTCMAqu>; Wed, 12 Mar 2003 19:46:50 -0500
Date: Wed, 12 Mar 2003 19:54:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Paul McKenney <Paul.McKenney@us.ibm.com>
cc: David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <linux-kernel-owner@vger.kernel.org>, "" <linux-net@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] (1/8) Eliminate brlock in psnap
In-Reply-To: <OFBF5B58B4.EAFBC682-ON88256CE7.007043E7@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0303121840220.6957-100000@montezuma.mastecende.com>
References: <OFBF5B58B4.EAFBC682-ON88256CE7.007043E7@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Paul McKenney wrote:

> You are saying that we can omit locking because this is
> called only from a module-exit function, and thus protected
> by the module_mutex semaphore?  (I must defer to
> others who have a better handle on modules...)
> 
> If in fact only one module-exit function can be
> executing at a given time, then we should be able to
> use the following approach:

Yes the ->exit call is protected by module_mutex globally.
 
> Module unloading should be rare enough to tolerate
> the grace period under the module_mutex, right?
> 
> Thoughts?

I would agree. However can't unregister_snap_client be used in other paths 
apart from module_unload? I wouldn't worry too much since if 
register_snap_client and unregister_snap_client for the same protocol 
races it's a bug in the caller's code. The safe RCU list removal and 
synchronize_kernel should protect us from sane usage.

	Zwane
