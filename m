Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131462AbRARNTF>; Thu, 18 Jan 2001 08:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRARNS4>; Thu, 18 Jan 2001 08:18:56 -0500
Received: from chiara.elte.hu ([157.181.150.200]:2067 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131462AbRARNSh>;
	Thu, 18 Jan 2001 08:18:37 -0500
Date: Thu, 18 Jan 2001 14:18:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rick Jones <raj@cup.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101171428520.10628-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101181411530.823-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jan 2001, Linus Torvalds wrote:

> (I also had one person point out that BSD's have the notion of
> TCP_NOPUSH, which does almost what TCP_CORK does under Linux, except
> it doesn't seem to have the notion of uncorking - you can turn NOPUSH
> off, but apparently it doesn't affect queued packets. This makes it
> even less clear why they have the ugly sendfile)

this is what MSG_MORE does. Basically i added MSG_MORE for the purpose of
getting perfect TUX packet boundaries (and was ignorant enough to not know
about BSD's NOPUSH), without an additional system-call overhead, and
without the persistency of TCP_CORK. Alexey and David agreed, and actually
implemented it correctly :-)

basically if MSG_MORE is not set that means an explicit packet boundary in
the noncontended scenario. If MSG_MORE is set then that means all full-MSS
packets are queued, partial packets are not queued (but are timing out).
sendfile() uses the more flag internally - i've changed sendfile() in my
tree to specify the more flag from higher levels as well - eg. if a sent
file is embedded into other replies, or multiple files are sent.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
