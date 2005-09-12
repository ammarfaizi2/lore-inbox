Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVILJr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVILJr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVILJr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:47:58 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:55975 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751267AbVILJr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:47:57 -0400
Date: Mon, 12 Sep 2005 02:47:47 -0700
From: Paul Jackson <pj@sgi.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: torvalds@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check deadlock fix
Message-Id: <20050912024747.2ba6d39b.pj@sgi.com>
In-Reply-To: <17186.35554.43089.674075@gargle.gargle.HOWL>
References: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
	<17186.35554.43089.674075@gargle.gargle.HOWL>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita wrote:
> I am somewhat concerned that new fields are added to the struct
> task_struct all the time: it's already over 1.3KB.

A reasonable concern.

In this case, I got sneaky, and lined up a short counter
with a short that was in the previous slot, so probably
didn't actually grow the task struct (until someone adds
something in between ...).

But that's a thin excuse.

I had thought about both having a global cpuset_sem_owner,
and about having the cpuset_sem_depth as a single global
rather than a per task counter.

The owner by itself was insufficient because it didn't track
the depth.  The global owner was insufficient because it wasn't
guarded atomically with the cpuset_sem semaphore.

It never occurred to me to try the combination.  Sweet.

I'll run this through my custom cpuset sausage grinder and
stress test, and see if the computer is equally delighted.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
