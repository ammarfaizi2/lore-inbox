Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSHVTUJ>; Thu, 22 Aug 2002 15:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHVTUJ>; Thu, 22 Aug 2002 15:20:09 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:27919 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316674AbSHVTUH>; Thu, 22 Aug 2002 15:20:07 -0400
Date: Thu, 22 Aug 2002 20:24:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Bligh <mjbligh@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [patch] Simple Topology API v0.3 (2/2)
Message-ID: <20020822202412.B30036@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Martin Bligh <mjbligh@us.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <3D65383B.9030406@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D65383B.9030406@us.ibm.com>; from colpatch@us.ibm.com on Thu, Aug 22, 2002 at 12:15:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 12:15:07PM -0700, Matthew Dobson wrote:
> diff -Nur linux-2.5.27-vanilla/kernel/sys.c linux-2.5.27-api/kernel/sys.c
> --- linux-2.5.27-vanilla/kernel/sys.c	Sat Jul 20 12:11:07 2002
> +++ linux-2.5.27-api/kernel/sys.c	Wed Jul 24 17:33:41 2002
> @@ -20,6 +20,7 @@
>  #include <linux/device.h>
>  #include <linux/times.h>
>  #include <linux/security.h>
> +#include <linux/topology.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
> @@ -1236,6 +1237,31 @@
>  	mask = xchg(&current->fs->umask, mask & S_IRWXUGO);
>  	return mask;
>  }
> +
> +asmlinkage long sys_check_topology(int convert_type, int to_convert)
> +{
> +	int ret = 0;
> +
> +	switch (convert_type) {
> +		case CPU_TO_NODE:
> +			ret = cpu_to_node(to_convert);
> +			break;
> +		case MEMBLK_TO_NODE:
> +			ret = memblk_to_node(to_convert);
> +			break;
> +		case NODE_TO_NODE:
> +			ret = node_to_node(to_convert);
> +			break;
> +		case NODE_TO_CPU:
> +			ret = node_to_cpu(to_convert);
> +			break;
> +		case NODE_TO_MEMBLK:
> +			ret = node_to_memblk(to_convert);
> +			break;
> +	}
> +
> +	return (long)ret;
> +}

You don't consider this a proper syscall API, do you?

