Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272631AbRIGNOq>; Fri, 7 Sep 2001 09:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272640AbRIGNOg>; Fri, 7 Sep 2001 09:14:36 -0400
Received: from picard.csihq.com ([204.17.222.1]:11407 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S272631AbRIGNOZ>;
	Fri, 7 Sep 2001 09:14:25 -0400
Message-ID: <033a01c1379e$e3514880$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <024f01c13601$c763d3c0$e1de11cc@csihq.com> <shsae07md9d.fsf@charged.uio.no>
Subject: Re: 2.4.8 NFS Problems
Date: Fri, 7 Sep 2001 09:13:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But my timeouts were only 10 seconds -- well below the timeo and retrans
timeout periods.
And my network traffic shows that this is the client causing the problem NOT
the server.
It's the read() that pauses for 10 seconds and then the NFS write
immediately returns EIO.
So...I don't think soft mounts has anything to do with it.
Also...I've now seen this error once more even with the 4096 read/write
sizes.
________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Friday, September 07, 2001 7:49 AM
Subject: Re: 2.4.8 NFS Problems


>>>>> " " == Mike Black <mblack@csihq.com> writes:

     > I've been getting random NFS EIO errors for a few months but
     > now it's repeatable.  Trying to copy a large file from one
     > 2.4.8 SMP box to another is consistently failing (at different
     > offsets each time).  This doesn't appear to be a network
     > problem as the last comm between the machines looks OK.  By the
     > timestamps it appears that a read() is taking too long and
     > causing a timeout?

Morale: Don't use soft mounts: they are prone to these things. If you
insist on using them, then try playing around with the `timeo' and
`retrans' mount variables.

Soft mount timeouts are not only due to network problems, but can
equally well be due to internal congestion. The rate at which the
network can transmit requests is usually (unless you are using
Gigabit) way below the rate at which your machine can generate them.

Cheers,
   Trond

