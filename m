Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136532AbRAHGQR>; Mon, 8 Jan 2001 01:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132402AbRAHGQJ>; Mon, 8 Jan 2001 01:16:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40833 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136556AbRAHGPy>;
	Mon, 8 Jan 2001 01:15:54 -0500
Date: Sun, 7 Jan 2001 21:58:48 -0800
Message-Id: <200101080558.VAA02081@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: pwc@speakeasy.net
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101072217440.703-100000@localhost> (message from
	Paul Cassella on Sun, 7 Jan 2001 23:55:28 -0600 (CST))
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH: "No
 such process")
In-Reply-To: <Pine.LNX.4.21.0101072217440.703-100000@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sun, 7 Jan 2001 23:55:28 -0600 (CST)
   From: Paul Cassella <pwc@speakeasy.net>

   [1.] One line summary of the problem:

   write() returns -1 and sets errno non-sensically.  2.4.0{,-ac[23]}

What you describe I can only say is "impossible".

There are only four cases when _ANY_ part of the ipv4 networking stack
can return ESRCH.  These four cases are:

1) Adding a route
2) Deleting a route
3) Adding a FIB routing rule
3) Removing a FIB routing rule

None of them can occur via TCP socket writes (only netlink socket
operations or socket control calls).

Therefore I suspect you are perhaps getting rather some form of memory
corruption or similar, really, please search the networking code for
ESRCH value usage, you will see.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
