Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWCYMA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWCYMA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCYMA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:00:27 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:34213 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1750815AbWCYMA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:00:27 -0500
Date: Sat, 25 Mar 2006 13:00:20 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Con Kolivas <kernel@kolivas.org>, john stultz <johnstul@us.ibm.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
Message-ID: <20060325120020.GA2111@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Con Kolivas <kernel@kolivas.org>, john stultz <johnstul@us.ibm.com>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	linux-kernel@vger.kernel.org, george@mvista.com,
	Andrew Morton <akpm@osdl.org>
References: <20060320122449.GA29718@outpost.ds9a.nl> <1142968999.4281.4.camel@leatherman> <8764m7xzqg.fsf@duaron.myhome.or.jp> <200603221121.16168.kernel@kolivas.org> <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch adds blacklist of buggy chip, and if chip is not buggy,
> this uses fast normal version instead of slow workaround version.

I can confirm that this patch solves the problem I originally complained
about. 

Timings of 10,000,000 gettimeofday calls on my pentium 4 3GHz (which I won
at OLS, ha!):

tsc
---
real    0m2.504s
user    0m0.700s
sys     0m1.804s

2.6.16-mainline
---------------
real    0m36.973s
user    0m1.440s
sys     0m34.130s

2.6.16-ogawa
------------
real    0m13.697s
user    0m1.712s
sys     0m11.117s

For reference, baseline 2.6.16 on my Athlon64 3200+
---------------------------------------------------
real    0m1.994s
user    0m0.990s
sys     0m0.990s

I'm still going to recommend all 'power' pdns_recursor users on single CPU
and not using frequency scaling to boot with clock=tsc - saves
2.2usec/packet. Or run on an opteron of course.

Thanks for the work everybody!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
