Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTFJKGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFJKE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:04:27 -0400
Received: from engels.cs.rhbnc.ac.uk ([134.219.188.10]:23557 "EHLO
	engels.cs.rhbnc.ac.uk") by vger.kernel.org with ESMTP
	id S261589AbTFJKDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:03:32 -0400
Date: Tue, 10 Jun 2003 11:17:07 +0100 (BST)
From: Bob Vickers <bobv@cs.rhul.ac.uk>
X-X-Sender: bobv@sartre.cs.rhbnc.ac.uk
Reply-To: Bob Vickers <R.Vickers@cs.rhul.ac.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Bob Vickers <R.Vickers@cs.rhul.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Locking NFS files on kernels 2.4.19 and 2.4.20
In-Reply-To: <shsd6hnrxky.fsf@charged.uio.no>
Message-ID: <Pine.OSF.4.44.0306101106250.9121-100000@sartre.cs.rhbnc.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Trond,

Thank you very very much, that is it! rpc.statd was running on the server
but not the client. I have started it and it now works.

The stupid thing is I was really close to seeing this weeks ago, but got
confused by various ancient pieces of documentation and by the fact
that you don't need rpc.lockd any more because lockd is now part of the
kernel.

And the high-level message is: starting SuSE 8.1 you need to type
   chkconfig nfslock on
if you want NFS locking to work on the client. And probably on the server
too.

Bob

 On 9 Jun 2003, Trond Myklebust wrote:

> >>>>> " " == Bob Vickers <bobv@cs.rhul.ac.uk> writes:
>
>      > I have recently upgraded some machines and have found that it
>      > is no longer possible to lock files on NFS file systems. It is
>      > definitely a client-side problem: upgraded clients could no
>      > longer lock files on *any* NFS server (including Tru64 as well
>      > as a variety of Linux servers).
>
> Two questions:
>
>   Are you running statd on the client and server?
>
> if no, then you should...
>
>   Does SuSE compile statd with or without the RESTRICTED_STATD flag?
>
> If the latter, then you'll need an extra kernel patch in order to
> allow the kernel NSM to use a reserved port. Something like the
> appended scheme...
>
> Cheers,
>   Trond
>


==============================================================
Bob Vickers                     R.Vickers@cs.rhul.ac.uk
Dept of Computer Science, Royal Holloway, University of London
WWW:    http://www.cs.rhul.ac.uk/home/bobv
Phone:  +44 1784 443691

