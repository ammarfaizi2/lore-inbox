Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbQJaESC>; Mon, 30 Oct 2000 23:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbQJaERw>; Mon, 30 Oct 2000 23:17:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35201 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130150AbQJaERp>;
	Mon, 30 Oct 2000 23:17:45 -0500
Date: Mon, 30 Oct 2000 20:03:24 -0800
Message-Id: <200010310403.UAA05384@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tleete@mountain.net
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <39FE39EF.62CC880B@mountain.net> (message from Tom Leete on Mon,
	30 Oct 2000 22:18:07 -0500)
Subject: Re: [PATCH] ipv4 skbuff locking scope
In-Reply-To: <39FDF518.A9F1204D@mountain.net> <200010302224.OAA02266@pizda.ninka.net> <39FE39EF.62CC880B@mountain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 30 Oct 2000 22:18:07 -0500
   From: Tom Leete <tleete@mountain.net>

   > Look, if the sleep condition test "races" due to not holding the
   > lock, the schedule() just returns because if the sleep condidion
   > test passes then by definition this means we were also woken up,
   > see?

   Would you explain what is accomplished by toggling the lock every
   time through? What breaks by not doing so?

Incoming packets are not processed while the lock is held, they
get queued to the backlog.  When the lock is released, the backlog
packets get processed.

For a TCP sender, these backlog packets are ACKs making room in the
send buffer so that the application can put more data into the send
buffer.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
