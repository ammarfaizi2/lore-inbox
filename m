Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUBFPih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 10:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUBFPih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 10:38:37 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:57847 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265501AbUBFPif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 10:38:35 -0500
Date: Fri, 6 Feb 2004 10:36:55 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Michael Frank <mhf@linuxmail.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.25-rc1: BUG: wrong zone alignment, it will crash
In-Reply-To: <200402062245.25651.mhf@linuxmail.org>
Message-ID: <Pine.LNX.4.44.0402061034210.5933-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Michael Frank wrote:

> > > 300MB HIGHMEM available.
> > > 195MB LOWMEM available.
> > > On node 0 totalpages: 126960
> > > zone(0): 4096 pages.
> > > zone(1): 46064 pages.
> > > zone(2): 76800 pages.
> > > BUG: wrong zone alignment, it will crash

> It is supposed to work, just a bug in the zone alignment code.

The error isn't in the kernel, it's between the chair and the keyboard.
You have created a lowmem zone of a size that doesn't correctly
align with the largest blocks used by the buddy allocator.

> I have have to use HIGHMEM emulation for testing.

Then you'll need to choose a different size for the highmem=
parameter, one that doesn't cause an unaligned boundary.

Alternatively, you could submit a patch so the highmem= boot
option parsing code does the aligning for you.

However, that would simply be an improvement to the kernel and
nothing like a bug you can demand to get fixed now.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

