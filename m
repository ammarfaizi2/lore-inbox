Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUBFKe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 05:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbUBFKe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 05:34:56 -0500
Received: from dp.samba.org ([66.70.73.150]:33435 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265367AbUBFKez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 05:34:55 -0500
Date: Fri, 6 Feb 2004 21:30:10 +1100
From: Anton Blanchard <anton@samba.org>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: piggin@cyberone.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mjbligh@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <20040206103010.GI19011@krispykreme>
References: <200402060924.i169OWx30517@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402060924.i169OWx30517@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> This patch allows for this_load to set max_load, which if I understand
> the logic properly is correct.  It then adds a check to imbalance to make
> sure a negative number hasn't been coerced into a large positive number.
> With this patch applied, the algorithm is *much* more conservative ...
> maybe *too* conservative but that's for another round of testing ...

Good stuff, I just gave the patch a spin and things seem a little
calmer. However Im still seeing a lot of balancing going on within a
node.

Setup:

2 threads per cpu.
2 nodes of 16 threads each.

I ran a single "yes > /dev/null"

And it looks like that process is bouncing around the entire node.
Below is a 2 second average.

Anton

cpu    user  system    idle             cpu    user  system    idle

node 0:
cpu0      2       0      99             cpu1      9       0      91
cpu2      1       0      99             cpu3      8       0      92
cpu4      3       0      97             cpu5     10       0      90
cpu6      2       0      98             cpu7     10       0      90
cpu8      2       0      98             cpu9      9       0      90
cpu10     3       0      96             cpu11     9       0      90
cpu12     2       0      98             cpu13    10       0      90
cpu14     2       1      97             cpu15    10       1      89

node 1:
cpu16     0       0     100             cpu17     0       0     100
cpu18     0       0     101             cpu19     0       0     100
cpu20     0       0     100             cpu21     0       0     101
cpu22     0       0     101             cpu23     0       0     100
cpu24     0       0     100             cpu25     0       0     100
cpu26     0       0     100             cpu27     0       0     100
cpu28     0       0     101             cpu29     0       0     100
cpu30     0       0     100             cpu31     0       0     100
