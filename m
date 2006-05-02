Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWEBQfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWEBQfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWEBQfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:35:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:38588 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964916AbWEBQfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:35:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>, wfg@mail.ustc.edu.cn
Subject: Re: [RFC] kernel facilities for cache prefetching
References: <346556235.24875@ustc.edu.cn>
	<Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2006 18:35:50 +0200
In-Reply-To: <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
Message-ID: <p73wtd45qqh.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> 
> The downsides basically boil down to the fact that it's not as clearly 
> just one single point. You can't just look at the request queue and see 
> what physical requests go out.

The other problem is that readpages has no idea about the layout
of the disk so just doing it dumbly might end up with a lot of seeking.

I suppose you would at least need some tweaks to the scheduler to make
sure it doesn't give these reads any priority and keeps them in the
queue long enough to get real good sorting and large requests.

Problem is that this would likely need to be asynchronous to be any
useful unless you were willing to block a thread for a potentially
long time for each file to be prefetched.

-Andi
