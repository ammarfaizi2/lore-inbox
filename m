Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268233AbRHBR5l>; Thu, 2 Aug 2001 13:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269050AbRHBR5V>; Thu, 2 Aug 2001 13:57:21 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:1993 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S269039AbRHBR5S>; Thu, 2 Aug 2001 13:57:18 -0400
Date: Thu, 2 Aug 2001 18:58:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_trace() module_end = 0?
In-Reply-To: <Pine.LNX.4.33.0108021553500.7060-100000@chaos.tp1.ruhr-uni-bochum.de>
Message-ID: <Pine.LNX.4.21.0108021822340.959-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Kai Germaschewski wrote:
> 
> As I need module back traces once in a while, I was not really happy with 
> the current approach. I coded a patch which will reenable printing a call 
> trace including addresses in modules.

Haven't tried it, but looks good to me.

> I'm not sure if this an approach you would accept. The code makes sure
> that only addresses within a vmalloc'ed module area are printed, not
> everything between VMALLOC_START and _END. However, we don't distinguish
> between module .text as opposed to .data, .bss... Doing so seems a lot
> harder to implement.

Much better than the original VMALLOC_START to VMALLOC_END, much better
than the current none-at-all, much better than going down the vmlist.

(The text could perhaps be identified at module load time, by looking
at the "__insmod_" symbols; but that would be a hack, you're right not
to try any such thing in this patch.)

> The other, minor problem is that we should walk the module_list under 
> lock_kernel() only, but I wasn't brave enough to add this to the 
> show_trace() code path.

I think it's just modlist_lock you'd need.  Not sure whether better
to try for it or ignore it.  CC'ed Andrew "spinlock-buster" Morton
for his opinion.

Hugh

