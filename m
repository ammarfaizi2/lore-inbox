Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbUCJNB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUCJNB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:01:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23995 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262601AbUCJNBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:01:24 -0500
Date: Wed, 10 Mar 2004 08:01:15 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to
 avoid 4:4 in <=16G machines)
In-Reply-To: <20040310080000.GA30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Andrea Arcangeli wrote:
> On Tue, Mar 09, 2004 at 06:56:50PM +0100, Andrea Arcangeli wrote:
> > We've lot of room for improvements.
> 
> Rajesh has a smart idea on how to fix the complexity issue (for both
> truncate and vm) and it involes a new non trivial data structure.
>
> I trust he will make it, but if there will be any trouble with his
> approch for safety I'm currently planning on a simpler fallback solution
> that I can manage without having to design a new tree data structure.
> 
> Sharing his "tree and sorting" idea, the fallback I propose is to simply
> index the vmas in a rbtree too.

That simply results in looking up less VMAs for low file
indexes, but still needing to check all of them for high
file indexes.

You really want to sort on both the start and end offset
of the VMA, as can be done with a kd-tree or kdb-tree.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

