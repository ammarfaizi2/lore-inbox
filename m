Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263311AbSJFEYw>; Sun, 6 Oct 2002 00:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263312AbSJFEYw>; Sun, 6 Oct 2002 00:24:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6282 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263311AbSJFEYw>;
	Sun, 6 Oct 2002 00:24:52 -0400
Date: Sat, 05 Oct 2002 21:23:55 -0700 (PDT)
Message-Id: <20021005.212355.122592301.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D9F46A2.6050004@candelatech.com>
References: <Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au>
	<20021004.181537.104336257.davem@redhat.com>
	<3D9F46A2.6050004@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Sat, 05 Oct 2002 13:08:02 -0700
   
   With raw ethernet packets, sent from user-space, at around 40Mbps bi-directional,
   I see loads of these messages:
   
   tg3: eth3: Error, poll already scheduled

This, frankly, isn't possible.

When we get the first interrupt, we hold the spinlock and have IRQs
disabled, in that environment we invoke netif_rx_schedule_prep(dev)
and then disable device interrupts....

is the tg3 sharing it's IRQ with something else?  That might be
an important clue.  In that case what you report might be possible.

Otherwise the message you see appears to be totally impossible.
