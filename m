Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUEAXey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUEAXey (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUEAXey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:34:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:48810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262634AbUEAXew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:34:52 -0400
Date: Sat, 1 May 2004 16:34:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-Id: <20040501163431.130b3e22.akpm@osdl.org>
In-Reply-To: <m3llkbybi4.fsf@averell.firstfloor.org>
References: <1PMQ9-5K6-3@gated-at.bofh.it>
	<1PVTx-4rY-25@gated-at.bofh.it>
	<1R9hC-6rC-3@gated-at.bofh.it>
	<1Rbjr-7Y5-17@gated-at.bofh.it>
	<1RbW9-8sE-17@gated-at.bofh.it>
	<m3llkbybi4.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
>  > diff -puN include/asm-i386/unistd.h~a include/asm-i386/unistd.h
>  > --- 25/include/asm-i386/unistd.h~a	2004-05-01 16:09:35.115389384 -0700
>  > +++ 25-akpm/include/asm-i386/unistd.h	2004-05-01 16:09:49.513200584 -0700
>  > @@ -295,10 +295,6 @@
>  >  
>  >  #define __syscall_return(type, res) \
>  >  do { \
>  > -	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
>  > -		errno = -(res); \
>  > -		res = -1; \
>  > -	} \
>  >  	return (type) (res); \
>  >  } while (0)
> 
>  Don't do that please. That will break all the user space
>  programs who use asm/unistd.h to define own system calls
>  (it is quite common).
> 
>  Make it conditional on __KERNEL__

err, that was just a "technology demonstration".  Obviously there's a lot
more involved.  Such as fixing up all the other architectures and then
killing off all the `errno' users.

