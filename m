Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbTC0TDg>; Thu, 27 Mar 2003 14:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTC0TDg>; Thu, 27 Mar 2003 14:03:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5094 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261329AbTC0TDd>;
	Thu, 27 Mar 2003 14:03:33 -0500
Date: Thu, 27 Mar 2003 11:10:12 -0800 (PST)
Message-Id: <20030327.111012.23672715.davem@redhat.com>
To: torvalds@transmeta.com
Cc: dane@aiinet.com, shmulik.hen@intel.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303271104270.31459-100000@home.transmeta.com>
References: <Pine.LNX.4.33.0303271315010.30532-100000@dane-linux.aiinet.com>
	<Pine.LNX.4.44.0303271104270.31459-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Thu, 27 Mar 2003 11:08:26 -0800 (PST)

   So what the test SHOULD look like is this:
   
   	if (gfp_mask & __GFP_WAIT) {
   		if (in_atomic() || irqs_disabled()) {
   			static int count = 0;
   			...
   		}
   	}
   
   which should catch all the cases we really care about.

Let's codify this "in_atomic() || irqs_disabled()" test into a macro
that everyone can use to test sleepability, ok?
