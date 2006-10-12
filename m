Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWJLVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWJLVUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWJLVUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:20:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750952AbWJLVUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:20:16 -0400
Date: Thu, 12 Oct 2006 14:20:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch 7/7] stacktrace filtering for fault-injection
 capabilities
Message-Id: <20061012142004.a111ca6a.akpm@osdl.org>
In-Reply-To: <452df23e.44ca1e09.1a7f.780f@mx.google.com>
References: <20061012074305.047696736@gmail.com>
	<452df23e.44ca1e09.1a7f.780f@mx.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 16:43:12 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> This patch provides stacktrace filtering feature.
> The stacktrace filter allows failing only for the caller you are
> interested in.
> 
> stacktrace filter is enabled by setting the value of
> /debugfs/*/stacktrace-depth more than 0.
> and specify the range of the virtual address
> by the /debugfs/*/address-start and /debugfs/*/address-end
> 
> Please see the example that demostrates how to inject slab allocation
> failures only for a specific module
> in Documentation/fault-injection/fault-injection.txt

I read the documentation but I still don't understand this feature.  What
does the stacktrace actually do?  It gets stored somewhere and displayed
later?  What's it all for?

> --- work-fault-inject.orig/lib/Kconfig.debug
> +++ work-fault-inject/lib/Kconfig.debug
> @@ -472,6 +472,8 @@ config LKDTM
>  
>  config FAULT_INJECTION
>  	bool
> +	select STACKTRACE
> +	select FRAME_POINTER
>  
>  config FAILSLAB
>  	bool "fault-injection capabilitiy for kmalloc"
> 

Is the selection of FRAME_POINTER really needed?  The fancy new unwinder
is supposed to be able to handle frame-pointerless unwinding?
