Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265136AbUEYUKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUEYUKq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUEYUKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:10:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55731 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265136AbUEYUKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:10:42 -0400
Date: Tue, 25 May 2004 16:10:29 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Phy Prabab <phyprabab@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 4g/4g for 2.6.6
In-Reply-To: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004, Rik van Riel wrote:

> The point is, people like to run bigger workloads on
> bigger systems. Otherwise they wouldn't bother buying
> those bigger systems.

Btw, you're right about the VMAs.  Looking through customer
stuff a bit more the more common issues are low memory being
eaten by dentry / inode cache - which you can't always reclaim
due to files being open, and don't always _want_ to reclaim
because that could well be a bigger performance hit than the
4:4 split.

The primary impact of the dentry / inode cache using memory
isn't lowmem exhaustion, btw.  It's lowmem fragmentation.

Fragmentation causes fork trouble (gone with the 4k stacks)
and trouble for the network layer and kiobuf allocation,
which still do need higher order allocations.

Sure, the 4/4 kernel could also have problems with lowmem
fragmentation, but it just seems to be nowhere near as bad.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

