Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUBWNoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUBWNoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:44:19 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:54955 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261853AbUBWNoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:44:17 -0500
Date: Mon, 23 Feb 2004 08:25:02 -0500
From: Ben Collins <bcollins@debian.org>
To: Lucas Nussbaum <lucas@lucas-nussbaum.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3 still doesn't boot on UltraSparc I
Message-ID: <20040223132502.GB4407@phunnypharm.org>
References: <20040210163232.GA2107@blop.info> <20040223133213.GA24179@blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223133213.GA24179@blop.info>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:32:13PM +0100, Lucas Nussbaum wrote:
> Hi,
> 
> As we reported in [1], Linux 2.6.(2|3) doesnt boot on sparc64. We traced the
> problem back to some changes in arch/sparc64/kernel/head.S (2.6.3 does
> boot with 2.6.1's head.S).
> 
> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=107643106916202&w=2
> 
> output :
> Allocated 8 Megs of memory at 0x4000000 for kernel
> Loaded kernel version 2.6.3    <--- SILO message
> Illegal Instruction
> {0} ok 
> 
> After a discussion with Ben Collins, it seems that only UltraSparc I are
> affected. Could somebody check the new head.S's assembly code ? We are a
> bit short here on sparc64 ASM...

So backing down to silo < 1.4.0 works with the new head.S on UltraSPARC
I? I don't think the problem itself is in head.S. Changing that would
force silo 1.4.x to not keep the kernel in high memory (would copy it
back down to 0x4000 where the old silo would have put it). I am guessing
the problem is elsewhere.

Try this, keep the new head.S and newer SILO, and edit head.S so that
"HdrS version" is 0x202 instead of 0x300. See if that boots for you
(would confirm my suspicion).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
