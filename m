Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRARNah>; Thu, 18 Jan 2001 08:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135652AbRARNa1>; Thu, 18 Jan 2001 08:30:27 -0500
Received: from chiara.elte.hu ([157.181.150.200]:3603 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135554AbRARNaL>;
	Thu, 18 Jan 2001 08:30:11 -0500
Date: Thu, 18 Jan 2001 14:29:44 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rick Jones <raj@cup.hp.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <3A661A00.E3344A18@cup.hp.com>
Message-ID: <Pine.LNX.4.30.0101181422180.823-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jan 2001, Rick Jones wrote:

> certainly, i see by your examples how cork can make life easier on the
> developer - they can putc() the reply if they want. for a persistent
> http connection, there would be the cork and uncork each time, for a
> pipelined connection, it is basically a race - how does the client
> present requests to the connection, what are the speeds of that
> connection relative to the speed of the server getting replies into
> the socket that sort of thing.

such dynamic properties should IMO never become visible to user-space
interfaces i believe. TCP_CORK/MSG_MORE (which are both the same thing, in
a different interface) are a way to specify logical neighborhood of
app-side SENDs. I believe the most sensible and generic thing to do is to
require MSG_MORE information from the application: 'is it likely that the
application is going to SEND something soon, or not?'.

Submitting an exact timetable of planned future SENDs (with a fully
specified probability distribution of every expected future SEND event)
would be the most informative thing to do, but this is not very practical.

Basically MSG_MORE is a simplified probability distribution of the next
SEND, and it already covers all the other (iovec, nagle, TCP_CORK)
mechanizm available, in a surprisingly easy way IMO. I believe MSG_MORE is
very robust from a theoreticaly point of view.

To use this information to judge saturation situations properly is
completely up to the stack.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
