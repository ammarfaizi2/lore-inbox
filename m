Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262794AbSJRCZW>; Thu, 17 Oct 2002 22:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSJRCZW>; Thu, 17 Oct 2002 22:25:22 -0400
Received: from zero.aec.at ([193.170.194.10]:33039 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262794AbSJRCZV>;
	Thu, 17 Oct 2002 22:25:21 -0400
Date: Fri, 18 Oct 2002 04:31:05 +0200
From: Andi Kleen <ak@muc.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andi Kleen <ak@muc.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statfs64 no longer missing
Message-ID: <20021018023105.GA15931@averell>
References: <20021016140658.GA8461@averell> <shs7kgipiym.fsf@charged.uio.no> <15789.64263.606518.921166@wombat.chubb.wattle.id.au> <20021017000111.GA25054@averell> <20021017154102.D30332@redhat.com> <15791.21383.361727.533851@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15791.21383.361727.533851@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/i386/kernel/entry.S	Fri Oct 18 10:07:29 2002
> +++ b/arch/i386/kernel/entry.S	Fri Oct 18 10:07:29 2002
> @@ -737,6 +737,8 @@
>  	.long sys_free_hugepages
>  	.long sys_exit_group
>  	.long sys_lookup_dcookie
> +	.long sys_statfs64
> +	.long sys_fstatfs64 /* 255 */

Funny. Finally filling the 8bits for syscall numbers.

> +long vfs_statfs64(struct super_block *sb, struct statfs64 *buf)
> +{
> +	struct kstatfs st;
> +	int retval;
> +
> +	retval = vfs_statfs(sb, &st);
> +	if (retval)
> +		return retval;
> +
> +	if (sizeof(*buf) == sizeof(st))
> +		memcpy(buf, &st, sizeof(st));

Don't you need to clear spare here too ?

-Andi
