Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUCHQ5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUCHQ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:57:53 -0500
Received: from zero.aec.at ([193.170.194.10]:56069 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262195AbUCHQ5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:57:52 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
References: <1xpyM-2Op-21@gated-at.bofh.it> <1xqXN-44F-13@gated-at.bofh.it>
	<1xr7w-4c4-9@gated-at.bofh.it> <1xrqW-4rh-51@gated-at.bofh.it>
	<1xuS8-83Q-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 08 Mar 2004 17:57:26 +0100
In-Reply-To: <1xuS8-83Q-11@gated-at.bofh.it> (Tom Rini's message of "Mon, 08
 Mar 2004 16:30:38 +0100")
Message-ID: <m3hdwz9szt.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:
>
> Here's where what Andi said about being able to get the pt_regs stuff
> off the stack (I think that's what he said at least) started to confuse
> me slightly.  But if I understand it right (and I never got around to
> testing this) we can replace the do_schedule() stuffs at least with
> something like kgdb_get_pt_regs(), since (and I lost my notes on this,
> so it's probably not quite right) (thread_info->esp0)-1

No, that's the user space registers.

You don't need these registers really as long as you have the 
correct dwarf2 CFI description of all the code involved. gdb
is then able to reconstruct them using the C stack by itself.

All it needs for that is esp and eip.

-Andi

