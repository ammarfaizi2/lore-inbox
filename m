Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267929AbTBVVv7>; Sat, 22 Feb 2003 16:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbTBVVv7>; Sat, 22 Feb 2003 16:51:59 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:8397 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267929AbTBVVv6>; Sat, 22 Feb 2003 16:51:58 -0500
Date: Sat, 22 Feb 2003 16:02:01 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elapsed times wrap
In-Reply-To: <Pine.LNX.4.44.0302221016080.1848-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302221600540.14516-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Hugh Dickins wrote:

> Userspace shows huge elapsed time across jiffies wrap: with USER_HZ
> less then HZ, sys_times needs jiffies_64 to calculate its retval.
> 
> --- 2.5.62/kernel/sys.c	Sat Feb 15 08:30:12 2003
> +++ linux/kernel/sys.c	Fri Feb 21 20:41:52 2003
> @@ -870,7 +870,7 @@
>  		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
>  			return -EFAULT;
>  	}
> -	return jiffies_to_clock_t(jiffies);
> +	return (long) jiffies_64_to_clock_t(get_jiffies_64());
>  }

That makes me wonder, aren't all uses of jiffies_to_clock_t() broken then? 
Well, all which take an absolute time as an argument at least.

--Kai


