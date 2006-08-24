Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422704AbWHXVgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWHXVgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWHXVgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:36:41 -0400
Received: from pat.uio.no ([129.240.10.4]:48826 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422698AbWHXVgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:36:36 -0400
Subject: Re: Why will NFS client spend so much time on file open?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608240015v6078fc29r287601aad7a2f1dc@mail.gmail.com>
References: <4ae3c140608240015v6078fc29r287601aad7a2f1dc@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:36:28 -0400
Message-Id: <1156455388.5629.85.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.837, required 12,
	autolearn=disabled, AWL 0.65, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 03:15 -0400, Xin Zhao wrote:
> Hi,
> 
> I did Apache benchmark and collected the performance results at the
> file system call level.
> The microbenchmark results were collected when I did "make" on Apache
> source code.
> 
> The results are very interesting:
> 
> 		      open	        read		
> Total Time (s)  21.599 	         15.948 											Count		   310274 	
>  98028 											Time/Call (ms)	69.61 	         162.69
> 
> The results show that NFS spent even more time on file open than on
> file read. But this result confuses me: what does NFS do to open a
> file? As far as I know, it just issues a lookup() RPC to get file
> handle, and maybe a getattr() RPC to get file attributes. This should
> not take so much time. Can someone explain why this could happen?

It is impossible to tell without more information.

Are these all open() for read, or are you mixing in other stuff like
O_CREAT, O_TRUNC and/or O_EXCL? All of those flags will have an impact
on the open() latency.

What is your expectation w.r.t. read cache misses? Is the read cache
always guaranteed to be cold on every call to read(), or is your test
cycling through the same data over and over again so that the caches are
kept hot?

Cheers,
  Trond

