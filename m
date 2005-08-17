Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVHQPUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVHQPUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVHQPUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:20:49 -0400
Received: from dns.suna-asobi.com ([210.151.31.146]:25480 "EHLO
	dns.suna-asobi.com") by vger.kernel.org with ESMTP id S1751149AbVHQPUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:20:49 -0400
Date: Thu, 18 Aug 2005 00:27:14 +0900
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
In-Reply-To: <20050817233001.6E7C.AKIRA-T@suna-asobi.com>
References: <98df96d305081622107ca969f@mail.gmail.com> <20050817233001.6E7C.AKIRA-T@suna-asobi.com>
Message-Id: <20050818002425.6E90.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am resubmitting this because it seems to be lost when I posted 
the before yesterday.

------------------------------------
Arjan van de Ven mentioned:
> The only comment/question I have is about the use of prefetchnta; that
> might have cache-evicting properties as well (eg evict the cache of the
> original of the copy, eg the userspace memory). Is that really the right
> approach? 
> In addition, my measurements show that removing the prefetch from the
> main copy loop is a gain because the modern cpus have an autoprefetcher
> already in the hardware.

My computer with Athlon K7 was faster with manually prefetching,
but I did not know it is already becoming obsolete.

It was pretty while ago, but I also made a similar copy_user function;
http://www.suna-asobi.com/~akira-t/linux/k7-copy-user/K7-copy-47.patch
I add comments on each item in the copy function. It was basically 
inspired from Takahashi's intel faster copy function.

I also have some explanation about the speedup for pipelined cpu.
http://www.suna-asobi.com/~akira-t/linux/k7-copy-user/copy_for_highlypipelined_cpu.txt

It was originally discussed in this thread,
http://marc.theaimsgroup.com/?l=linux-kernel&m=103742983924070&w=2



