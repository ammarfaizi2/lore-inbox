Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUHDCBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUHDCBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUHDCBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:01:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267231AbUHDCB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:01:27 -0400
Date: Tue, 3 Aug 2004 22:01:12 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040804015350.GS2241@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0408032157160.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Andrea Arcangeli wrote:
> On Tue, Aug 03, 2004 at 09:21:34PM -0400, Rik van Riel wrote:
> > This is exactly why named hugetlb files are NOT included
> > in this accounting, only the ones created through the SHM
> > interface are.
> 
> but you're allowing everybody to alloc all RAM in hugetlb files with
> the change in the previos patch posted by Arjan

Nope, Arjan's patch (and my incremental) touch hugetlb_zero_setup,
which only seems to be called from ipc/shm.c

Normal hugetlb file creation (through the filesystem) isn't touched
by these patches.

> (you're currently posted incremental patches against Arjan's patch at
> the top of the thread I hope), so you must definitely apply "this"
> accounting to hugetlb files too or it's still insecure as far as I can
> tell.

The patch only touches "anonymous" hugetlb files, ie. the ones
created through ipc/shm.c.  I'm not sure why you claim that the
others would be affected by this patch...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

