Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVB0RSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVB0RSz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVB0RSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:18:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59613 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261440AbVB0RSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:18:52 -0500
Date: Sun, 27 Feb 2005 12:18:48 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christian Schmid <webmaster@rapidforum.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
In-Reply-To: <4221FB13.6090908@rapidforum.com>
Message-ID: <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com>
References: <4221FB13.6090908@rapidforum.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005, Christian Schmid wrote:

> The problem here is that starting with 3000 sockets, the syswrite locks 
> more and more on the sockets although the sockets are non-blocking. This 
> just suddenly appears at around 3000 sockets. I have raised 
> min_free_kbytes to 1024000 and then it suddenly did not block anymore. I 
> changed it down to 16000 again and id instantly locked again. Up to 
> 1024000 and no locking. Now it starts blocking again at 4000 sockets 
> even with 1024000 min_free_kbytes, slowing everything down.... what 
> could this be?

Is it possible to detect when the write system call blocks?

Maybe alt-sysrq-p can be used to find out where the process
is spending its time, there may be some code path left where
the write system call blocks, even with nonblocking writes...

> Its no network-problem. I have discussed this issue with netdev-people 
> for 2 weeks. No memory problem as well I suppose, its 8 gb ram with a 
> 2/2 split...

It could be an interaction between the network subsystem
and the memory management subsystem, eg. the TCP stack not
allocating more than a certain amount of buffer memory and
stalling until some previously sent data has been received.

Getting backtraces of when the process is "stuck" will be
very helpful.

> This problem has been observed on a 2.6.10 kernel.

Did things work right in earlier kernels (is this a regression) ?
Or have things always worked this way ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
