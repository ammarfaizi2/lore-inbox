Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSKTSq1>; Wed, 20 Nov 2002 13:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSKTSq1>; Wed, 20 Nov 2002 13:46:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50078 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262023AbSKTSqY>; Wed, 20 Nov 2002 13:46:24 -0500
Subject: Re: [NFS] Re: Non-blocking lock requests during the grace period ===> unlock
 during grace period?
To: Mike Kupfer <kupfer@athyra.eng.sun.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       trond.myklebust@fys.uio.no
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF20A29A8A.9BDEB891-ON87256C77.006712BE@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Wed, 20 Nov 2002 10:52:20 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 11/20/2002 11:53:25
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





OK, fair enough. I think I will withdraw my request to 'fix' this. If
Solaris and other falvors of Unix (i.e. Aix) behave this way I think it
would not be good to change just Linux.
The other minor change I proposed earlier was that we allow unlock
operations during the grace period, and this will be useful in clustered
NAS heads.
What do you guys think about such a change?

The main goal here would be to prevent unlock operations from being
unnecessarily delayed when a cluster node is taking over another node and
is being set to the grace
period.

Juan



|---------+---------------------------->
|         |           Mike Kupfer      |
|         |           <kupfer@athyra.en|
|         |           g.sun.com>       |
|         |                            |
|         |           11/20/02 10:23 AM|
|         |                            |
|---------+---------------------------->
  >-------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                         |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                            |
  |       cc:       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net, trond.myklebust@fys.uio.no                     |
  |       Subject:  Re: [NFS] Re: Non-blocking lock requests during the grace period                                        |
  |                                                                                                                         |
  |                                                                                                                         |
  >-------------------------------------------------------------------------------------------------------------------------|



>>>>> "Juan" == Juan Gomez <juang@us.ibm.com> writes:

    Juan> However, I feel it is odd to block a client for about one
    Juan> minutre when it issues "non-blocking" lock requests.

But if the server goes down, the call can end up blocking for
significantly longer than one minute anyway.

    Juan> I have seen that Solaris code does so but still feels odd
    Juan> and it may conflict with what most programmers expect

Perhaps, but there are other expectations to keep in mind.  In
particular, when using NFS, the expectation (at least with hard
mounts) is that when the server goes down, the application will simply
wait until the server comes back.  Your change would conflict with
that expectation.

Mike Kupfer                                            mike.kupfer@sun.com
Solaris File Sharing                                   Speaking for myself,
not for Sun.



