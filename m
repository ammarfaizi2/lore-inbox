Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVIJPDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVIJPDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 11:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVIJPDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 11:03:41 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21187 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750728AbVIJPDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 11:03:40 -0400
Date: Sat, 10 Sep 2005 16:02:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2/2] Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR
In-Reply-To: <200509101644.55887.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0509101556460.15994@goblin.wat.veritas.com>
References: <4322CBD9.mailE1P118OD2@suse.de> <Pine.LNX.4.61.0509101440420.14979@goblin.wat.veritas.com>
 <200509101644.55887.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Sep 2005 15:02:30.0421 (UTC) FILETIME=[AA660450:01C5B618]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Andi Kleen wrote:
> On Saturday 10 September 2005 16:15, Hugh Dickins wrote:
> > On Sat, 10 Sep 2005, Andi Kleen wrote:
> > > Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR
> > >
> > > When this code was refactored by Hugh it was moved out of the actual
> > > functions into these inlines. The problem is that pgd_ERROR
> > > uses __FUNCTION__ and __LINE__ to show where the error happened,
> > > and with the inline that is pretty meaningless now because
> > > it's the same for all callers.
> > >
> > > Change them to be macros to avoid this problem
> >
> > Please don't.  It adds much less than I misremember (only 550 bytes
> > to my i386 PAE config), but even so it's a waste of space. 
> 
> Hmm? Macros and inlines take the same amount of space. 

I expect they do, but that's not the issue.  You're moving
mm/memory.c's out-of-line p?d_clear_bad code inline (or into macro).

> I have actually seen them while debugging something. But it was useless.
> That is why I made the change.

If you've found their __FUNCTION__ and __LINE__ useful,
then I think you'll find the WARN_ON(1) backtrace even more so.

Hugh
