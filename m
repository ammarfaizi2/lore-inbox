Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269023AbUIQWBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269023AbUIQWBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUIQWBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:01:20 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:58085 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269023AbUIQWAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:00:51 -0400
Date: Sat, 18 Sep 2004 00:00:39 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: Stelian Pop <stelian@popies.net>, Hugh Dickins <hugh@veritas.com>,
       James R Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917220039.GD15426@dualathlon.random>
References: <20040917154834.GA3180@crusoe.alcove-fr> <20040917205011.GA3049@crusoe.dsnet> <20040917212847.GC15426@dualathlon.random> <200409171454.02531.ryan@spitfire.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171454.02531.ryan@spitfire.gotdns.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 02:54:00PM -0700, Ryan Cumming wrote:
> On Friday 17 September 2004 14:28, Andrea Arcangeli wrote:
> > I also wonder if a O(1) algorithm exists to roundup to the next power of
> > two (doesn't come to mind by memory, hmm maybe it's not that easy
> > problem).
> 
> Assuming that the architecture has an O(1) fls() function, this should work 
> for non-zero values:
> 
> inline unsigned int roundup(unsigned int x)
> {
>  return (1 << fls(x));
> }

looks good, hardware helps here ;) really I was trying to do it with
math, not with hardware but sounds like this is the best we can do.

doing it with unsigned long retval and 1UL is probably better.

This is likely a candidate to go in include/linux/kernel.h (maybe under
the name roundup_pow_of_two to avoid misunderstanding with the much more
common PAGE_SIZE roundups)

thanks!
