Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUDEGzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 02:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUDEGzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 02:55:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:60351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262085AbUDEGzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 02:55:36 -0400
Date: Sun, 4 Apr 2004 23:55:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm1 [PATCH]
Message-Id: <20040404235526.09ff3c39.akpm@osdl.org>
In-Reply-To: <1081147276.1374.13.camel@orca.madrabbit.org>
References: <1081147276.1374.13.camel@orca.madrabbit.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee <ray-lk@madrabbit.org> wrote:
>
> Could I suggest an alternate version, below? It limits the knowledge of
>  the CONFIG_QUOTA option to the quota header file, and still shrinks the
>  inode by two pointers. The only functional difference between this and
>  Matt Mackall's version is the below will still leave in a call to
>  memset, but with a zero length. On the plus side, it keeps fs/inode.c
>  free of preprocessor noise, which seems worth the trade-off.
> 
>   quota.h |    4 ++++
>   1 files changed, 4 insertions(+)
> 
>  diff -NurX ../dontdiff linus-2.6/include/linux/quota.h linus-2.6-inode-shrinkage/include/linux/quota.h
>  --- linus-2.6/include/linux/quota.h	2004-04-03 08:46:35.000000000 -0800
>  +++ linus-2.6-inode-shrinkage/include/linux/quota.h	2004-04-03 08:45:19.000000000 -0800
>  @@ -57,7 +57,11 @@
>   #define kb2qb(x) ((x) >> (QUOTABLOCK_BITS-10))
>   #define toqb(x) (((x) + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS)
>   
>  +#ifdef CONFIG_QUOTA
>   #define MAXQUOTAS 2
>  +#else
>  +#define MAXQUOTAS 0
>  +#endif

The advantage of the ifdeffy one is that if someone accesses i_dquot
outside CONFIG_QUOTA, they get a compile failure rather than runtime inode
corruption.
