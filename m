Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbQJ3Wj3>; Mon, 30 Oct 2000 17:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbQJ3WjS>; Mon, 30 Oct 2000 17:39:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31617 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129371AbQJ3WjJ>;
	Mon, 30 Oct 2000 17:39:09 -0500
Date: Mon, 30 Oct 2000 14:24:46 -0800
Message-Id: <200010302224.OAA02266@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tleete@mountain.net
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <39FDF518.A9F1204D@mountain.net> (message from Tom Leete on Mon,
	30 Oct 2000 17:24:24 -0500)
Subject: Re: [PATCH] ipv4 skbuff locking scope
In-Reply-To: <39FDF518.A9F1204D@mountain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 30 Oct 2000 17:24:24 -0500
   From: Tom Leete <tleete@mountain.net>

   This fixes tests of a socket buffer done without holding the
   lock. tcp_data_wait() and wait_for_tcp_memory() both had
   unguarded refs in their sleep conditionals.

These are not buggy at all, see the discussion which took place here
over the past few days.

Look, if the sleep condition test "races" due to not holding the lock,
the schedule() just returns because if the sleep condidion test passes
then by definition this means we were also woken up, see?

BTW, while we're on the topic of people not understanding the
networking locking and proposing bogus patches, does anyone know who
sent the bogon IP tunneling locking "fixes" to Linus behind my back?

They were crap too, and I had to revert them in test10-pre7.  It's
another case of people just not understanding how the code works and
thus that it is correct without any changes.

Please send such fixes to me, and I'll set you straight with a
description as to why your change is unnecessary :-)

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
