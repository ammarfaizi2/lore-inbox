Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVIILbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVIILbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVIILbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:31:18 -0400
Received: from silver.veritas.com ([143.127.12.111]:32920 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030252AbVIILbR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:31:17 -0400
Date: Fri, 9 Sep 2005 12:31:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
In-Reply-To: <20050909112108.GK19913@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0509091222310.6443@goblin.wat.veritas.com>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com>
 <4321749202000078000248C5@emea1-mh.id2.novell.com>
 <Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com> <200509091258.13300.ak@suse.de>
 <Pine.LNX.4.61.0509091208350.6247@goblin.wat.veritas.com>
 <20050909112108.GK19913@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Sep 2005 11:31:11.0664 (UTC) FILETIME=[FADB7B00:01C5B531]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Andi Kleen wrote:
> On Fri, Sep 09, 2005 at 12:14:38PM +0100, Hugh Dickins wrote:
> > 
> > Ah, right.  I'm using kdb with it.  (And my recollection of when
> > show_stack did have a framepointer version, is that it was hopelessly
> > broken on interrupt frames, and we're much better off without it.)
> 
> Not sure if the x86-64 kdb had code to follow them either.
> The i386 one has.

x86_64 kdb does have the code to follow them, it's pretty much the same.

(kdb does have a bug in its x86_64 setjmp with framepointers, but that's
irrelevant to whether the x86_64 kernel supports framepointers.)

> But kdb should be using a dwarf2 unwinder instead. kgdb certainly
> supports that, as does NLKD.

In an ideal and bloat-neutral world.  I've always imagined it to be
quite a lot of work, bringing in its own set of problems: but great
that that work has now been done, and yes, it might one day get
ported to kdb.  But removing "&& !X86_64" is much easier.

Hugh
