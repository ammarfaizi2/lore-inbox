Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTBFXtL>; Thu, 6 Feb 2003 18:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTBFXtL>; Thu, 6 Feb 2003 18:49:11 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:43213 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265135AbTBFXtL>;
	Thu, 6 Feb 2003 18:49:11 -0500
Date: Fri, 7 Feb 2003 10:58:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: syscall documentation (2)
Message-Id: <20030207105838.303df6c9.sfr@canb.auug.org.au>
In-Reply-To: <UTC200302062008.h16K8Aa23600.aeb@smtp.cwi.nl>
References: <UTC200302062008.h16K8Aa23600.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003 21:08:10 +0100 (MET) Andries.Brouwer@cwi.nl wrote:
>
> The next new page is futex.2.
> 
> Comments welcome.
> Andries
> aeb@cwi.nl
> 
> -------------------------------
> NAME
>        futex - Fast Userspace Locking system call
> 
> SYNOPSIS
>        #include <linux/futex.h>
> 
>        #include <sys/time.h>
> 
>        int  sys_futex (void *futex, int op, int val, const struct
>        timespec *timeout);

In discussions with Rusty, we decided that the first parameter
to sys_futex should be a u32 * i.e. a pointer to a 32 bit quantity
in user space.  This is what is assumed by the code at the moment.
The kernel doesn't really care if it is signed or not as the only
test done on it is for equality.

I will be submitting a patch to that effect shortly.  This also makes
it much easier to do the compatibility layer interface ...

>        The futex argument needs to point to  an  aligned  integer
                                                            ^^^^^^^
32 bit quantity

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
