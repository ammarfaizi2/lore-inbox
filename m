Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbVIOUOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbVIOUOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVIOUOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:14:43 -0400
Received: from kanga.kvack.org ([66.96.29.28]:22949 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030499AbVIOUOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:14:42 -0400
Date: Thu, 15 Sep 2005 16:13:57 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Sonny Rao <sonny@burdell.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Message-ID: <20050915201356.GA20966@kvack.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <20050913063359.GA29715@kevlar.burdell.org> <43267A00.1010405@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43267A00.1010405@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 09:04:32AM +0200, Eric Dumazet wrote:
> I wish a process param could allow open() to take any free fd available, 
> not the lowest one. One can always use fcntl(fd, F_DUPFD, slot) to move a 
> fd on a specific high slot and always keep the 64 first fd slots free to 
> speedup the kernel part at open()/dup()/socket() time.

The overhead is easy to avoid by making use of dup2() and close() to keep 
the lowest file descriptors in the table free, allowing open() and socket() 
to always return 3 or 4.

Alternatively, the kernel could track available file descriptors using a 
tree to efficiently insert freed slots into an ordered list of free 
regions (something similar to the avl tree used in vmas).  Is it worth 
doing?

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
