Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTKKPFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTKKPFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:05:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2954
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263541AbTKKPEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:04:42 -0500
Date: Tue, 11 Nov 2003 16:04:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031111150417.GF1649@x30.random>
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com> <3FB091C0.9050009@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB091C0.9050009@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 06:37:36PM +1100, Nick Piggin wrote:
> 
> 
> Davide Libenzi wrote:
> 
> >On Mon, 10 Nov 2003, walt wrote:
> >
> >
> >>Andrea Arcangeli wrote:
> >>
> >>
> >>>>On Mon, 10 Nov 2003, Andrea Arcangeli wrote:
> >>>>
> >>>The best way to fix this isn't to add locking to rsync, but to add two
> >>>files inside or outside the tree, each one is a sequence number, so you
> >>>fetch file1 first, then you rsync and you fetch file2, then you compare
> >>>them. If they're the same, your rsync copy is coherent. It's the same
> >>>locking we introduced with vgettimeofday...
> >>>
> >>How is this different from writing one file named LOCK while updating
> >>the tree?
> >>
> >
> >This is even simpler I believe. If you happen to fetch it, you restart the 
> >rsync. Peter ?
> >(maybe the name LOCK should be replaced by something more "uniq")
> >
> >
> 
> What happens if the the tree is updated while the client is fetching it?

the usual problem, and the reason we need a sequence number (increased
before and after the repo update). A file lock not.
