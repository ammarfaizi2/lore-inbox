Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292882AbSB0SfU>; Wed, 27 Feb 2002 13:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSB0SfP>; Wed, 27 Feb 2002 13:35:15 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:55774 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292882AbSB0Ser>; Wed, 27 Feb 2002 13:34:47 -0500
Date: Wed, 27 Feb 2002 10:34:36 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net, viro@math.psu.edu
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Message-ID: <67850000.1014834875@flay>
In-Reply-To: <10460000.1014833979@w-hlinder.des>
In-Reply-To: <10460000.1014833979@w-hlinder.des>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.5.5: 
> 
>        8.6%  1.6us( 100ms)   30us(  86ms)( 9.4%) 783373441 91.4%  8.6% 0.00%  *TOTAL*

Whilst it's great to see BKL contention going down, this:

0.16% 0.25%  0.7us( 100ms)  252us(  86ms)(0.02%)   6077746 99.8% 0.25%    0%  inode_lock
 0.03% 0.11%  0.6us(  55us)  2.1us( 9.9us)(0.00%)   1322338 99.9% 0.11%    0%    __mark_inode_dirty+0x48
 0.00%    0%  0.7us( 5.9us)    0us                      391  100%    0%    0%    get_new_inode+0x28
 0.00% 0.22%  2.5us(  50us)  495us(  28ms)(0.00%)     50397 99.8% 0.22%    0%    iget4+0x3c
 0.03% 0.28%  0.6us(  26us)   30us(  58ms)(0.00%)   1322080 99.7% 0.28%    0%    insert_inode_hash+0x44
 0.04% 0.29%  0.5us(  39us)  332us(  86ms)(0.01%)   2059365 99.7% 0.29%    0%    iput+0x68
 0.03% 0.30%  0.7us(  57us)  422us(  77ms)(0.01%)   1323036 99.7% 0.30%    0%    new_inode+0x1c
 0.03%  8.3%   63ms( 100ms)  3.8us( 3.8us)(0.00%)        12 91.7%  8.3%    0%    prune_icache+0x1c
 0.00%    0%  1.0us( 5.2us)    0us                       34  100%    0%    0%    sync_unlocked_inodes+0x10
 0.00%    0%  1.0us( 2.4us)    0us                       93  100%    0%    0%    sync_unlocked_inodes+0x110

looks a little distressing - the hold times on inode_lock by prune_icache 
look bad in terms of latency (contention is still low, but people are still 
waiting on it for a very long time). Is this a transient thing, or do people 
think this is going to be a problem?

Martin.

