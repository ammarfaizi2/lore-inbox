Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTFFRsD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFFRsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:48:03 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:13468 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S262116AbTFFRsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:48:02 -0400
Subject: Re: Kernel printk format string compression: C syntax problem
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EE0CF07.2070908@techsource.com>
References: <3EE0CF07.2070908@techsource.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054922496.29652.12.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 11:01:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 10:27, Timothy Miller wrote:

> printk( "EIP\200\3164x:[<\3168lx>] CPU\200%d\n" ,0xffff & 
> regs->xcs,regs->eip, (current_thread_info()->cpu));
> 
> GCC 3.0.4 makes the following complaint:
> 
> arch/i386/kernel/process.c:173: warning: too many arguments for format
> 
> What I believe is happening is that where I have the escape code "\316" 
> concatenated with the literal "8", the compiler is seeing it as "\3168" 
> and doesn't want to take it.

No.  Look at the __attribute__ on printk in include/linux/kernel.h.  GCC
believes that printk takes a printf-style format string as its first
argument, but you've mangled the string so that the number of format
specifiers doesn't match the number of arguments.

	<b

