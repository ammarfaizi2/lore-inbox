Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263884AbUDVI5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbUDVI5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUDVI5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:57:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:6531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263884AbUDVI4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:56:22 -0400
Date: Thu, 22 Apr 2004 01:55:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] coredump - as root not only if euid switched
Message-Id: <20040422015556.55b4db0a.akpm@osdl.org>
In-Reply-To: <16641351.1082623864205.JavaMail.pwaechtler@mac.com>
References: <16641351.1082623864205.JavaMail.pwaechtler@mac.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Waechtler <pwaechtler@mac.com> wrote:
>
>  >Is it not possible to call sys_unlink() directly from there?  Something like
>  >
>  >long kernel_unlink(const char *name)
>  >{
>  >	mm_segment_t old_fs = get_fs();
>  >	long ret;
>  >
>  >	set_fs(KERNEL_DS);
>  >	ret = sys_unlink(name);
>  >	set_fs(old_fs);
>  >	return ret;
>  >}	
> 
>  And you're asking me? ;)

Well someone has to know ;)

>  While getname() has a check for user/kernelspace - do you really
>  care about "the overhead" for a function call level with 1 argument?
>  Uhm, probably if you even care to write this..

It's very small, but heck, we unlink a lot more often than we dump core. 
Most of us, that is.

>  What is the cost for switching the segments?

Teeny.

>  But I agree that sys_unlink should be the fast call and dumping core
>  is the exception :)
> 
>  would fastcall do_unlink() help? I guess the arg is then passed in a
>  register

I've never been able to measure any size or space benefit for fastcall, and
we do it via compiler options kernel-wide nowadays.

The above will work fine.  You can probably just open-code it at the place
where you're unlinking the file.

(why are you trying to unlink the old file anyway?)
