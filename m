Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWAZKiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWAZKiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWAZKiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:38:46 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:46297 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932285AbWAZKiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:38:46 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17368.42664.299094.987071@gargle.gargle.HOWL>
Date: Thu, 26 Jan 2006 13:38:32 +0300
To: Howard Chu <hyc@symas.com>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Newsgroups: gmane.linux.kernel
In-Reply-To: <43D7D234.6060005@symas.com>
References: <20060124225919.GC12566@suse.de>
	<20060124232142.GB6174@inferi.kami.home>
	<20060125090240.GA12651@suse.de>
	<20060125121125.GH5465@suse.de>
	<43D78262.2050809@symas.com>
	<43D7BA0F.5010907@nortel.com>
	<43D7C2F0.5020108@symas.com>
	<43D7CAAB.9070008@yahoo.com.au>
	<43D7D234.6060005@symas.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu writes:

[...]

 > 
 > A straightforward reading of the language here says the decision happens 
 > "when pthread_mutex_unlock() is called" and not at any later time. There 
 > is nothing here to support your interpretation.
 > >
 > > I think the intention of the wording is that for deterministic policies,
 > > it is clear that the waiting threads are actually worken and reevaluated
 > > for scheduling. In the case of SCHED_OTHER, it means basically nothing,
 > > considering the scheduling policy is arbitrary.
 > >
 > Clearly the point is that one of the waiting threads is waken and gets 
 > the mutex, and it doesn't matter which thread is chosen. I.e., whatever 

Note that this behavior directly leads to "convoy formation": if that
woken thread T0 does not immediately run (e.g., because there are higher
priority threads) but still already owns the mutex, then other running
threads contending for this mutex will block waiting for T0, forming a
convoy.

 > thread the scheduling policy chooses. The fact that SCHED_OTHER can 
 > choose arbitrarily is immaterial, it still can only choose one of the 
 > waiting threads.

Looks like a good time to submit Defect Report to the Open Group.

 > 
 > The fact that SCHED_OTHER's scheduling behavior is undefined is not free 
 > license to implement whatever you want. Scheduling policies are an 
 > optional feature; the basic thread behavior must still be consistent 
 > even on systems that don't implement scheduling policies.
 > 
 > -- 
 >   -- Howard Chu

Nikita.

