Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTIAPxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTIAPxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:53:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55967
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262980AbTIAPx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:53:28 -0400
Date: Mon, 1 Sep 2003 17:54:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
Message-ID: <20030901155403.GF11503@dualathlon.random>
References: <Pine.LNX.4.44.0308311433410.16240-100000@logos.cnet> <Pine.LNX.4.44.0309010200470.25149-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309010200470.25149-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 02:01:35AM -0400, Rik van Riel wrote:
> On Sun, 31 Aug 2003, Marcelo Tosatti wrote:
> 
> > Suppose you have a big fat hog leaking (lets say, netscape) allocating
> > pages at a slow pace. Now you have a decent well behaved app who is
> > allocating at a fast pace, and gets killed.
> > 
> > The chance the well behaved app gets killed is big, right? 
> 
> Usually syslogd, which receives an error message from the
> network driver the moment memory fills up.
> 
> The near-certain death of syslogd in OOM situations is why
> I wrote the OOM killer in the first place.

that was used to happen with the old vm, now the fariness in the
allocator is better and normally the first task that runs in the oom
condition is the one that's killed, plus after one task-killing no other
tasks are normally killed (in the past the vm wasn't capable of using
the freed ram promptly and it was killing 3/4 tasks in a row, so syslogd
was killed despite the hog already exited). still you're right syslogd
may be very well still killed in theory but that's ok with me.

Andrea
