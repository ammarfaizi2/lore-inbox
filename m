Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRIHLxi>; Sat, 8 Sep 2001 07:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbRIHLx3>; Sat, 8 Sep 2001 07:53:29 -0400
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:1441 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S269099AbRIHLxT>; Sat, 8 Sep 2001 07:53:19 -0400
Message-ID: <022001c1385c$e536b900$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: <trond.myklebust@fys.uio.no>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <024f01c13601$c763d3c0$e1de11cc@csihq.com><shsae07md9d.fsf@charged.uio.no><033a01c1379e$e3514880$e1de11cc@csihq.com><15256.56528.460569.700469@charged.uio.no><04c301c137b4$34604590$e1de11cc@csihq.com> <15257.63655.764646.844202@charged.uio.no>
Subject: Re: 2.4.8 NFS Problems
Date: Sat, 8 Sep 2001 07:53:36 -0400
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

Did some more testing this A.M.

Soft Mount:
    Took me several tries -- had to run a tiobench on the server side to
make for some I/O contention.  Was able to get EIO error (since this is Sat
the system was pretty idle).
Hard Mount:
    Unable to reproduce even though 10 second timeouts could be seen.
Soft Mount (retrans=5)
    Unable to reproduce

Could be the interaction with ext3 where I/O gets bound up a while.  Just
long enough to trigger the timeouts for a soft mount.
----- Original Message -----
From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Saturday, September 08, 2001 6:53 AM
Subject: Re: 2.4.8 NFS Problems


> >>>>> " " == Mike Black <mblack@csihq.com> writes:
>
>      > The file is being copied from yeti to picard.  Last packet seen
>      > is picard telling yeti "OK" after the commit.  If soft timeouts
>      > were occurring shouldn't we be seeing packets from yeti again
>      > with no response from picard?
>
> You are assuming that the last packet seen is the one that corresponds
> to your read. In doing so, you are neglecting the fact that these are
> asynchronous reads, and that file readahead can muddle the waters for
> you.
>
> Look, this is getting us nowhere. The bottom line is: if you are able
> to reproduce the EIO on hard mounts it is a bug, and I'll be happy to
> help you trace it. If it is occuring only on soft mounts, it is user
> error...
>
> Cheers,
>   Trond
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

