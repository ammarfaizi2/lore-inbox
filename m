Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWCUPpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWCUPpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCUPpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:45:04 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47778 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751775AbWCUPpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:45:01 -0500
Date: Tue, 21 Mar 2006 21:13:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
Message-ID: <20060321154313.GA9992@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk> <17439.65413.214470.194287@robur.slu.se> <Pine.LNX.4.61.0603211552590.28173@ask.diku.dk> <44201DAF.7090707@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44201DAF.7090707@cosmosbay.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 04:37:19PM +0100, Eric Dumazet wrote:
> Jesper Dangaard Brouer a écrit :
> >There is definitly high memory pressure on this machine!
> >Slab memory usage, range from 39Mb to 205Mb (at the moment on the 
> >production servers).
> >
> 
> Did you tried 2.6.16 ?
> 
> It contains changes in kernel/rcupdate.c so that not too many RCU elems are 
> queued (force_quiescent_state()). So in the case a rt_cache_flush is done, 
> you have the guarantee all entries are not pushed into rcu at once.

Well, memory pressure or not, the oopses shouldn't be happening :)
Perhaps we should look at them before we work around memory
pressure through the rcu batch tuning stuff in 2.6.16 ?

One of the oopses looked like the rcu callback function pointer 
getting corrupted indicating that it was double freed or
problem with RCU itself.

Thanks
Dipankar
