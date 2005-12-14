Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVLNDyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVLNDyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbVLNDyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:54:17 -0500
Received: from ns2.suse.de ([195.135.220.15]:45503 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030426AbVLNDyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:54:16 -0500
Date: Wed, 14 Dec 2005 04:54:15 +0100
From: Andi Kleen <ak@suse.de>
To: John Blackwood <john.blackwood@ccur.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, bugsy@ccur.com
Subject: Re: [PATCH] arch/x86_64/kernel/traps.c
Message-ID: <20051214035415.GE23384@wotan.suse.de>
References: <439EF717.1080408@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439EF717.1080408@ccur.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 11:30:15AM -0500, John Blackwood wrote:
> Hi Andi,
> 
> I would like to throw out a suggestion for a possible change in the way that
> the debug register traps are handled in do_debug() when the trap occurs
> in kernel-mode.
> 
> In the x86_64 version of do_debug(), the code will skip around sending
> a SIGTRAP to the current task if the trap occurred while in kernel mode.

Looks good thanks.

> Additionally, I realize that users that pull in a kernel debugger such as
> KGDB into their kernel might want to remove this change below when they add
> in KGDB support.  However, they could alternatively look at the current
> task's thread.debugreg[] values to see if the trap occurred due to KGDB
> or instead because of a user-space debugger trap, and still honor the
> user SIGTRAP processing (instead of the KGDB breakpoint processing)
> if the trap matches up with the thread.debugreg[] registers.

That should be eaten up by the die notifier.

-Andi
