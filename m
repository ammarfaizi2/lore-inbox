Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbTC0OFT>; Thu, 27 Mar 2003 09:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262943AbTC0OFT>; Thu, 27 Mar 2003 09:05:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38627 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262942AbTC0OFR>;
	Thu, 27 Mar 2003 09:05:17 -0500
Date: Thu, 27 Mar 2003 06:12:41 -0800 (PST)
Message-Id: <20030327.061241.105170741.davem@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: shmulik.hen@intel.com, dane@aiinet.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       torvalds@transmeta.com, mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <shssmt8vqz7.fsf@charged.uio.no>
References: <Pine.LNX.4.44.0303271406230.7106-100000@jrslxjul4.npdj.intel.com>
	<20030327.054357.17283294.davem@redhat.com>
	<shssmt8vqz7.fsf@charged.uio.no>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Trond Myklebust <trond.myklebust@fys.uio.no>
   Date: 27 Mar 2003 15:11:56 +0100

        > IRQ disabling is meant to be stronger than softint disabling.
   
   In that case, you'll need to have things like spin_lock_irqrestore()
   call local_bh_enable() in order to run the pending softirqs. Is that
   worth the trouble?

"trouble" is a weird word to use when the current behavior is
just wrong. :-)

My point is that it doesn't matter what the fix is, running
softints while hw IRQs are disabled must be fixed.
