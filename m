Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbTBLPc0>; Wed, 12 Feb 2003 10:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBLPb6>; Wed, 12 Feb 2003 10:31:58 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:33517 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267247AbTBLPao>; Wed, 12 Feb 2003 10:30:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH - 2.5.60] JFS no longer compiles with gcc 2.95
Date: Wed, 12 Feb 2003 09:42:01 -0600
User-Agent: KMail/1.4.3
Cc: James Lamanna <james.lamanna@appliedminds.com>,
       "'Linus Torvalds'" <torvalds@transmeta.com>,
       jfs-discussion@www-124.southbury.usf.ibm.com,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20030210204651.GE17128@fs.tum.de> <200302120852.36636.shaggy@austin.ibm.com> <20030212150435.GL17128@fs.tum.de>
In-Reply-To: <20030212150435.GL17128@fs.tum.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302120942.01078.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 February 2003 09:04, Adrian Bunk wrote:

> Ah, then it's a well-known 2.95 parser bug (sorry for not looking
> better at it when sending my initial report). The following
> alternative patch is sufficient to fix the compilation with 2.95
> (it's your choice which of the two patches you prefer):
>
> --- linux-2.5.60-full/fs/jfs/jfs_debug.h.old	2003-02-12
> 15:59:14.000000000 +0100 +++
> linux-2.5.60-full/fs/jfs/jfs_debug.h	2003-02-12 15:59:35.000000000
> +0100 @@ -90,7 +90,7 @@
>  #define jfs_err(fmt, arg...) do {			\
>  	if (jfsloglevel >= JFS_LOGLEVEL_ERR)		\
>  		printk(KERN_ERR "%s:%d " fmt "\n",	\
> -		       __FILE__, __LINE__, ## arg);	\
> +		       __FILE__ , __LINE__ , ## arg);	\
>  } while (0)
>
>  /*

Interesting that the assert() macro in the same file is very similar, 
but apparently doesn't have the same problem.  Do you know if it's tied 
to the ## operator?  I'm not emotionally attached to __FILE__ and 
__LINE__, so I'll just go with removing them, unless anyone wants to 
change my mind.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

