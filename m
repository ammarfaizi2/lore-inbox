Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263302AbRFFOvK>; Wed, 6 Jun 2001 10:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbRFFOuu>; Wed, 6 Jun 2001 10:50:50 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:28657 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S263393AbRFFOuk>; Wed, 6 Jun 2001 10:50:40 -0400
Date: Wed, 6 Jun 2001 15:51:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        Derek Glidden <dglidden@illusionary.com>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D927E.1B2EBE76@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0106061539110.983-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Andrew Morton wrote:
> Yes. The sys_swapoff() system call can take many minutes

> Haven't looked at it closely, but I think the algorithm
> could become something like:
> 
> 	for (each process) {
> 		for (each page in this process) {
> 			if (page is on target swap device)
> 				get_it_off()
> 		}
> 	}

Substitute "mm" for "process".  Yes, of course, that would be vastly
better than the present way (or is there some gotcha? it's hard to
understand why someone would choose to write it the way it is).

However... don't forget that another of the current swap problems is
pages being left in the swap cache after they've been unmapped from
(all) their mms - those need to be dealt with too.

Hugh

