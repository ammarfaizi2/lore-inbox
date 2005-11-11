Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKKOH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKKOH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVKKOH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:07:58 -0500
Received: from gold.veritas.com ([143.127.12.110]:24116 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750773AbVKKOH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:07:57 -0500
Date: Fri, 11 Nov 2005 14:06:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Junichi Uekawa <dancer@netfort.gr.jp>
cc: Michael Krufky <mkrufky@m1k.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       debian-amd64@lists.debian.org
Subject: Re: [x86_64] 2.6.14-git13 mplayer fails with "v4l2: ioctl queue
 buffer failed: Bad address" (2 Nov 2005, 11 Nov 2005)
In-Reply-To: <87ek5nb9ec.dancerj%dancer@netfort.gr.jp>
Message-ID: <Pine.LNX.4.61.0511111355080.16161@goblin.wat.veritas.com>
References: <87fyqeicge.dancerj%dancer@netfort.gr.jp> <87wtjg5gh2.dancerj%dancer@netfort.gr.jp>
 <4373D087.5050908@linuxtv.org> <87psp859sd.dancerj%dancer@netfort.gr.jp>
 <43740F06.6030504@m1k.net> <87y83vl780.dancerj%dancer@netfort.gr.jp>
 <87ek5nb9ec.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Nov 2005 14:07:57.0120 (UTC) FILETIME=[50F86C00:01C5E6C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Junichi Uekawa wrote:
> 
> > > One question -- At exactly what point does this break for you?  The git 
> > > commit key above was from today, but at what point did this LAST work 
> > > for you?  It would be really helpful if you can do a git bisection test, 
> > > so that we can isolate the trouble patch if in fact it is a regression.
>
> $ git-bisect start
> $ git-bisect bad 6e9d6b8ee4e0c37d3952256e6472c57490d6780d
> $ git-bisect good 741b2252a5e14d6c60a913c77a6099abe73a854a
> Bisecting: 721 revisions left to test after this

This is probably going to converge on the PageReserved removal patch,
and the way get_user_pages now refuses on a VM_RESERVED vma.

I don't want to send you a patch for that immediately, we're still
thinking through the implications of allowing VM_RESERVED there again
(it might just hit another BUG, or leak memory).  And we probably
need to take the separate "vbetool" problem into account too.

Though if you're curious and impatient, you could try just editing
the " | VM_RESERVED" out of mm/memory.c get_user_pages.

Hugh
