Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316226AbSEQOCq>; Fri, 17 May 2002 10:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316229AbSEQOCp>; Fri, 17 May 2002 10:02:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61340 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316226AbSEQOCn>;
	Fri, 17 May 2002 10:02:43 -0400
Date: Fri, 17 May 2002 06:49:21 -0700 (PDT)
Message-Id: <20020517.064921.80183164.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 16-CPU #s for lockfree rtcache (rt_rcu)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020517192116.G12631@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Fri, 17 May 2002 19:21:16 +0530
   
   2.5.3 : ip_route_output_key [c01bab8c]: 12166
   2.5.3+rt_rcu : ip_route_output_key [c01bb084]: 6027
   
Thanks for doing the testing.  Are you able to do this
test on some 4 or 8 processor non-NUMA system?

Basically halfing the profile hits for this function
is wonderful and I'd love to see how much of this translates to a
non-NUMA system.

   I have seen moderately significant profile counts
   for ip_route_input() in preliminary webserver benchmark runs.
   It is not however clear to me that bucket lock cache line
   bouncing is the reason behind it. That one needs more investigation.

This is where most of the routing heavy work is done on
a web server, so this doesn't surprise me.  Once packet
is input and routed, we have destination and just grab a reference to
and use it for output back to that remote host.
