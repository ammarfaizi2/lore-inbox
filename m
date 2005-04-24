Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVDXOY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVDXOY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 10:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVDXOY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 10:24:56 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:9450 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261543AbVDXOYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 10:24:54 -0400
Message-ID: <426BABF4.3050205@ammasso.com>
Date: Sun, 24 Apr 2005 09:23:48 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@infradead.org, roland@topspin.com, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org>
In-Reply-To: <20050423194421.4f0d6612.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> If your theory is correct then it should be able to demonstrate this
> problem without any special hardware at all: pin some user memory, then
> generate memory pressure then check the contents of those pinned pages.

I tried that, but I couldn't get it to fail.  But that was a while ago, and I've learned a 
few things since then, so I'll try again.

> But if, for the DMA transfer, you're using the array of page*'s which were
> originally obtained from get_user_pages() then it's rather hard to see how
> the kernel could alter the page's contents.
> 
> Then again, if mlock() fixes it then something's up.  Very odd.

With mlock(), we don't need to use get_user_pages() at all.  Arjan tells me the only time 
an mlocked page can move is with hot (un)plug of memory, but that isn't supported on the 
systems that we support.  We actually prefer mlock() over get_user_pages(), because if the 
process dies, the locks automatically go away too.

