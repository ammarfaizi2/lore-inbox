Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTDIAlG (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTDIAlG (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:41:06 -0400
Received: from [12.47.58.221] ([12.47.58.221]:18169 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262656AbTDIAlF (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:41:05 -0400
Date: Tue, 8 Apr 2003 16:51:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: convert_fxsr_from_user
Message-Id: <20030408165113.3af2a32e.akpm@digeo.com>
In-Reply-To: <20030409001344.GA20353@suse.de>
References: <20030409001344.GA20353@suse.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 00:52:36.0548 (UTC) FILETIME=[5019C040:01C2FE32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> Andrew,
>  A while back you optimised this routine to not do lots of memory
> copies.  I've noticed it does no checking on the validity of the
> addresses it dereferences from userspace.

It never has performed those checks.   The check is in the caller,
arch/i386/kernel/signal.c:restore_i387.

Bless you for merging Jon's uaccess.h documentation patch. 

My __get_user()'s are arse-about.

diff -puN arch/i386/kernel/i387.c~convert_fxsr_from_user-get_user-fixes arch/i386/kernel/i387.c
--- 25/arch/i386/kernel/i387.c~convert_fxsr_from_user-get_user-fixes	Tue Apr  8 16:47:08 2003
+++ 25-akpm/arch/i386/kernel/i387.c	Tue Apr  8 16:48:13 2003
@@ -275,9 +275,9 @@ static int convert_fxsr_from_user( struc
 		unsigned long *t = (unsigned long *)to;
 		unsigned long *f = (unsigned long *)from;
 
-		if (__get_user(*f, t) ||
-				__get_user(*(f + 1), t + 1) ||
-				__get_user(from->exponent, &to->exponent))
+		if (__get_user(*t, f) ||
+				__get_user(*(t + 1), f + 1) ||
+				__get_user(to->exponent, &from->exponent))
 			return 1;
 	}
 	return 0;

_

