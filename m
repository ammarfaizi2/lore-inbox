Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130148AbRBSNkD>; Mon, 19 Feb 2001 08:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130390AbRBSNjx>; Mon, 19 Feb 2001 08:39:53 -0500
Received: from nnj-dialup-61-93.nni.com ([216.107.61.93]:3264 "EHLO
	nnj-dialup-61-93.nni.com") by vger.kernel.org with ESMTP
	id <S130148AbRBSNjr>; Mon, 19 Feb 2001 08:39:47 -0500
Date: Mon, 19 Feb 2001 08:38:43 -0500 (EST)
From: TenThumbs <tenthumbs@cybernex.net>
Reply-To: TenThumbs <tenthumbs@cybernex.net>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19pre13: Are there network problem with a low-bandwidth link?
Message-ID: <Pine.LNX.4.21.0102190828120.190-100000@perfect.master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I am a) using modem ppp connection and b) downloading a file from a
reasonably fast server so that the incoming connection is saturated,
then attempting to open a new network tcp connection while this is going
on fails quite regularly. The user app gets a ECONNRESET error.

Investigation shows that the kernel opens a tcp socket, moves the
connection to the syn_sent state, and gets a response (delayed because
the incoming traffic has saturated the link). The kernel then reports a
bad segment, drops the connection, and tries again. Eventually the
kernel gives up and returns the error.

This never happens if the link is idle or lightly loaded. Heavy load is
extremely important.

I normally use an old Hayes ESP card for the modem, but I've tried a
normal UART and the same thing happens.

I do not see this in 2.2.18. I didn't see this in 2.2.19pre8 but, going
back, there are bad segments but they are not frequent. In pre10 this
behavior is very noticeable and it continues in pre13.

Is there really a problem or am I having orher problems?

Thanks.

-- 
Mars
    2001-02-19 13:28:16.590 UTC (JD 2451960.061303)
    X  =  -1.468251565, Y  =  -0.627505988, Z  =  -0.247957428 (au)
    X' =   0.006352326, Y' =  -0.010425935, Z' =  -0.004953649 (au/d)

