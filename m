Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVILPcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVILPcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVILPcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:32:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53910 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751400AbVILPcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:32:20 -0400
Date: Mon, 12 Sep 2005 08:32:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050912083207.6469db3a.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0509120732060.3242@g5.osdl.org>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<Pine.LNX.4.58.0509120732060.3242@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> and then operate on _that_ level instead. 

As I noted in my reply a few minutes ago, the one unusual rule that
this scheme imposes is that all up's and down's on cpuset_sem must be
done via the wrappers.

So I have continued to strive to have the lock and unlock calls have as
literal substrings "up(&cpuset_sem)" and "down (&cpuset_sem)", such
as with "cpuset_up(&cpuset_sem)" and "cpuset_down(&cpuset_sem)".

This serves as a clear visual reminder of this extra wrapper rule.

The usual "best practices" of:
 1) consistent API's (referring to Nikita's suggestion that these
    routines have "void" arguments instead of "&cpuset_sem"), 
 2) encapsulating related data (your suggestion here), and
 3) [in my inbox] Nikita's cpuset_lock/cpuset_unlock hiding, echoing
    an earlier suggestion of Linus's

are appropriate and desirable mechanisms for building clean abstraction
layers.

I am more of a mind to code this as a thinly veiled hack for use just
within cpuset.c, not another abstraction layer.

I can certainly code this as a proper layer, if you like.  My intuition
is that, in this case, doing so would slightly increase the mental load
on the reader, not decrease it.

In actuality, I don't code for elegance so much as I code to minimize
the time it takes the typical reader to -correctly- understand what's
going on.

But if after all my eloquence of the last hour, Linus, Nikita and
Andrew are all in agreement that cpuset_lock/cpuset_unlock with
struct encapuslation of the 3 data items is preferrable, I'll gladly
code that up.  Well, actually, just a single clear "make it so"
from Linus or Andrew would likely be sufficient.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
