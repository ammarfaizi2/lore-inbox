Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTKZWr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTKZWr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:47:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49815 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264356AbTKZWrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:47:25 -0500
Date: Wed, 26 Nov 2003 14:46:49 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126144649.07645fc5.davem@redhat.com>
In-Reply-To: <20031126233918.2af3aae5.ak@suse.de>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<20031126233918.2af3aae5.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 23:39:18 +0100
Andi Kleen <ak@suse.de> wrote:

> You only need to do a fast path for the default scheduler at the beginning.

In the end we're going to have a design and we're going to do it
right, if we decide to do this.

Sun needs fast paths, not us.

> Especially for prefetching having a list of packets helps because you
> can prefetch the next while you're working on the current one. The CPU
> hardware prefetcher cannot do that for you.

The initial prefetches are consumed by the copy implementation
setup instructions.  By the time the real loads execute, the
data is there or not very far away.

This I have measured on UltraSPARC, I suspect other cpus can
match that if not do better.

> I did look seriously at faster csum-copy/copy-to-user for K8, but the conclusion
> was that all the tricks are only worth it when you can work with bigger amounts of data.
> 1.5K at a time is just too small.

Not true, once you have ~300 or so bytes you have enough inertia
to get a good stream going in the main loop, really look at the
ultrasparc-III stuff I wrote for heuristics.

You really should write the k8 code before coming to conclusions
about what it would or would not be capable of doing :)
