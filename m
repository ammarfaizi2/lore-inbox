Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbUBJHsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUBJHsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:48:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:25232 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265709AbUBJHsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:48:41 -0500
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040212002338.2a82302d.ak@suse.de>
References: <1076384799.893.5.camel@gaston>
	 <20040212002338.2a82302d.ak@suse.de>
Content-Type: text/plain
Message-Id: <1076399289.896.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 18:48:30 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-12 at 10:23, Andi Kleen wrote:
> On Tue, 10 Feb 2004 14:47:09 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Just reverting the patch fixes it. Though, the patch do make sense in
> > some cases, paulus suggested to modify the code so that for a non
> > MAP_FIXED map, it still search from the passed-in address, but avoids
> > the spare between the current mm->brk and TASK_UNMAPPED_BASE, thus the
> > algorithm would still work for things outside of these areas.
> > 
> > Commment ?
> 
> Can you test this patch please?  It essentially implements Paulus' suggestion.
> 
> It also fixes another issue (don't use free_area_cache when the user gave an
> address hint).

Seem to boot fine here, my libc with wrong prelink hints gets properly
pushed above TASK_UNMAPPED_BASE.

Andrew/Linus, if it works for you, can you push to 2.6.3 before release?
The current stuff will break boot on a number of previously working
configurations.

Ben.

