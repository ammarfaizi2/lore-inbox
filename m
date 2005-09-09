Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVIIWQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVIIWQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030720AbVIIWQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:16:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030453AbVIIWQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:16:31 -0400
Date: Fri, 9 Sep 2005 15:15:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check deadlock fix
In-Reply-To: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0509091512180.3051@g5.osdl.org>
References: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Sep 2005, Paul Jackson wrote:
>
> This patch fixes this deadlock by wrapping the up() and down()
> calls on cpuset_sem in kernel/cpuset.c with code that tracks
> the nesting depth of the current task on that semaphore,

We _really_ don't want to have function names like "cs_up()" and
"cs_down()".

Please either call them something half-way readable, like "cpuset_lock()"  
and "cpuset_unlock()". Yes, it's a local static function, but still.. No 
need to be cryptic about it.

		Linus
