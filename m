Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262943AbTC0OKR>; Thu, 27 Mar 2003 09:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262947AbTC0OKR>; Thu, 27 Mar 2003 09:10:17 -0500
Received: from mons.uio.no ([129.240.130.14]:8341 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262943AbTC0OKJ>;
	Thu, 27 Mar 2003 09:10:09 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: shmulik.hen@intel.com, dane@aiinet.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       torvalds@transmeta.com, mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
References: <E791C176A6139242A988ABA8B3D9B38A01085638@hasmsx403.iil.intel.com>
	<Pine.LNX.4.44.0303271406230.7106-100000@jrslxjul4.npdj.intel.com>
	<20030327.054357.17283294.davem@redhat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Mar 2003 15:11:56 +0100
In-Reply-To: <20030327.054357.17283294.davem@redhat.com>
Message-ID: <shssmt8vqz7.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David S Miller <davem@redhat.com> writes:

     >    From: shmulik.hen@intel.com Date: Thu, 27 Mar 2003 15:32:02
     >    +0200 (IST)

     >    Further more, holding a lock_irq doesn't mean bottom halves
     >    are disabled too, it just means interrupts are disabled and
     >    no *new* softirq can be queued. Consider the following
     >    situation:
   
     > I think local_bh_enable() should check irqs_disabled() and
     > honour that.  What you are showing here, that BH's can run via
     > local_bh_enable() even when IRQs are disabled, is a BUG().

     > IRQ disabling is meant to be stronger than softint disabling.

In that case, you'll need to have things like spin_lock_irqrestore()
call local_bh_enable() in order to run the pending softirqs. Is that
worth the trouble?

Cheers,
  Trond
