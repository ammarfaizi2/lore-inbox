Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbULJTBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbULJTBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbULJTBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:01:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8351 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261800AbULJTBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:01:34 -0500
Date: Fri, 10 Dec 2004 13:00:25 -0600
From: Robin Holt <holt@sgi.com>
To: yoshfuji@linux-ipv6.org, akpm@osdl.org, hirofumi@parknet.co.jp,
       davem@davemloft.net, torvalds@osdl.org, dipankar@ibm.com,
       laforge@gnumonks.org, bunk@stusta.de, herbert@apana.org.au,
       paulmck@ibm.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ^Greg Banks <gnb@sgi.com>
Subject: [RFC] Limit the size of the IPV4 route hash.
Message-ID: <20041210190025.GA21116@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have sent a couple emails concerning the IPv4 route hash size in the
past week with no response.  I am now sending to everyone that has made
changes to the net/ipv4/route.c file in the last six months to hopefully
get some direction.  Sorry for the wide net, but I do not know how to
proceed.

The first post was asking for direction on the maximum size for the
route cache.  The link is here:  (NOTE: I never saw this come back from
the netdev list)

What is a reasonable upper limit to the rt_hash_table.
http://marc.theaimsgroup.com/?l=linux-kernel&m=110244057617765&w=2

I then did some testing/experimenting with systems that are in production,
determined the size calculation is definitely too large and then came
to the following conclusion:

Limit the route hash size.
http://marc.theaimsgroup.com/?l=linux-kernel&m=110260977405809&w=2

In the second, I included the patch, but did not intend this to be a
patch submission.  Sorry for the Signed-off-by.


Where do I go from here?  I hate to just submit this as a patch without
any other discussion.  I have checked route cache size on many machines
and they have all been in the 30-100 range except for some on ISP machines
that are serving web pages where I have seen three machines with a cache
size of up to 800 entries.  And one university email server where they
have set the secret_interval to 86,400 which has peaked at 18,434 entries.

With those sizes noted, the cache size of one page does not appear to
have any negative impact for any except the email server.  For that
machine, they have already reviewed the code and decided to adjust
tunable values so I can not believe they would be upset with having to
provide an rhash_entries= append on the boot line.

Are there any benchmarks I am supposed to run prior to asking for this
patch to be incorporated?

Any guidance would be greatly appreciated.  Thank you for you attention.
Again, sorry for the wide net.

Robin Holt
