Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274285AbRITChR>; Wed, 19 Sep 2001 22:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274229AbRITChL>; Wed, 19 Sep 2001 22:37:11 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:41236 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274285AbRITCgw>; Wed, 19 Sep 2001 22:36:52 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@ufl.edu>
To: safemode <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010920022305Z272886-760+14371@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109192135360.23588-100000@terbidium.openservices.net> 
	<20010920022305Z272886-760+14371@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.07.08 (Preview Release)
Date: 19 Sep 2001 22:38:19 -0400
Message-Id: <1000953501.4349.70.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-09-19 at 22:23, safemode wrote:
> Is it possible to run the 20 worsst latency thing without having the pre-empt
> patch ?  I'd like to see how things run without the preempt patch and which 
> ones are the slowest.   The last time i used the pre-empt patch i had worse 
> audio performance than not.  Perhaps that's because i use alsa. 

No, it requires the preemption patch.  It uses the preemption count code
in figuring out when code returns.  Besides, if you are non-preemption
and UP, you don't have many locking primitives anyhow (no concurrency
concerns there).

You honestly should not have _worse_ latency with the patch.  Even if
something was wrong, it should still be about the same.  However, most
people are reporting a many many times over reduction in latency.

Your point about using ALSA is one of the reasons I am interested in
this patch.  Most of the people reporting high-latencies remaining even
after the patch used ALSA.

If you try preemption again, along with this patch, we can find out what
is causing your problems.

If you just want to gauage how long it takes to execute code from A to B
in the kernel, there are various benchmarking tools as well as Andrew
Morton's excellent timepegs work.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

