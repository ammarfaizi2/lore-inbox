Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318319AbSGRTsD>; Thu, 18 Jul 2002 15:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSGRTsC>; Thu, 18 Jul 2002 15:48:02 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:37628 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S318319AbSGRTsC>; Thu, 18 Jul 2002 15:48:02 -0400
Message-Id: <5.1.0.14.2.20020718124601.0910ba78@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 18 Jul 2002 12:50:48 -0700
To: "James Stevenson" <mistral@stev.org>,
       "Kevin Curtis" <kevin.curtis@farsite.co.uk>,
       <linux-kernel@vger.kernel.org>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: Closing a socket
In-Reply-To: <001701c22e85$240635b0$0501a8c0@Stev.org>
References: <7C078C66B7752B438B88E11E5E20E72E0EF451@GENERAL.farsite.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I have implemented a new socket address family and have noted that
> > from a multi-threaded application, if a thread calls close(fd) while a
> > second thread has a blocking read outstanding, the sockets release() is not
> > called.  Is this correct?  How can one unblock the read in order to do the
> > close.
You might want to implement shutdown(). Thread #1 will call shutdown() 
instead of
the close(). Your shutdown() implementation can do something like:
         sk->shutdown |= RCV_SHUTDOWN;
         sk->state_change(sk);
So, reader will wakeup, check shutdown mask and return error because socket was
shut down.

Max


