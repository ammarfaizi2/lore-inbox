Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDSGKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDSGKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDSGKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:10:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWDSGKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:10:01 -0400
Date: Tue, 18 Apr 2006 23:06:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: markus.lidel@shadowconnect.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/message/i2o/iop.c: static inline functions
 mustn't be exported
Message-Id: <20060418230600.4bccd221.akpm@osdl.org>
In-Reply-To: <20060418150615.GH11582@stusta.de>
References: <20060418150615.GH11582@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> static inline functions mustn't be exported.
> 

Actually, exports of static inlines work OK.  The compiler will emit an
out-of-line copy to satisfy EXPORT_SYMBOL's reference and the module
namespace is separate from the compiler&linker's namespace.

Of course, things will screw up when we're using the compiler&linker
namespace (ie: the driver is statically linked).

> --- linux-2.6.17-rc1-mm2-full/drivers/message/i2o/iop.c.old	2006-04-13 17:30:41.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/drivers/message/i2o/iop.c	2006-04-13 17:30:57.000000000 +0200
> @@ -1243,7 +1243,6 @@
>  EXPORT_SYMBOL(i2o_cntxt_list_get_ptr);
>  #endif
>  EXPORT_SYMBOL(i2o_msg_get_wait);
> -EXPORT_SYMBOL(i2o_msg_nop);
>  EXPORT_SYMBOL(i2o_find_iop);
>  EXPORT_SYMBOL(i2o_iop_find_device);
>  EXPORT_SYMBOL(i2o_event_register);

It depends whether Markus thinks this symbol is something which the driver
should be exporting.  If so, we should uninline i2o_msg_nop().  But given
that it's in a header, nobody should be linking to it anyway...

(why on earth does i2o put semicolons after its function definitions?)
