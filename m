Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129567AbQKJKNs>; Fri, 10 Nov 2000 05:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129578AbQKJKN2>; Fri, 10 Nov 2000 05:13:28 -0500
Received: from [62.254.209.2] ([62.254.209.2]:2811 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S129567AbQKJKNY>;
	Fri, 10 Nov 2000 05:13:24 -0500
Date: Fri, 10 Nov 2000 10:13:21 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Missing ACKs with Linux 2.2/2.4?
In-Reply-To: <200011100020.QAA00913@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0011100951300.11412-100000@artemis.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, David S. Miller wrote:

>    Any ideas whats going on? I'm no expert at reading tcpdumps, if
>    anyone can shed some light on the problem, I'd be most greatful.
>
> Anything less than ~2.2.16 are about as buggy as they come wrt. TCP
> Please upgrade ;-)

A fair point! But I still can't see what the server is doing wrong,
which makes it look like the clients (inc 2.4.0-test10) are misbehaving.

> Something is wrong with the Cobalt side, for sure:
>
> 10:10:15.845869 cobalt-box.echo > hydra.3700: . ack 8681 win 30408 <nop,nop,timestamp 15607469 268081752> (DF)
>
> Cobalt sends the ACK, everything is fine.
>
> 10:10:18.836367 cobalt-box.echo > hydra.3700: P 1:1449(1448) ack 8681 win 31856 <nop,nop,timestamp 15607768 268081752> (DF)
>
> Cobalt then waits for 3 seconds to send data bytes 1:1449
> (ie. the echo service response).

This is a resend of the data sent on line 8 of the trace:

10:10:15.845002 cobalt-box.echo > hydra.3700: P 1:1449(1448) ack 1449 win 31856 <nop,nop,timestamp 0 268081751> (DF)

It looks like hydra didn't ACK this data, so the server eventually
re-sent it?


Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
