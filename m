Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVJ3OpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVJ3OpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJ3OpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:45:04 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38722
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1750759AbVJ3OpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:45:02 -0500
Date: Sun, 30 Oct 2005 15:44:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       olof@austin.ibm.com
Subject: Re: [PATCH] .text page fault SMP scalability optimization
Message-ID: <20051030144459.GB5074@opteron.random>
References: <20051019075255.GB30541@x30.random> <20051019011420.032ccd6d.akpm@osdl.org> <20051019090632.GC30541@x30.random> <1130653052.29054.237.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130653052.29054.237.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 05:17:31PM +1100, Benjamin Herrenschmidt wrote:
> Note that we should really pass more than just "write_access" from the
> arch code. We could make good use of "execute" in some cases as well,

Indeed. Bitflags sounds the most efficient way to do that. Currently
write_access is 0/1 value only.

> also knowing wether this is a real fault or the result of
> get_user_pages() (in some case, the former could use more agressive TLB
> pre-loading, not the later). Finally, those infos should be passed to
> update_mmu_cache().

Interesting.
