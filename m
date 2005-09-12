Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVILN0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVILN0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVILN0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:26:19 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11186 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750815AbVILN0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:26:18 -0400
Date: Mon, 12 Sep 2005 06:25:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050912062548.4c40395e.pj@sgi.com>
In-Reply-To: <17189.27398.848822.787487@gargle.gargle.HOWL>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<17189.27398.848822.787487@gargle.gargle.HOWL>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita wrote:
> static void cpuset_{down,up}(void);

I started with (void) calls when I first wrote this hack,
then changed it to taking a semaphore pointer, intentionally.

The calls:
	cpuset_down(&cpuset_sem);
	cpuset_up(&cpuset_sem);
exactly replace calls:
	down(&cpuset_sem);
	up(&cpuset_sem);

I wanted that visual resemblance.

I agree, it's asymmetric, which is not so good.

But the resemblance is more valuable, in my view.

So I will stick with what I've got, unless I see stronger
signs of a concensus to the contrary.

Is that ok?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
