Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVCVIIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVCVIIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVCVIIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:08:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36506 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262559AbVCVIIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:08:34 -0500
Date: Tue, 22 Mar 2005 09:08:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, rusty@au1.ibm.com,
       bhuey@lnxw.com, gh@us.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, paulmck@us.ibm.com,
       manfred@colorfullife.com, shemminger@osdl.org, dipankar@in.ibm.com
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050322080800.GA9497@elte.hu>
References: <20050318160229.GC25485@elte.hu> <E1DCPut-0005XI-00@gondolin.me.apana.org.au> <20050319163128.GB28958@elte.hu> <24e1c77a699dcab771a0280df69d44eb@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e1c77a699dcab771a0280df69d44eb@mac.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kyle Moffett <mrmacman_g4@mac.com> wrote:

> One solution I can think of, although it bloats memory usage for
> many-way boxen, is to just have a table in the rwlock with one entry
> per cpu.  Each CPU would get one concurrent reader, others would need
> to sleep

yes, it bloats memory usage, and complicates PI quite significantly. 
We've been there and have done something similar to that in earlier -RT
patches - 64 'owner' entries in the lock already caused problems on 8K
stacks. 32 seemed to work but caused quite some bloat in data structure
sizes.

i'd rather live with some scalability bottleneck for now, in exchange of
a wastly easier to handle design. We can still complicate things later
on for better scalability, once all the other issues have been sorted
out.

	Ingo
