Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSGHS1v>; Mon, 8 Jul 2002 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSGHS1t>; Mon, 8 Jul 2002 14:27:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17546 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317056AbSGHS1o>; Mon, 8 Jul 2002 14:27:44 -0400
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: Implementing a sockets address family
To: kevin.curtis@farsite.co.uk
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF5F5EDA05.82664358-ON88256BF0.0063E825@boulder.ibm.com>
Date: Mon, 8 Jul 2002 11:29:01 -0700
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 07/08/2002 12:29:04 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
>         thanks for the reply.  From an application point of view, when a
> socket is created it is non-blocking by default.  If the application uses
> ioctl or fcntl to set the socket to non-blocking mode, then all I was
saying
> was I don't see any indication in flags or msghdr->flags as to whether
the
> user wants to wait for the recv to complete or not.  How is my recvmsg()
> function in my implementation of the new address family supposed to
> differentiate.  I cannot see any reference to O_NONBLOCK or
> MSG_DONTWAIT in the tcp_recvmsg() function.

If its non blocking, nonblock is 1, and the function sock_rcvtimeo()
sets timeo to 0. If there isnt any data to read, copied is set to -EAGAIN,
we break out of the big do loop,  pretty much fall through the rest of the
function and return copied.

thanks,
Nivedita


