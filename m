Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJBc0>; Tue, 9 Jan 2001 20:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJBcR>; Tue, 9 Jan 2001 20:32:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1162 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129406AbRAJBcM>;
	Tue, 9 Jan 2001 20:32:12 -0500
Date: Tue, 9 Jan 2001 17:14:51 -0800
Message-Id: <200101100114.RAA07780@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: dave@zarzycki.org
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091708410.1796-100000@batman.zarzycki.org>
	(message from Dave Zarzycki on Tue, 9 Jan 2001 17:14:33 -0800 (PST))
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091708410.1796-100000@batman.zarzycki.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 9 Jan 2001 17:14:33 -0800 (PST)
   From: Dave Zarzycki <dave@zarzycki.org>

   On Tue, 9 Jan 2001, Ingo Molnar wrote:

   > then you'll love the zerocopy patch :-) Just use sendfile() or specify
   > MSG_NOCOPY to sendmsg(), and you'll see effective memory-to-card
   > DMA-and-checksumming on cards that support it.

   I'm confused.

   In user space, how do you know when its safe to reuse the buffer that was
   handed to sendmsg() with the MSG_NOCOPY flag? Or does sendmsg() with that
   flag block until the buffer isn't needed by the kernel any more? If it
   does block, doesn't that defeat the use of non-blocking I/O?

Ignore Ingo's comments about the MSG_NOCOPY flag, I've not included
those parts in the zerocopy patches as they are very controversial
and require some VM layer support.

Basically, it pins the userspace pages, so if you write to them before
the data is fully sent and the networking buffer freed, they get
copied with a COW fault.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
