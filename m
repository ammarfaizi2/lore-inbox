Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272079AbRHVSrs>; Wed, 22 Aug 2001 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272081AbRHVSrp>; Wed, 22 Aug 2001 14:47:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43692 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272079AbRHVSrW>;
	Wed, 22 Aug 2001 14:47:22 -0400
Date: Wed, 22 Aug 2001 11:47:35 -0700 (PDT)
Message-Id: <20010822.114735.128125464.davem@redhat.com>
To: kakadu_croc@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: brlock_is_locked()?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010822183312.11829.qmail@web10908.mail.yahoo.com>
In-Reply-To: <20010822.112619.62651200.davem@redhat.com>
	<20010822183312.11829.qmail@web10908.mail.yahoo.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brad Chapman <kakadu_croc@yahoo.com>
   Date: Wed, 22 Aug 2001 11:33:12 -0700 (PDT)
   
   	It almost isn't. The problem starts when a third-party protocol
   module grabs BR_NETPROTO_LOCK, unloads itself from the networking stack,
   and then tries to call ip6_conntrack_protocol_unregister(). Deadlock.
   The problem is that we need TWO locks: the brlock to seal the network stack,
   and the conntrack rwlock to delete the protocol struct. Sure, you can
   always share the rwlock and leave it at that, but if all you need it for
   is to load/unload your protocol functions, then why bother polluting
   the symbol tables?
   	What do you think? Share the rwlock and make everybody who has
   the brlock just use the core function?

You are only showing me that there is potential a deficiency in the
netfilter interfaces.  You ought to discuss with the netfilter people
a way to make the interfaces work better.

This is exactly what I said needed to be done.

Later,
David S. Miller
davem@redhat.com

   
