Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263461AbRFTWtL>; Wed, 20 Jun 2001 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263557AbRFTWtB>; Wed, 20 Jun 2001 18:49:01 -0400
Received: from va.cs.wm.edu ([128.239.2.31]:42254 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S263461AbRFTWsv>;
	Wed, 20 Jun 2001 18:48:51 -0400
Date: Wed, 20 Jun 2001 18:48:52 -0400 (EDT)
From: Bob Matthews <bob@CS.WM.EDU>
To: <linux-kernel@vger.kernel.org>
Subject: [QUESTION]: sk->data_ready/state_change callbacks in struct sock
Message-ID: <Pine.LNX.4.33.0106201812040.11104-100000@me.cs.wm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a couple of questions about TCP code that I'm hoping someone
could answer.  I have a kernel thread with a struct sock waiting for a
state_change callback, but the callback is never getting, well, called
back.

When I setup the socket, I do the following steps

sock_create (new_socket, ...)
setup the sin structure
new_socket->ops->bind (new_socket, (struct sockaddr_in *) sin, ...)
new_socket->ops->listen (new_socket, ...)

I then setup the callbacks:

new_socket->sk->state_change = foo;
new_socket->sk->data_ready = bar;

At this point, everything in new_socket and new_socket->sk looks OK to me.

When I try and send data to the socket from the other end, however,
neither of these callbacks is ever activated.

So, here are my questions:

- My understanding from the code is that sk->state_change is called when a
struct sock transits from SYN_RCVD to ESTABLISHED and from ESTABLISHED to
{CLOSE_WAIT,FIN_WAIT_1}.  Is this correct?

- sk->data_ready is called whenever any new data is deposited in the
associated sk_buff.  Is this correct?

Bob





-- 


