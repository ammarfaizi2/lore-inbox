Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135449AbRAVWG2>; Mon, 22 Jan 2001 17:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135482AbRAVWGS>; Mon, 22 Jan 2001 17:06:18 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:22535 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S135449AbRAVWGH>; Mon, 22 Jan 2001 17:06:07 -0500
Date: Mon, 22 Jan 2001 14:04:35 -0800
Message-Id: <200101222204.f0MM4Zv09976@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: David Lang <dlang@diginsite.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Val Henson <vhenson@esscom.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.31.0101221159120.29530-100000@dlang.diginsite.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001 12:01:23 -0800 (PST), David Lang <dlang@diginsite.com> wrote:
> how about always_defragment (or whatever the option is now called) so that
> your routing box always reassembles packets and then fragments them to the
> correct size for the next segment? wouldn't this do the job?

It doesn't help with TCP, because the negotiated MSS will always be 1500
and thus there won't be any fragments to re-assemble.

>  On Mon, 22 Jan 2001, Val Henson wrote:
>
>> Well, there is a (real-world) case where your TCP proxy doesn't want
>> to look at the data and you can't use IP forwarding.  If you have TCP
>> connections between networks that have very different MTU's, using IP
>> forwarding will result in tiny packets on the large MTU networks.

There is another real-world case: a load-balancing proxy. socket->socket
sendfile would allow the proxy to open a non-keepalive connection to the
backend server, send the request, and then just link the two sockets
together using sendfile.

Of course, some changes would have to be made to the API. An asynchronous
sendsocket()/sendfile() system call would be just lovely, in fact. :-)


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
