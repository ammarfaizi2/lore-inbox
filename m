Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVD0Vhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVD0Vhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVD0Vho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:37:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:36332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262036AbVD0Vh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:37:29 -0400
Date: Wed, 27 Apr 2005 14:39:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Magnus Damm <magnus.damm@gmail.com>, mason@suse.com,
       mike.taht@timesys.com, mpm@selenic.com, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
In-Reply-To: <426FFFAB.1030005@tmr.com>
Message-ID: <Pine.LNX.4.58.0504271431510.18901@ppc970.osdl.org>
References: <20050426135606.7b21a2e2.akpm@osdl.org><20050426135606.7b21a2e2.akpm@osdl.org>
 <20050427063439.GA22014@elte.hu> <426FFFAB.1030005@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Apr 2005, Bill Davidsen wrote:
> 
> I said much the same in another post, but noatime is not always what I 
> really want.

"atime" is really nasty for a filesystem. I don't know if anybody noticed, 
but git already uses O_NOATIME to open all the object files, because if 
you don't do that, then just looking at a full kernel tree (which has more 
than a thousand subdirectories) will cause nasty IO patterns from just 
writing back "atime" information for the "tree" objects we looked up.

So you can do (and git does) selective atime updates. It just requires a 
small amount of extra care. 

> How about a "nojournalatime" option, so the atime would be 
> updated at open and close, but not journaled at any other time.

Probably a good idea. 

		Linus
