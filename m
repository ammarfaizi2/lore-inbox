Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268238AbTB1Vi5>; Fri, 28 Feb 2003 16:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTB1Vhq>; Fri, 28 Feb 2003 16:37:46 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26044 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S268215AbTB1VhE>; Fri, 28 Feb 2003 16:37:04 -0500
Date: Fri, 28 Feb 2003 21:49:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Memory modified after freeing in 2.5.63?
In-Reply-To: <20030228150447.GA3862@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0302282132360.2076-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003, Petr Vandrovec wrote:
>   for some time I'm using patch attached at the end of this email, 
> which modifies check_poison function to not only verify that
> last byte is POISON_END, but also that all preceeding bytes are
> either POISON_BEFORE or POISON_AFTER bytes. 
> 
>   And now when I returned from my month vacation and upgraded 
> from 2.5.52 to 2.5.63, when dselect/apt updates dozens of packages, 
> I'm getting memory corruption reports as shown below - 22nd byte 
> in vm_area_struct - which looks like that VM_ACCOUNT in vm_flags 
> is set after vma is freeed...  Any clue? Setting VM_ACCOUNT
> in mremap.c:move_vma after calling do_unmap() looks suspicious
> to me, but as I know almost nothing about MM...

Petr, do you have a corner I can hide in?  Andrew will whip me.
He nags me from time to time about that code, he's sceptical
whereas I believed it fragile but okay for now.  Looks like
you've caught me out, perhaps I should just take your POISON.

Hmm, it's really not what I want to be thinking about right now:
the real fix is to split_vma explicitly before the do_unmap, but
hard to get into that without opening up other cans of worms
(what to do if split_vma fails for lack of memory).  Many thanks
for the report, I won't be able to fix it in the next three days,
but will get back to you when I have a patch to try.

Hugh

