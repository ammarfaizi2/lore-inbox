Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSGVQxU>; Mon, 22 Jul 2002 12:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSGVQxU>; Mon, 22 Jul 2002 12:53:20 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:37902 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S316586AbSGVQxT>;
	Mon, 22 Jul 2002 12:53:19 -0400
Subject: Re: [PATCH] 2.5.27 sysctl
From: Ray Lee <ray-lk@madrabbit.org>
To: dalecki@evision.ag
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Jul 2002 09:56:22 -0700
Message-Id: <1027356983.2024.1056.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

> This is making the sysctl code acutally be written in C.
> It wasn't mostly due to georgeous ommitted size array "forward
> declarations". As a side effect it makes the table structure easier to
> deduce.
>
> diff -urN linux-2.5.27/include/linux/sysctl.h linux/include/linux/sysctl.h
> --- linux-2.5.27/include/linux/sysctl.h 2002-07-20 21:11:05.000000000 +0200
> +++ linux/include/linux/sysctl.h 2002-07-21 19:30:43.000000000 +0200
> @@ -126,7 +126,7 @@
>          KERN_S390_USER_DEBUG_LOGGING=51, /* int: dumps of user faults */
>          KERN_CORE_USES_PID=52, /* int: use core or core.%pid */
>          KERN_TAINTED=53, /* int: various kernel tainted flags */
> - KERN_CADPID=54, /* int: PID of the process to notify on CAD */
> + KERN_CADPID=54 /* int: PID of the process to notify on CAD */
>  };

<snip>
 
The comma changes are gratuitous, as pure ANSI C explicitly allows such
constructs. (It was intended to simplify automatic code generation, as
well as for programmer ease to automatically deal with initializer
lists.)

>From the grammar section of the 2nd edition (ca. 1988) of K&R:
	initializer:
		assignment-expression
		{ initializer-list }
		{ initializer-list , }

...where initializer list is what one would expect.

Removing the size forward declarations does make the code quicker to
read, though.

Ray


