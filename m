Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSI2IM3>; Sun, 29 Sep 2002 04:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSI2IM3>; Sun, 29 Sep 2002 04:12:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58636 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262415AbSI2IM1>; Sun, 29 Sep 2002 04:12:27 -0400
Date: Sun, 29 Sep 2002 09:17:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Hu Gang <hugang@soulinfo.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: a bug in 8250.c
Message-ID: <20020929091747.A11800@flint.arm.linux.org.uk>
References: <20020929101523.2400f335.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929101523.2400f335.hugang@soulinfo.com>; from hugang@soulinfo.com on Sun, Sep 29, 2002 at 10:15:23AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 10:15:23AM +0800, Hu Gang wrote:
> In serial8250_request_std_resource@825.c, if all is pass it return 0, or failed return -XX, But you use 
>         ret = serial8250_request_std_resource(up, &res_std);
> ->      if (ret)
>                 return;
> I'm guess it use as . 
> ->      if (ret == 0) 

This is very wrong.

If we claim the resource, we fail in this function.  If we don't claim,
we succeed.

> After change code, 2.5.39 Can found my modem.

I guess you've got a resource clash.  Can you remove this patch from your
system, and then send the kernel boot messages, and the contents of
/proc/iomem and /proc/ioports please.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

