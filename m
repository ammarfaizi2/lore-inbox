Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbTC0Tpu>; Thu, 27 Mar 2003 14:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbTC0Tpu>; Thu, 27 Mar 2003 14:45:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29670 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261165AbTC0Tps>;
	Thu, 27 Mar 2003 14:45:48 -0500
Date: Thu, 27 Mar 2003 11:53:14 -0800 (PST)
Message-Id: <20030327.115314.121599027.davem@redhat.com>
To: rml@tech9.net
Cc: torvalds@transmeta.com, dane@aiinet.com, shmulik.hen@intel.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1048794730.775.14.camel@localhost>
References: <Pine.LNX.4.44.0303271120230.31459-100000@home.transmeta.com>
	<20030327.113933.123322481.davem@redhat.com>
	<1048794730.775.14.camel@localhost>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 27 Mar 2003 14:52:11 -0500

   On Thu, 2003-03-27 at 14:39, David S. Miller wrote:
   
   > I hadn't considered this, good idea.  I'm trying this out right now.
   
   I hope it works.  I have a sinking feeling we call it some places that
   may have interrupts disabled...

Your sinking feeling was warranted.

Nearly every hw IRQ implementation invokes irq_exit() with
CPU interrupts off :-(  That has to be screwing with performance
as well.
