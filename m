Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVCNFNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVCNFNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVCNFNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:13:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:49035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261843AbVCNFNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:13:00 -0500
Date: Sun, 13 Mar 2005 21:12:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode_lock heavily contended in 2.6.11
Message-Id: <20050313211234.14a1d24f.akpm@osdl.org>
In-Reply-To: <16949.4010.174143.391599@wombat.chubb.wattle.id.au>
References: <16949.4010.174143.391599@wombat.chubb.wattle.id.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>
> 
> When running reaim7 on a 12-way IA64 on an ext2 filesystem on a ram
> disc, I see very heavy contention on inode_lock.

Yes, that's a big global lock, protecting global resources.  I always
expected it to hit someone's fan, but it never did.

> lockstat output shows:
> 
> SPINLOCKS         HOLD            WAIT
>   UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
>  46.8% 52.4%  1.9us( 130us)   20us(8073us)(21.5%)   5072151 47.6% 52.4%    0%  inode_lock
>  15.9% 59.5%  3.8us(  61us)   18us(7067us)( 3.9%)    852983 40.5% 59.5%    0%    __sync_single_inode+0xf0
>   9.2% 59.0%  1.2us(  25us)   20us(8073us)( 7.8%)   1596487 41.0% 59.0%    0%    generic_osync_inode+0xe0
> 
>  (etc).
> 
> Is anyone else seeing this on more realistic workloads?

An fsync/O_SYNC-intensive workload on a ram disk is likely to bring it out,
yes.  But once one has real disks under there, the acquisition frequency
will fall a lot.

Unless people are being all shy again, I don't think anyone has hit
significant inode_lock problems on more real-world things.

