Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbTHaWpr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbTHaWpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:45:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56030
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263029AbTHaWpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:45:44 -0400
Date: Mon, 1 Sep 2003 00:46:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
Message-ID: <20030831224610.GB24409@dualathlon.random>
References: <Pine.LNX.4.44.0308311433410.16240-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308311433410.16240-100000@logos.cnet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 02:34:01PM -0300, Marcelo Tosatti wrote:
> 
> 
> ---------- Forwarded message ----------
> Date: Sun, 31 Aug 2003 12:43:27 -0300 (BRT)
> From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
> To: Andrea Arcangeli <andrea@suse.de>
> Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
>      Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
>      lkml <linux-kernel@vger.kernel.org>,
>      Marc-Christian Petersen <m.c.p@wolk-project.de>
> Subject: Re: Andrea VM changes
> 
> 
> 
> On Sun, 31 Aug 2003, Andrea Arcangeli wrote:
> 
> > This oom killer on desktops may do a worse selections of the task to
> > kill (the usual ssh now has a chance to be killed), but it fixes the oom
> > deadlocks and it won't do stupid things on servers shall a netscape or
> > whatever else app hit an userspace bug. So I've to prefer it, until I
> > will write a reliable algorithm for the oom killing that won't fall into
> > dosable corner cases so easily (mlock/nfs/database as the three most
> > common examples of where current mainline can fail, btw the lowmem
> > shortage is another very common DoS that the oom killer will never
> > notice, my tree doesn't deadlock [or at least not technically, in
> > practice it may look like a kernel deadlock despite syscalls returns
> > -ENOMEM ;) ] during lowmem shortage on the 64G boxes).
> 
> Suppose you have a big fat hog leaking (lets say, netscape) allocating
> pages at a slow pace. Now you have a decent well behaved app who is
> allocating at a fast pace, and gets killed.
> 
> The chance the well behaved app gets killed is big, right? 

correct. But it's not a bad thing. How can you know it's better to kill
the hog instead of the well behaved app? if the the hog is allocating at
slow pace, the admin will simply have to kill it if it grown too big. In
terms of omm-killing an hog allocating at slow peace, is no different
from a malloc(1G);bzero(1G);pause(); that leaves 1k free only.
eventually the hog will be killed too if needed.

Andrea
