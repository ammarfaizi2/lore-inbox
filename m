Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTHVTqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTHVTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:46:34 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:16810 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S264220AbTHVTqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:46:32 -0400
Subject: Re: Hang when mounting XFS root in 2.6.0 tests on x86-64
From: Chris Meadors <clubneon@hereintown.net>
To: Andi Kleen <ak@suse.de>
Cc: Steve Lord <lord@sgi.com>, ak@muc.de, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <20030822112642.46d3f538.ak@suse.de>
References: <n4o5.8ga.21@gated-at.bofh.it>
	 <m3r83en2th.fsf@averell.firstfloor.org>
	 <1061513734.1622.55.camel@laptop.americas.sgi.com>
	 <20030822112642.46d3f538.ak@suse.de>
Content-Type: text/plain
Message-Id: <1061580885.13872.7.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Aug 2003 15:34:45 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19qHri-000659-0x*6v9pBy6Q01E*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 05:26, Andi Kleen wrote:

> First at least the comment on top of xfs_lowbit64() is not correct.
> ffs() only handles an 32bit argument, not 64bit. Hope that isn't a problem.
> 
> Hmm, one difference is that the x86-64 ffs will return 32 on zero, while
> i386 returns -1.
> 
> Does this patch fix it?
> 
> --- linux-2.6.0test3-amd64/include/asm-x86_64/bitops.h-o	2003-07-11 13:34:21.000000000 +0200
> +++ linux-2.6.0test3-amd64/include/asm-x86_64/bitops.h	2003-08-22 11:17:53.000000000 +0200
> @@ -466,7 +466,7 @@
>  
>  	__asm__("bsfl %1,%0\n\t"
>  		"cmovzl %2,%0" 
> -		: "=r" (r) : "g" (x), "r" (32));
> +		: "=r" (r) : "g" (x), "r" (-1));
>  	return r+1;
>  }

Yes, that fixed it.  Thanks much.

-- 
Chris

