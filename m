Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbUCPAla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUCPAS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:18:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2820 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262998AbUCPALs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:11:48 -0500
Date: Tue, 16 Mar 2004 00:11:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ian Campbell <icampbell@arcom.com>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Do not include linux/irq.h from linux/netpoll.h
Message-ID: <20040316001141.C29594@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ian Campbell <icampbell@arcom.com>, netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1079369568.19012.100.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1079369568.19012.100.camel@icampbell-debian>; from icampbell@arcom.com on Mon, Mar 15, 2004 at 04:52:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 04:52:50PM +0000, Ian Campbell wrote:
> The culprit would appear to be the addition of a 
> 	#include <linux/netpoll.h>
> to net/core/dev.c which in turn pulls in <linux/irq.h> which (as Russell
> King notes in a comment therein) should not be included from generic
> code.

Linus - I haven't tested this patch myself yet, but I do think something
needs to happen with linux/irq.h.  It seems a comment in the file isn't
sufficient.

The file itself is misplaced and misleading sitting in the include/linux
subdirectory, which causes problems when people decide to include it into
architecture independent files, in the belief that it's a generic include
file.

I believe that linux/irq.h should at least become asm-generic/irq.h to
stop this happening.

What are your thoughts on this?

(Unfortunately, bkbits browsing using lynx or links seems to be rather
broken at the moment, otherwise I'd have checked whether you've already
integrated this patch.)

Index: linux-2.6-bkpxa/include/linux/netpoll.h
===================================================================
--- linux-2.6-bkpxa.orig/include/linux/netpoll.h        2004-03-15 15:03:30.000000000 +0000
+++ linux-2.6-bkpxa/include/linux/netpoll.h     2004-03-15 16:24:25.000000000 +0000
@@ -9,7 +9,6 @@
  
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/list.h>
  
 struct netpoll;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
