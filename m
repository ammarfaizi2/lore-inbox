Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVLDIQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVLDIQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 03:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLDIQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 03:16:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbVLDIQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 03:16:16 -0500
Date: Sun, 4 Dec 2005 00:15:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, Simon.Derr@bull.net
Subject: Re: How do I remove a patch buried in your *-mm series?
Message-Id: <20051204001525.2889f924.akpm@osdl.org>
In-Reply-To: <20051203234900.fcaa6caf.pj@sgi.com>
References: <20051203234900.fcaa6caf.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> I want to remove the patch in *-mm:
> 
>   1) cpuset-change-marker-for-relative-numbering.patch
> 
> Unfortunately, it collides with another couple cpuset patches later in
> your stack:
> 
>   2) cpuset-memory-pressure-meter.patch, cpuset-memory-pressure-meter-gcc-295-fix.patch
> 
> How should I do this so I minimize the amount of cussing you do in my
> general direction:
> 
>   A. Just ask you to nuke patch (1) above; let you edit the mess.
>   B. Ask you to nuke both (1) and (2); leave me to resend a (2) that applies.
>   C. Send a reversing patch that applies on top of your current *-mm stack.
>   D. Some other plan you would prefer.

    E.  You send a _minimal_ patch against lastest mm, telling me
       "this fixes a bug in
       cpuset-change-marker-for-relative-numbering.patch".  Then I insert
       it into the series with name
       cpuset-change-marker-for-relative-numbering-fix.patch and it gets
       folded into cpuset-change-marker-for-relative-numbering.patch prior
       to going to Linus.

Usually people forget to tell me which patch it fixes, but I work it out.

In this case, dropping cpuset-change-marker-for-relative-numbering.patch
works fine too - it took 20 seconds to fix up the rejects.  Mainly by
simply omitting them, because all this stuff:

***************
*** 191,199 ****
  	.cpus_allowed = CPU_MASK_ALL,
  	.mems_allowed = NODE_MASK_ALL,
  	.marker_pid = 0,
- 	.fmeter.cnt = 0,
- 	.fmeter.val = 0,
- 	.fmeter.time = 0,
  	.count = ATOMIC_INIT(0),
  	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
  	.children = LIST_HEAD_INIT(top_cpuset.children),
--- 191,201 ----
  	.cpus_allowed = CPU_MASK_ALL,
  	.mems_allowed = NODE_MASK_ALL,
  	.marker_pid = 0,
+ 	.fmeter = {
+ 		.cnt = 0,
+ 		.val = 0,
+ 		.time = 0,
+ 	},
  	.count = ATOMIC_INIT(0),
  	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
  	.children = LIST_HEAD_INIT(top_cpuset.children),


It just redundant - the compiler does that.

> I have verified that removing all the patches above applies cleanly and
> builds, with just a harmless -74 lines offset on one of the remaining
> cpuset patches.
> 
>   So I recommend B.

Your call.  E is preferred though.
