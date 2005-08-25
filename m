Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVHYOr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVHYOr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVHYOr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:47:27 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:42647 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750949AbVHYOr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:47:27 -0400
Subject: Re: process creation time increases linearly with shmem
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200508251622.08456.ak@suse.de>
References: <082520051405.5272.430DD0420003F49F00001498220076139400009A9B9CD3040A029D0A05@comcast.net>
	 <200508251622.08456.ak@suse.de>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 10:47:20 -0400
Message-Id: <1124981240.3055.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:22 +0200, Andi Kleen wrote:
> But I'm not sure it's a good idea in all cases. Would need a lot of 
> benchmarking  at least.
> 
> -Andi
> 

Exactly - one problem is that this forces all of the hugetlb users to go
the lazy faulting way. This is more or less similar to the original
problem the fork() forces everything to be mapped and some apps don't
like it. Same way, some apps may not want hugetlb pages to be all
pre-mapped. 

That's why I was alluding towards having the user specify MAP_SHARED|
MAP_LAZY or something to that tune and then have fork() honor it. So
people who want all things pre-mapped will not specify MAP_LAZY, just
MAP_SHARED. 

Now I don't even know if above is possible and workable for all
scenarios but that's why I was asking.. :)

Parag

