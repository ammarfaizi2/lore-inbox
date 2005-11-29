Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVK2PPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVK2PPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVK2PPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:15:22 -0500
Received: from ns2.suse.de ([195.135.220.15]:45454 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751366AbVK2PPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:15:22 -0500
Date: Tue, 29 Nov 2005 16:15:15 +0100
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: Enabling RDPMC in user space by default
Message-ID: <20051129151515.GG19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I'm considering to enable CR4.PCE by default on x86-64/i386. Currently it's 0
which means RDPMC doesn't work. On x86-64 PMC 0 is always programmed
to be a cycle counter, so it would be useful to be able to access
this for measuring instructions. That's especially useful because RDTSC 
does not necessarily count cycles in the current P state (already
the case on Intel CPUs and AMD's future direction seems to also
to decouple it from cycles) Drawback is that it stops during idle, but 
that shouldn't be a big issue for normal measuring. It's not useful
as a real timer anyways.

On Pentium 4 it also has the advantage that unlike RDTSC it's not
serializing so should be much faster.

The kernel change would be to always set CR4.PCE to allow RDPMC
in ring 3. 

It would be actually a good idea to disable RDTSC in ring 3 too
(because user space usually doesn't have enough information to make
good use of it and gets it wrong), but I fear that will break 
too many applications right now.

Any comments on this? 

-Andi

