Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313996AbSDZNPE>; Fri, 26 Apr 2002 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314029AbSDZNPD>; Fri, 26 Apr 2002 09:15:03 -0400
Received: from pat.uio.no ([129.240.130.16]:50133 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S313996AbSDZNPC>;
	Fri, 26 Apr 2002 09:15:02 -0400
To: Dan Yocum <yocum@fnal.gov>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor NFS client performance on 2.4.18?
In-Reply-To: <3CC86BDC.C8784EA2@fnal.gov>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 26 Apr 2002 15:14:56 +0200
Message-ID: <shsu1pyppnz.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dan Yocum <yocum@fnal.gov> writes:

     > Trond, et al.  I'm getting poor NFS performance (~250KBps read
     > and write) on 2.4.18 and am wondering if I'm the only one.
     > There is no performance drop under other OSs or other kernel
     > versions, so I don't think it's the server.

     > Here's the the details:

     > 2.4.18 patched with:
     > 	NFS client patches (linux-2.4.18-NFS_ALL.dif)
     > 	xfs-1.1-PR1-2.4.18-all.patch Ingo's Foster IRQ patch (these
     > 	are dual Xeons)

     > If you need any more details, let me know.

The latest NFS_ALL patches include experimental code that changes the
UDP congestion control. I'm basically trying to relax the algorithm to
what is standard on *BSD (i.e. we follow the standard Van Jacobson).

This would mean that we don't wait for the reply from the server
before we send off the next request. Unfortunately, there appears to
be a lot of setups out there that start to drop packets when this
occurs, and I haven't yet finished determining the root cause.

If I can manage to get my laptop to work again, I'll try to
investigate a bit more this weekend...

Cheers,
  Trond
