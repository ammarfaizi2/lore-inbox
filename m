Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVB0Xc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVB0Xc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 18:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVB0Xc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 18:32:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261513AbVB0XcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:32:25 -0500
Date: Sun, 27 Feb 2005 18:32:22 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christian Schmid <webmaster@rapidforum.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
In-Reply-To: <422239A8.1090503@rapidforum.com>
Message-ID: <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com>
References: <4221FB13.6090908@rapidforum.com>
 <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com>
 <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com>
 <422239A8.1090503@rapidforum.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005, Christian Schmid wrote:

> > Christian, how big are the data blocks you sys_readahead, and
> > how many do you have outstanding at a time ?
> 
> I am reading 800000 bytes of data as soon as there is less than 200000 
> data in the cache. I do assume the cache doesnt kill itself. I have 8 GB 
> machine with 7,5 GB free for caching.

OK, so you read 800kB with 4000 threads, or 3.2GB of
readahead data.  The inactive list is quite possibly
smaller than that, at 1/3 of memory or around 2.6 GB.

It looks like the cache might be killing itself, through
readahead thrashing.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
