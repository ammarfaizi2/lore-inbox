Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbTIDI7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTIDI7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:59:41 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34131 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264795AbTIDI7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:59:40 -0400
Date: Thu, 4 Sep 2003 04:59:21 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: linas@austin.ibm.com
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       <davem@redhat.com>, <riel@redhat.com>, <mranweil@us.ibm.com>
Subject: Re: PATCH: kernel-2.4 brlock livelock
In-Reply-To: <20030903151043.B51004@forte.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0309040457560.5452-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Sep 2003 linas@austin.ibm.com wrote:

> OK, how about the following: readers on a given cpu are held off if the
> write lock is held *and* the read-count on that cpu is zero?
> 
> That way, 'recursive' readers on other CPU's can get a read-lock if
> there's already a non-zero read-lock-count on that CPU.
> 
> That should work if the thread holding the lock can't get scheduled to
> another cpu.  Can these things wander around?
> 
> If they can wander around, then oone would have to order the cpus: wait
> for read count to drop to zero on cpu 0 then on 1 then on 2, meanwhile
> the read-lock can be gotten on the higher ordered CPUs ...
> 
> If this sounds reasonable, would you care to see a revised patch?

could you try this approach on your box that shows the livelock situation?

certainly we can add code that only triggers if there's some write attempt
- the important thing is to have the right read-mostly behavior.

	Ingo

