Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVIJDUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVIJDUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 23:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVIJDUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 23:20:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61928 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751012AbVIJDUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 23:20:44 -0400
Date: Fri, 9 Sep 2005 20:20:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Chris Wright <chrisw@osdl.org>
Cc: chrisw@osdl.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org
Subject: Re: [PATCH 2.6.13-stable] cpuset semaphore double trip fix
Message-Id: <20050909202030.541049a7.pj@sgi.com>
In-Reply-To: <20050910030127.GE7762@shell0.pdx.osdl.net>
References: <20050910004403.29717.51121.sendpatchset@jackhammer.engr.sgi.com>
	<20050910030127.GE7762@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris wrote:
> Another 'by inspection' patch, perhaps we'll need to update the stable
> rules, since these can be quite valid fixes, yet typically trigger
> review replies asking if it's necessary for -stable.

I'm scratching my head here, trying to figure out what is the
bottom line of this comment.

I'm guessing you're saying:

	"By inspection" patches, unless they have something further
	to recommend their inclusion, are not candidates for -stable.

But intent of your phrase "yet typically trigger review replies ..."
went right past me ...


> How unlikely?  So unlikely that it's more a theoreitical race, or did
> you find ways to trigger? 

I don't have a way to trigger it.  My guess is that someday, some
customer will find the right combination of calls, and be able to
trigger this once every few hours or days.  The odds are quite good
that 2.6.13.* will live out its life before that happens.  When it
happens, it will be a customer doing some serious cpuset manipulations
on serious big iron.


> Is this one well-tested, since the fix diverges from upstream?

Yes - I have a stress test, and some custom kernel tracing, that
could see the conditions needed to trigger this occurring, just not
all simultaneously in the necessary small window of vulnerability.


> And one minor nit, let's just do a real forward declaration of
> refresh_mems() instead of local to check_for_release().

Normally, yes.  In this case, I was coding to keep the patch as
localized as possible, and less to optimize the resulting organization
of the kernel/cpuset.c source file after the patch was applied.

Given that this patch is unlikely to ever have a life beyond a briefly
discussed patch today, I guessed right ;)  Coding for clarity of the
patch, not of the source, was arguably the right choice this time.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
