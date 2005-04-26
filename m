Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVDZPdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVDZPdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDZPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:33:19 -0400
Received: from groover.houseafrika.com ([12.162.17.52]:35341 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261614AbVDZPbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:31:33 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: timur.tabi@ammasso.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 26 Apr 2005 08:31:32 -0700
In-Reply-To: <20050425173757.1dbab90b.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 25 Apr 2005 17:37:57 -0700")
Message-ID: <52wtqpsgff.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Apr 2005 15:31:32.0621 (UTC) FILETIME=[063CE3D0:01C54A75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> umm, how about we

    Andrew> - force the special pages into a separate vma

    Andrew> - run get_user_pages() against it all

    Andrew> - use RLIMIT_MEMLOCK accounting to check whether the user
    Andrew> is allowed to do this thing

    Andrew> - undo the RMLIMIT_MEMLOCK accounting in ->release

    Andrew> This will all interact with user-initiated mlock/munlock
    Andrew> in messy ways. Maybe a new kernel-internal vma->vm_flag
    Andrew> which works like VM_LOCKED but is unaffected by
    Andrew> mlock/munlock activity is needed.

    Andrew> A bit of generalisation in do_mlock() should suit?

Yes, it seems that modifying do_mlock() to something like

	int do_mlock(unsigned long start, size_t len,
		     unsigned int set, unsigned int clear)

and then exporting a function along the lines of

	int do_mem_pin(unsigned long start, size_t len, int on)

that sets/clears (VM_LOCKED_KERNEL | VM_DONTCOPY) according to the on
flag.

Seem reasonable?  If so I can code this up.

 - R.
