Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbTBDIpz>; Tue, 4 Feb 2003 03:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTBDIpz>; Tue, 4 Feb 2003 03:45:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18119 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267156AbTBDIpy>;
	Tue, 4 Feb 2003 03:45:54 -0500
Date: Tue, 04 Feb 2003 00:41:51 -0800 (PST)
Message-Id: <20030204.004151.22906189.davem@redhat.com>
To: greearb@candelatech.com
Cc: john@grabjohn.com, cfriesen@nortelnetworks.com, ahu@ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: Re: problems achieving decent throughput with latency.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E3F7CDA.9020701@candelatech.com>
References: <3E3F70AD.7060901@candelatech.com>
	<20030203.233948.53493107.davem@redhat.com>
	<3E3F7CDA.9020701@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Tue, 04 Feb 2003 00:42:02 -0800
   
   Am I correct that if I have 10k clients doing their worst tricks, and
   3 * (80k, my default according to the kernel) == 240k, then I have at most
   2.4MB denial of service?  Assuming 60k clients, that is only about 15MB
   of DoS?  If true, that is a fairly small time DoS considering the RAM available
   on today's machines.

Add in the struct sk_buff for each packet as well, which is dependant
upon MSS.  Thus you could make the clients use a super-small MSS to
get more per-packet struct sk_buff overhead.  The list goes on and on.
At least Linux, unlike BSD, makes an attempt to account for the
sk_buff overhead in the limits :-)
