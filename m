Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTHaQHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTHaQHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:07:13 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:42080 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261375AbTHaQHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:07:12 -0400
Date: Sun, 31 Aug 2003 12:06:59 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Con Kolivas <kernel@kolivas.org>
cc: Andrew Morton <akpm@osdl.org>, <warudkar@vsnl.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
In-Reply-To: <200308281211.43945.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.44.0308311205490.25149-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003, Con Kolivas wrote:

> > Does this make a difference?
> 
> Tried it. No change. 
> 
> kswapd0 can hit 90% cpu at times unless the swappiness is increased.

Looks like the problem is that cache and process pages are on
the same lists, forcing kswapd to scan the lists endlessly.

One thing you could try is splitting the lists, at least the
active list, like done in 2.4-rmap15...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

