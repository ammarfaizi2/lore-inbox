Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUHANCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUHANCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUHANCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:02:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265248AbUHANCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:02:32 -0400
Date: Sun, 1 Aug 2004 09:02:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: linux-mm@kvack.org
cc: sjiang@cs.wm.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] token based thrashing control
In-Reply-To: <Pine.LNX.4.58.0407301730440.9228@dhcp030.home.surriel.com>
Message-ID: <Pine.LNX.4.58.0408010856240.13053@dhcp030.home.surriel.com>
References: <Pine.LNX.4.58.0407301730440.9228@dhcp030.home.surriel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004, Rik van Riel wrote:

> I have run a very unscientific benchmark on my system to test
> the effectiveness of the patch, timing how a 230MB two-process
> qsbench run takes, with and without the token thrashing
> protection present.
> 
> normal 2.6.8-rc2:	6m45s
> 2.6.8-rc2 + token:	4m24s

OK, I've now also ran day-long kernel compilate tests,
3 times each with make -j 10, 20, 30, 40, 50 and 60 on
my dual pIII w/ 384 MB and a 180 MB named in the background.

For make -j 10 through make -j 50 the differences are in
the noise, basically giving the same result for each kernel.

However, for make -j 60 there's a dramatic difference between
a kernel with the token based swapout and a kernel without.

normal 2.6.8-rc2:	1h20m runtime / ~26% CPU use average
2.6.8-rc2 + token:	  42m runtime / ~52% CPU use average

Time to dig out a dedicated test machine at the office and
do some testing with (RE-)AIM7, I wonder if the max number
of users supported will grow...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
