Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRJBLct>; Tue, 2 Oct 2001 07:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRJBLcj>; Tue, 2 Oct 2001 07:32:39 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:61163 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S271712AbRJBLcV>; Tue, 2 Oct 2001 07:32:21 -0400
Date: Tue, 2 Oct 2001 12:32:49 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: "H. Peter Anvin" <hpa@transmeta.com>, <alan@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: NFSv3 and linux-2.4.10-ac3 => oops
In-Reply-To: <shszo7a4bxp.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0110021227340.31037-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if this is related to oopses I sent in in the last two days?
We're running 4GB setups with NFSv3 client and server on our fileservers,
and the oopses might (don't really have strong correlation evidence yet)
be related to when our fileservers push online backups to cheaper NFS
servers (running the same kernel based on 2.4.9-ac10). Is there a last
known good kernel I can try on my production systems while I try to
reproduce the problem on smaller boxes? Or would you like me to try your
patch?

Matt

At 11:40 +0200 Trond Myklebust wrote:

>>>>>> " " == H Peter Anvin <hpa@transmeta.com> writes:
>
>     > Hello everyone, I have a reproducible (and rather quick) oops
>     > on a system running linux-2.4.10-ac3, which seems to be NFS
>     > (v3) related; although ksymoops core dumps when I try to use
[snip]
>     > ftp://ftp.zytor.com/pub/hpa/oops/
>
>I'm trying to look at this, but it seems a hopeless mess: there are no
>calls to any read/write semaphore routines in the NFS code.
>
>AFAICS the second stack return point corresponds to the call to
>generic_file_write() in nfs_file_write(), so I'd guess that the Oops
>is actually happening somewhere there...
>
>Hmm... Looking at the code in generic_file_write(), I see that Alan
>hasn't merged in the kmap() stuff in generic_file_write()from
>Linus. At the same time, the nfs_prepare_write() seems to have been
>synced with Linus, and so the kmap() that used to be there has
>disappeared.

