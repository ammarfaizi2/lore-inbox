Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWASSML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWASSML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWASSML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:12:11 -0500
Received: from silver.veritas.com ([143.127.12.111]:21563 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1161158AbWASSMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:12:09 -0500
Date: Thu, 19 Jan 2006 18:12:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG in tmpfs
In-Reply-To: <Pine.LNX.4.63.0601191432200.8060@alpha.polcom.net>
Message-ID: <Pine.LNX.4.61.0601191744330.10617@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0601190027320.8060@alpha.polcom.net>
 <20060119031455.GA15738@kroah.com> <Pine.LNX.4.63.0601191432200.8060@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Jan 2006 18:12:07.0672 (UTC) FILETIME=[DBE1FF80:01C61D23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Grzegorz Kulewski wrote:
> > On Thu, Jan 19, 2006 at 01:14:56AM +0100, Grzegorz Kulewski wrote:
> > > 
> > > kernel BUG at mm/shmem.c:836!
> > > Jan 17 23:31:42 kangur [4312977.009000] CPU:    0
> > > Jan 17 23:31:42 kangur [4312977.009000] EIP:    0060:[<b014a429>]
> > > Tainted: P      VLI
> > > Jan 17 23:31:42 kangur [4312977.009000] EFLAGS: 00210206 
> > > (2.6.15-rc6-git4-ck1)
> > > Jan 17 23:31:42 kangur [4312977.009000] EIP is at 
> > > shmem_writepage+0xa6/0x15a
>... 
> I don't have infrastructure for making 24/7 stress tests of tmpfs (or anything
> other). But maybe if somebody has some spare machines he could try doing it
> because I am seeing different oopses/crashes/bugs in tmpfs on different kernel
> (on x86 and x86-64) from time to time.

If you still have the logs from those, please do send me.  But nobody
else has reported any such tmpfs crashes for two or three years - though
I bet just the saying of that will help someone to remind me I'm wrong ;)

While it's easy to imagine some nasty interaction between swap prefetch
and shmem_writepage's peculiar use of swap, a quick glance at that patch
didn't ring any alarm bells for me, and it's not obvious how a problem
there would result in your particular "BUG_ON(entry->val);" - which could
as well come from random corruption (and GregKH has pointed out that your
kernel is P Tainted).

I've not been testing tmpfs on -ck, but the swap prefetch patch was in
-mm for a while, and I didn't see any such problem when testing there.
Please let me know if you see more such, or can unearth earlier logs.

Hugh
