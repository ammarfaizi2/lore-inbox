Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276824AbRJPWrU>; Tue, 16 Oct 2001 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276829AbRJPWrD>; Tue, 16 Oct 2001 18:47:03 -0400
Received: from [204.177.156.37] ([204.177.156.37]:36859 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S276824AbRJPWqs>; Tue, 16 Oct 2001 18:46:48 -0400
Message-ID: <013601c156f9$e0a35310$3291b40a@fserv2000.net>
From: "Shirish Kalele" <kalele@veritas.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: NFSD over TCP: TCP broken?
Date: Wed, 17 Oct 2001 03:52:55 -0700
Organization: Veritas Software Corporation
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I've been looking at running nfsd over tcp on Linux. I modified the #ifdef
> so that nfsd uses tcp. I also made writes to the socket blocking, so that
> the thread blocks till the entire reply has been accepted by TCP. (I know
> the right way is going to be to have an independent thread whose job would
> be to just pick replies off a queue and block on sending them to tcp, but
> this is what I've done temporarily.)
>
> Then I tried to copy a directory from a Solaris client to the Linux server
> using nfsv3 over tcp. This took a long time, with lots of delays where
> nothing was being transferred.
>
> Looking at the network traces, it looks like the RPC records being sent
over
> TCP are inconsistent with the lengths specified in the record marker. This
> happens mainly when 3-4 requests arrive one after the other and you have
3-4
> threads replying to these requests in parallel. It looks like TCP gets
> hopelessly confused and botches up the replies being sent. I point my
finger
> at TCP because tcp_sendmsg returns a valid length indicating that the
entire
> reply was accepted, but the tcp sequence numbers show that the RPC record
> sent on the wire wasn't equal to the length accepted by TCP. After a
while,
> the client realizes it's out of sync when it gets an invalid RPC record
> marker, and resets and reconnects. This repeats multiple times.
>
> Is TCP known to break when multiple threads try to send data down the pipe
> simulaneously? Is there a known fix for this? Where should I be focussing
to
> fix the problem?
>
> I'm not on the list, so please include me in replies.
>
> Thanks,
> Shirish
>
>

