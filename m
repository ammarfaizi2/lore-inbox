Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbULTP3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbULTP3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbULTP0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:26:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27569 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261548AbULTPYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:24:03 -0500
Date: Mon, 20 Dec 2004 10:23:56 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
In-Reply-To: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0412201021200.13935@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Rik van Riel wrote:

> Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>" will
> result in OOM kills, with the dirty pagecache completely filling up
> lowmem.  This patch is part 1 to fixing that problem.

What I forgot to say is that in order to trigger this OOM kill
the dirty_limit of 40% needs to be more memory than what fits
in low memory.  So this will work on x86 with 4GB RAM, since
the dirty_limit is 1.6GB, but the block device cache cannot
grow that big because it is restricted to low memory.

This has the effect of all low memory being tied up in dirty
page cache and userspace try_to_free_pages() skipping the
writeout of these pages because the block device is congested.



-- 
He did not think of himself as a tourist; he was a traveler. The difference is
partly one of time, he would explain. Where as the tourist generally hurries
back home at the end of a few weeks or months, the traveler belonging no more
to one place than to the next, moves slowly, over periods of years, from one
part of the earth to another. Indeed, he would have found it difficult to tell,
among the many places he had lived, precisely where it was he had felt most at
home.  -- Paul Bowles
