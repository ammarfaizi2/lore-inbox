Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270999AbTGPKng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271000AbTGPKng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:43:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:7087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270999AbTGPKnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:43:32 -0400
Date: Wed, 16 Jul 2003 03:58:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test1-mm1
Message-Id: <20030716035848.560674ac.akpm@osdl.org>
In-Reply-To: <20030716104448.GC25869@ip68-4-255-84.oc.oc.cox.net>
References: <20030715225608.0d3bff77.akpm@osdl.org>
	<20030716104448.GC25869@ip68-4-255-84.oc.oc.cox.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> wrote:
>
> >  Make ppc build
> 
>  Really? ;)
> 
>  More seriously, that patch is good and necessary, but I think something
>  else in -mm is breaking the compile (this is gcc 2.95.3):
> 
>    CC      arch/ppc/kernel/irq.o
>  In file included from include/linux/fs.h:14,
>                   from include/linux/mm.h:14,
>                   from include/asm/pci.h:8,
>                   from include/linux/pci.h:672,
>                   from arch/ppc/kernel/irq.c:41:
>  include/linux/kdev_t.h: In function `to_kdev_t':
>  include/linux/kdev_t.h:101: warning: right shift count >= width of type

Well you would appear to be the first person who has tested a -mm kernel on
ppc since mid-April or earlier.

As soon as Viro returns, that code hits Linus's tree.  Oh well, can't say
they weren't warned.

Try this:

--- 25/include/asm-ppc/posix_types.h~a	2003-07-16 03:55:34.000000000 -0700
+++ 25-akpm/include/asm-ppc/posix_types.h	2003-07-16 03:55:51.000000000 -0700
@@ -7,7 +7,7 @@
  * assume GCC is being used.
  */
 
-typedef unsigned int	__kernel_dev_t;
+typedef unsigned long long	__kernel_dev_t;
 typedef unsigned long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;



>  arch/ppc/kernel/irq.c: At top level:  
>  arch/ppc/kernel/irq.c:575: braced-group within expression allowed only
>  inside a function

Bill?
