Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWBUW3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWBUW3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWBUW3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:29:10 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:42294 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S964865AbWBUW3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:29:09 -0500
Message-ID: <43FB942E.5070309@de.ibm.com>
Date: Tue, 21 Feb 2006 23:29:02 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to allocate per-cpu data for online CPUs only (and safely)?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to optimize the memory footprint of some code of mine.
It's been using per-cpu data and alloc_percpu() so far. The latter has
the disadvantage of getting hold of memory for CPU's which aren't there
(yet).

I could imagine using CPU-hotplug notifications as triggers for
additional allocations or for cleaning up unneeded memory. But
alloc_percpu() appears to conflict with that idea.

I was briefly tempted to derive some code from alloc_percpu() more to my
liking, until I was scared off by this comment in alloc_percpu():

         /*
          * Cannot use for_each_online_cpu since a cpu may come online
          * and we have no way of figuring out how to fix the array
          * that we have allocated then....
          */

Well, and then there is kernel/profile.c, for example, which boldly
ignors alloc_percpu()'s qualms and allocates and releases per-cpu data
as needed.

Is that the way to go?
If so, why alloc_percpu()'s reservations?
Or, does that comment imply that the exploiter isn't expected to take
care of CPU hotplug events?
Am I missing anything?

Thank you.

Martin

