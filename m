Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267020AbSKSR7q>; Tue, 19 Nov 2002 12:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267025AbSKSR7q>; Tue, 19 Nov 2002 12:59:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:32453 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267020AbSKSR7n>; Tue, 19 Nov 2002 12:59:43 -0500
Subject: Re: [NFS] Re: Non-blocking lock requests during the grace period
To: mike.kupfer@sun.com
Cc: kupfer@athyra.eng.sun.com, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, trond.myklebust@fys.uio.no
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFB5AB2A91.F36007C8-ON87256C76.00632179@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Tue, 19 Nov 2002 10:06:11 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 11/19/2002 11:07:16
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Mike,

I agree with the F_GETLK part, as I pointed out to Trond earlier. However,
I feel it is odd to block a client for about one minutre when it issues
"non-blocking" lock requests. I have seen that Solaris code does so but
still feels odd and it may conflict with what most programmers expect,
though I see your point, perhaps if this was well documented in man pages
there would not be a problem. In Linux this is not the case.


Juan





|---------+---------------------------->
|         |           mike.kupfer@sun.c|
|         |           om               |
|         |           Sent by:         |
|         |           kupfer@athyra.eng|
|         |           .sun.com         |
|         |                            |
|         |                            |
|         |           11/18/02 05:04 PM|
|         |                            |
|---------+---------------------------->
  >-------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                         |
  |       To:       trond.myklebust@fys.uio.no                                                                              |
  |       cc:       Juan Gomez/Almaden/IBM@IBMUS, linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net                   |
  |       Subject:  Re: [NFS] Re: Non-blocking lock requests during the grace period                                        |
  |                                                                                                                         |
  |                                                                                                                         |
  >-------------------------------------------------------------------------------------------------------------------------|



>>>>> "Trond" == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>>>>> " " == Juan Gomez <juang@us.ibm.com> writes:

    >> (note that F_GETLK man page does not provide EAGAIN as a
    >> possible error code).

F_GETLK indicates a conflict by changing the arg struct to show the
conflicting lock.

As for the original topic, I would hesitate before changing the client
locking code to return EAGAIN just because the server is in its grace
period.  The "blocking" or "non-blocking" behavior is tied to what
happens when there is already a lock that conflicts with the requested
one.  When the server is in the grace period, it's unknown as to
whether there is already a lock that conflicts with the requested
one.

Mike Kupfer                                            mike.kupfer@sun.com
Solaris File Sharing                                   Speaking for myself,
not for Sun.





