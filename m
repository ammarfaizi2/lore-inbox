Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbTCHATX>; Fri, 7 Mar 2003 19:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbTCHATW>; Fri, 7 Mar 2003 19:19:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:33185 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261962AbTCHATU>;
	Fri, 7 Mar 2003 19:19:20 -0500
Date: Fri, 7 Mar 2003 16:30:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, shemminger@osdl.org,
       torvalds@transmeta.com
Subject: Re: [PATCH 2.5.64 2/2] i_size atomic access
Message-Id: <20030307163001.43805e11.akpm@digeo.com>
In-Reply-To: <1047082543.2636.98.camel@ibm-c.pdx.osdl.net>
References: <1047082543.2636.98.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2003 00:29:49.0454 (UTC) FILETIME=[D407C2E0:01C2E509]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> This adds i_seqcnt to inode structure and then uses i_size_read() and
> i_size_write() to provide atomic access to i_size.

Ho hum.  Everybody absolutely hates this, but I guess we should do it :(

> +static inline void i_size_write(struct inode * inode, loff_t i_size)
> +{
> +#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
> +	write_seqcntbegin(&inode->i_size_seqcnt);
> +	inode->i_size = i_size;
> +	write_seqcntend(&inode->i_size_seqcnt);
> +#elif BITS_PER_LONG==32 && defined(CONFIG_PREMPT)
> +	prempt_disable();
> +	inode->i_size = i_size;
> +	prempt_enable();
> +#else
> +	inode->i_size = i_size;
> +#endif
> +}

You've used "PREMPT" and "prempt" throughput the patch.  It is in fact
"PREEMPT" and "preempt".

Could you please fix that up and send me fresh copies?  Probably as
attachments - your mailer wordwrapped the patches.

Thanks.
