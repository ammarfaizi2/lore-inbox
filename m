Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272087AbRHVTBS>; Wed, 22 Aug 2001 15:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272086AbRHVTBA>; Wed, 22 Aug 2001 15:01:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54444 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272087AbRHVTAj>;
	Wed, 22 Aug 2001 15:00:39 -0400
Date: Wed, 22 Aug 2001 12:00:51 -0700 (PDT)
Message-Id: <20010822.120051.25423285.davem@redhat.com>
To: kakadu_croc@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: brlock_is_locked()?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010822185351.55288.qmail@web10904.mail.yahoo.com>
In-Reply-To: <20010822.114735.128125464.davem@redhat.com>
	<20010822185351.55288.qmail@web10904.mail.yahoo.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brad Chapman <kakadu_croc@yahoo.com>
   Date: Wed, 22 Aug 2001 11:53:51 -0700 (PDT)

   	It's not really a deficiency. Rusty apparently decided that in
   order to be SMP-compliant and to prevent Oopses, that the unregistration
   function should grab the brlock so that all the packets would pass through
   the protocol-handling functions.

So arrange you code such that you aren't holding the netproto
lock when you call the unregistration function.

It is possible to shut down all references to whatever you
are unregistering, safely drop the lock, then call the
netfilter unregister routine.

   (I checked the brlock code and didn't find any schedule()s; there's
    probably a reason for that).

Ummm, this is SMP 101, you can't sleep with a lock held.
The global kernel lock is special in this regard, but all
other SMP locking primitives may not sleep.

Later,
David S. Miller
davem@redhat.com
