Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272737AbRIGPrB>; Fri, 7 Sep 2001 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272732AbRIGPqw>; Fri, 7 Sep 2001 11:46:52 -0400
Received: from picard.csihq.com ([204.17.222.1]:31376 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S272737AbRIGPqo>;
	Fri, 7 Sep 2001 11:46:44 -0400
Message-ID: <04c301c137b4$34604590$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: <trond.myklebust@fys.uio.no>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <024f01c13601$c763d3c0$e1de11cc@csihq.com><shsae07md9d.fsf@charged.uio.no><033a01c1379e$e3514880$e1de11cc@csihq.com> <15256.56528.460569.700469@charged.uio.no>
Subject: Re: 2.4.8 NFS Problems
Date: Fri, 7 Sep 2001 11:46:05 -0400
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

But did you notice the network log:
07:02:07.481323 yeti.csihq.com.686186576 > picard.csihq.com.nfs: 1472 write
[|nfs] (frag 28948:1480@0+)
07:02:07.481446 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@1480+)
07:02:07.481569 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@2960+)
07:02:07.481692 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@4440+)
07:02:07.481814 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@5920+)
07:02:07.481886 yeti.csihq.com > picard.csihq.com: (frag 28948:916@7400)
07:02:07.482321 picard.csihq.com.nfs > yeti.csihq.com.686186576: reply ok
136 write [|nfs] (DF)
07:02:07.482511 yeti.csihq.com.702963792 > picard.csihq.com.nfs: 108 commit
[|nfs] (DF)
07:02:07.482642 picard.csihq.com.nfs > yeti.csihq.com.702963792: reply ok
128 commit (DF)

The file is being copied from yeti to picard.  Last packet seen is picard
telling yeti "OK" after the commit.
If soft timeouts were occurring shouldn't we be seeing packets from yeti
again with no response from picard?

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
Sent: Friday, September 07, 2001 10:42 AM
Subject: Re: 2.4.8 NFS Problems


>>>>> " " == Mike Black <mblack@csihq.com> writes:

     > But my timeouts were only 10 seconds -- well below the timeo
     > and retrans timeout periods.  And my network traffic shows that

According to the 'nfs' manpage, the default timeo on the mount in
util-linux is usually 0.7 seconds. retrans is 3.

  0.7 + 1.4 + 2.8 = 4.9 seconds < 10...

     > this is the client causing the problem NOT the server.  It's
     > the read() that pauses for 10 seconds and then the NFS write
     > immediately returns EIO.  So...I don't think soft mounts has
     > anything to do with it.

I think it does.

Cheers,
  Trond

