Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWA3LNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWA3LNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWA3LNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:13:30 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:19149 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932187AbWA3LN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:13:29 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17373.62673.509668.227840@gargle.gargle.HOWL>
Date: Mon, 30 Jan 2006 14:13:21 +0300
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Nikita Danilov <nikita@clusterfs.com>, Howard Chu <hyc@symas.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
In-Reply-To: <43DDCFD0.1090505@aitel.hist.no>
References: <20060124225919.GC12566@suse.de>
	<20060124232142.GB6174@inferi.kami.home>
	<20060125090240.GA12651@suse.de>
	<20060125121125.GH5465@suse.de>
	<43D78262.2050809@symas.com>
	<43D7BA0F.5010907@nortel.com>
	<43D7C2F0.5020108@symas.com>
	<43D7CAAB.9070008@yahoo.com.au>
	<43D7D234.6060005@symas.com>
	<17368.42664.299094.987071@gargle.gargle.HOWL>
	<43DDCFD0.1090505@aitel.hist.no>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting writes:
 > Nikita Danilov wrote:
 > 
 > >Howard Chu writes:
 > >
 > >[...]
 > >
 > > > 
 > > > A straightforward reading of the language here says the decision happens 
 > > > "when pthread_mutex_unlock() is called" and not at any later time. There 
 > > > is nothing here to support your interpretation.
 > > > >
 > > > > I think the intention of the wording is that for deterministic policies,
 > > > > it is clear that the waiting threads are actually worken and reevaluated
 > > > > for scheduling. In the case of SCHED_OTHER, it means basically nothing,
 > > > > considering the scheduling policy is arbitrary.
 > > > >
 > > > Clearly the point is that one of the waiting threads is waken and gets 
 > > > the mutex, and it doesn't matter which thread is chosen. I.e., whatever 
 > >
 > >Note that this behavior directly leads to "convoy formation": if that
 > >woken thread T0 does not immediately run (e.g., because there are higher
 > >priority threads) but still already owns the mutex, then other running
 > >threads contending for this mutex will block waiting for T0, forming a
 > >convoy.
 > >
 > I just wonder - what is the problem with this convoy formation?
 > It can only happen when the cpu is overloaded, and in that case
 > someone has to wait.  In this case, the mutex waiters. 

The obvious problem is extra context switch: if mutex is left unlocked,
then first thread (say, T0) that tries to acquire it, succeeds and
continues to run, whereas if mutex is directly handed to the runnable
(but not running) thread T1, T0 has to block, until T1 runs.

What's worse, convoys tend to grow once formed.

 > 
 > Aggressively handing the cpu to whoever holds a mutex will mean the
 > mutexes are free more of the time - but it will *not* mean less waiting in
 > tghe system.  You just changes who waits.
 > 
 > Helge Hafting

Nikita.

