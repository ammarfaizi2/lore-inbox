Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTC0SBI>; Thu, 27 Mar 2003 13:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263368AbTC0SBI>; Thu, 27 Mar 2003 13:01:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44517 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263366AbTC0SBF>;
	Thu, 27 Mar 2003 13:01:05 -0500
Date: Thu, 27 Mar 2003 10:07:00 -0800 (PST)
Message-Id: <20030327.100700.23575723.davem@redhat.com>
To: torvalds@transmeta.com
Cc: shmulik.hen@intel.com, dane@aiinet.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303271002420.29205-100000@home.transmeta.com>
References: <20030327.095537.26269606.davem@redhat.com>
	<Pine.LNX.4.44.0303271002420.29205-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Thu, 27 Mar 2003 10:04:52 -0800 (PST)

   I'd suggest making it a counting warning (with a static counter per
   local-bh-enable macro expansion) and adding it to local_bh_enable() -
   otherwise it will only BUG()  when the (potentially rare) condition
   happens - instead of always giving a nice backtrace of exact problem 
   spots.

Ok, maybe it's time to move local_bh_enable() out of line, it's
getting large and it's expanded in hundreds of places.
