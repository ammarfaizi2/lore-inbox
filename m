Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130382AbQLIOrz>; Sat, 9 Dec 2000 09:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbQLIOrp>; Sat, 9 Dec 2000 09:47:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46728 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130382AbQLIOrl>;
	Sat, 9 Dec 2000 09:47:41 -0500
Date: Sat, 9 Dec 2000 06:00:42 -0800
Message-Id: <200012091400.GAA17948@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: torvalds@transmeta.com
CC: viro@math.psu.edu, dwmw2@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012082356020.2121-100000@penguin.transmeta.com>
	(message from Linus Torvalds on Sat, 9 Dec 2000 00:45:51 -0800 (PST))
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <Pine.LNX.4.10.10012082356020.2121-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sat, 9 Dec 2000 00:45:51 -0800 (PST)
   From: Linus Torvalds <torvalds@transmeta.com>

    out:
   -	if (nr) {
   -		ll_rw_block(WRITE, nr, arr);
   -	} else {
   -		UnlockPage(page);
   -	}
   +	UnlockPage(page);
	   ClearPageUptodate(page);
	   return err;
    }
   @@ -1669,7 +1665,6 @@

It would seem that you would want to unlock the page _after_ clearing
the uptodate bit to make sure people sleeping on the page do not see
it set by accident.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
