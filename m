Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVAAERC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVAAERC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 23:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVAAERC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 23:17:02 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19090 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262191AbVAAEQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 23:16:52 -0500
To: Michael Hines <mhines@cs.fsu.edu>
Cc: <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <Pine.GSO.4.33.0412312259160.28251-100000@diablo.cs.fsu.edu>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 31 Dec 2004 20:16:48 -0800
In-Reply-To: <Pine.GSO.4.33.0412312259160.28251-100000@diablo.cs.fsu.edu> (Michael
 Hines's message of "Fri, 31 Dec 2004 23:04:58 -0500 (EST)")
Message-ID: <523bxlaimn.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: can you switch between GFP_ATOMIC and GFP_KERNEL?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 01 Jan 2005 04:16:49.0108 (UTC) FILETIME=[B6ADC940:01C4EFB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> My question is, new sk_buffs are always allocated with
    Michael> GFP_KERNEL and can be swapped out. Is it possible to
    Michael> change the allocation status of already-allocated memory
    Michael> to GFP_ATOMIC on the fly? (i.e. both the slab-cache
    Michael> sk_buff header memory as well as the kmalloc'd data
    Michael> area).

This question is ill-posed -- kernel memory can never be swapped out,
whether it's allocated with GFP_KERNEL or GFP_ATOMIC.  The difference
between GFP_KERNEL and GFP_ATOMIC is whether the actual allocation can
sleep, that is:

	foo = kmalloc(sizeof foo, GFP_ATOMIC);	/* will not sleep */
	foo = kmalloc(sizeof foo, GFP_KERNEL);	/* can sleep */

However, whichever gfp flags are used to allocate memory, the memory
is the same once the allocation is done.  Neither kmalloc'ed memory
nor sk_buffs will ever be swapped.

 - Roland
