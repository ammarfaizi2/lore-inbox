Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVBVW0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVBVW0C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVBVW0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:26:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:4320 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261300AbVBVWZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:25:55 -0500
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olof Johansson <olof@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0502221359420.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com>
	 <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org>
	 <1109106969.5412.138.camel@gaston>
	 <Pine.LNX.4.58.0502221330360.2378@ppc970.osdl.org>
	 <1109108532.5411.149.camel@gaston>
	 <Pine.LNX.4.58.0502221359420.2378@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 09:24:56 +1100
Message-Id: <1109111096.5412.152.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 14:10 -0800, Linus Torvalds wrote:

> Oh, well. The reason I hate the rwsem behaviour is exactly because it
> results in this very subtle class of deadlocks. This one case is certainly
> solvable several ways, but do we have other issues somewhere else? Things
> like kobject might be ripe with things like this. The mm semaphore tends
> to be pretty well-behaved - and I'm not sure the same is true of the
> kobject one.

We could detect those tho. When the appropriate DEBUG option is set, by
storing a cpumask in the semaphore we could detect if it's already taken
on this cpu...

> Normal recursive deadlocks are wonderful - most of them show up
> immediately, so assuming you just have enough coverage, you're fine. This
> fairness-related deadlock requires a race to happen.

Unless you consider that taking the read semaphore twice on the same CPU
is always a bug, thus the above stuff would work for catching them at
least more often...
 
> Maybe it would be sufficient to have a debugging version of rwsems that
> just notice recursion?
> 
> 		Linus
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

