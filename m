Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUJCTfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUJCTfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUJCTfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 15:35:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:36298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268092AbUJCTfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 15:35:16 -0400
Date: Sun, 3 Oct 2004 12:32:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ed Schouten" <ed@il.fontys.nl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [Patch] nfsd: Insecure port warning shows decimal IPv4 address
Message-Id: <20041003123254.4de22bfa.akpm@osdl.org>
In-Reply-To: <56986.217.121.83.210.1096826639.squirrel@217.121.83.210>
References: <56986.217.121.83.210.1096826639.squirrel@217.121.83.210>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ed Schouten" <ed@il.fontys.nl> wrote:
>
> Made a quick patch that changes dmesg(8) output to show IPv4 addresses in
>  decimal form instead of hexadecimal when you receive an insecure port
>  warning.
>  ---
> 
>   nfsfh.c |    7 +++++--
>   1 files changed, 5 insertions(+), 2 deletions(-)
> 
>  --- linux-2.6.9-rc3/fs/nfsd/nfsfh.c	2004-09-30 05:04:26.000000000 +0200
>  +++ linux-2.6.9-rc3-xbox/fs/nfsd/nfsfh.c	2004-10-03 19:29:39.711659000 +0200
>  @@ -153,8 +153,11 @@
>   		error = nfserr_perm;
>   		if (!rqstp->rq_secure && EX_SECURE(exp)) {
>   			printk(KERN_WARNING
>  -			       "nfsd: request from insecure port (%08x:%d)!\n",
>  -			       ntohl(rqstp->rq_addr.sin_addr.s_addr),
>  +			       "nfsd: request from insecure port (%d.%d.%d.%d:%d)!\n",
>  +			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr) >> 24),
>  +			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr) >> 16),
>  +			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr) >> 8),
>  +			       (unsigned char)(ntohl(rqstp->rq_addr.sin_addr.s_addr)),
>   			       ntohs(rqstp->rq_addr.sin_port));
>   			goto out;
>   		}

There's a NIPQUAD macro to make this a bit tidier.
