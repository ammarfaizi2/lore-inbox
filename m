Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVIMHEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVIMHEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVIMHEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:04:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54485 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932412AbVIMHEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 03:04:14 -0400
Date: Tue, 13 Sep 2005 09:04:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-ID: <20050913070442.GA5629@elte.hu>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com> <20050912043943.5795d8f8.akpm@osdl.org> <Pine.LNX.4.58.0509120732060.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509120732060.3242@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Personally, the thing that makes me think the patch is ugly is the 
> fact that the different parts of the nested semaphore are all 
> separate. I'd prefer to see a
> 
> 	struct nested_semaphore {
> 		struct semaphore sem;
> 		struct task_struct *owner;
> 		unsigned int count;
> 	};
> 
> and then operate on _that_ level instead.

btw., this is how the -rt tree implements (read-)nesting for rwsems and 
rwlocks. The more sharing and embedding of types and primitives, the 
more compact the whole code becomes, and the easier it is to change 
fundamental properties.

	Ingo
