Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWEXB7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWEXB7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWEXB7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:59:47 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:62169 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932545AbWEXB7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:59:46 -0400
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
From: Arjan van de Ven <arjan@infradead.org>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060524012412.GB7412499@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 03:59:40 +0200
Message-Id: <1148435980.3049.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 11:24 +1000, David Chinner wrote:


> http://marc.theaimsgroup.com/?l=linux-kernel&m=114491661527656&w=2
> 
> shrink_dcache_sb() becomes a severe bottleneck when the unused dentry
> list becomes long and mounts and unmounts occur frequently on the
> machine.

how does a per SB list deal with umounts that occur frequently? I
suppose it means destroying just your list... 

> I've attempted to make reclaim fair by keeping track of the last superblock
> we pruned, and starting from the next on in the list each time.

how fair is this in the light of a non-equal sizes? say you have a 4Gb
fs and a 1Tb list. Will your approach result in trying to prune 1000
from the 4Gb, then 1000 from the 1Tb, then 1000 from the 4Gb etc ?
while that is fair in absolute terms, in relative terms it's highly not
fair to the small filesystem.... 
(I'm not sure there is ONE right answer here, well maybe by scaling the
count to the per fs count rather than to the total...)



this makes me wonder btw if we can do a per superblock slab for these
dentries, that may decrease fragmentation of slabs in combination with
your patch....


