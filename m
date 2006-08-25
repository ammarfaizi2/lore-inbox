Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWHYXYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWHYXYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHYXYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:24:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932261AbWHYXY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:24:29 -0400
Date: Fri, 25 Aug 2006 16:24:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPV6 : segmentation offload not set correctly on TCP
 children
Message-ID: <20060825162408.6a9dbdcc@localhost.localdomain>
In-Reply-To: <20060825230626.GC4570@cip.informatik.uni-erlangen.de>
References: <20060821212243.GA1558@cip.informatik.uni-erlangen.de>
	<20060821150231.31a947d4@localhost.localdomain>
	<20060821222634.GC21790@cip.informatik.uni-erlangen.de>
	<20060825154353.3ecaf508@localhost.localdomain>
	<20060825230626.GC4570@cip.informatik.uni-erlangen.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2006 01:06:26 +0200
Thomas Glanzmann <sithglan@stud.uni-erlangen.de> wrote:

> Hello Stephen,
> thanks for the fix, it fixes the problem for me. I closed the bug. On
> which hardware did you reproduce the bug and how did you found it? Did
> you use git bisect?
> 
>         Thomas

Using sky2 on Intel motherboard and git bisect. But Jesse found same problem
on e1000. Bisect was relatively fast since it was either base net code or driver.
Starting with 2.6.17, everything worked, and latest was busted.

	git bisect start net drivers/net/sky2.c
	
Test was ipv6 slogin, then run dmesg. If that worked then run top and cause
lots of other traffic by just doing a firefox open-tabs to blast lots of connections.
Wanted to induce tcp-ipv6 to get congested.

-- 
Stephen Hemminger <shemminger@osdl.org>

All non-trivial abstractions, to some degree, are leaky.
