Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130349AbRAJBUC>; Tue, 9 Jan 2001 20:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbRAJBTw>; Tue, 9 Jan 2001 20:19:52 -0500
Received: from chiara.elte.hu ([157.181.150.200]:47372 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130349AbRAJBTj>;
	Tue, 9 Jan 2001 20:19:39 -0500
Date: Wed, 10 Jan 2001 02:19:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dave Zarzycki <dave@zarzycki.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091708410.1796-100000@batman.zarzycki.org>
Message-ID: <Pine.LNX.4.30.0101100217460.12258-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Dave Zarzycki wrote:

> In user space, how do you know when its safe to reuse the buffer that
> was handed to sendmsg() with the MSG_NOCOPY flag? Or does sendmsg()
> with that flag block until the buffer isn't needed by the kernel any
> more? If it does block, doesn't that defeat the use of non-blocking
> I/O?

sendmsg() marks those pages COW and copies the original page into a new
one for further usage. (the old page is used until the packet is
released.) So for maximum performance user-space should not reuse such
buffers immediately.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
