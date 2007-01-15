Return-Path: <linux-kernel-owner+w=401wt.eu-S1751275AbXAORit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXAORit (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXAORit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:38:49 -0500
Received: from xenotime.net ([66.160.160.81]:57776 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751275AbXAORis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:38:48 -0500
Date: Mon, 15 Jan 2007 09:39:00 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: nigel@nigel.suspend2.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Extend support for PM_TRACE to include x86_64
Message-Id: <20070115093900.54c105b4.rdunlap@xenotime.net>
In-Reply-To: <1168859098.4417.3.camel@nigel.suspend2.net>
References: <1168859098.4417.3.camel@nigel.suspend2.net>
Organization: YPO4
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007 22:04:58 +1100 Nigel Cunningham wrote:

> Hi.
> 
> This patch adds support for PM_TRACE for the x86_64 architecture. Thanks
> to Linus for help with my asm ignorance.
> 
> Please apply.
> 
> Signed-off-by: Nigel Cunningham <nigel@nigel.suspend2.net>

Goody.  Thanks.

>  arch/x86_64/kernel/vmlinux.lds.S  |    7 +++++++
>  drivers/base/power/trace.c        |    4 +++-
>  include/asm-i386/resume-trace.h   |   21 +++++++++++++++++++++
>  include/asm-x86_64/resume-trace.h |   21 +++++++++++++++++++++
>  include/linux/resume-trace.h      |   19 ++-----------------
>  kernel/power/Kconfig              |    2 +-
>  scripts/kconfig/mconf             |binary

Hm, looks like several scripts/kconfig/* binary files need to be
added to dontdiff.

>  7 files changed, 55 insertions(+), 19 deletions(-)

> diff -ruNp 930-PM_TRACE.patch-old/kernel/power/Kconfig 930-PM_TRACE.patch-new/kernel/power/Kconfig
> --- 930-PM_TRACE.patch-old/kernel/power/Kconfig	2007-01-15 22:00:40.000000000 +1100
> +++ 930-PM_TRACE.patch-new/kernel/power/Kconfig	2007-01-15 00:00:08.000000000 +1100
> @@ -50,7 +50,7 @@ config DISABLE_CONSOLE_SUSPEND
>  
>  config PM_TRACE
>  	bool "Suspend/resume event tracing"
> -	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
> +	depends on PM && PM_DEBUG && (X86_32 || X86_64) && EXPERIMENTAL

That's just
	depends on PM && PM_DEBUG && X86 && EXPERIMENTAL

or maybe even:
	depends on PM_DEBUG && X86 && EXPERIMENTAL

since PM_DEBUG depends on PM.
Anyway, X86 means X86_32 or X86_64.

>  	default n
>  	---help---
>  	This enables some cheesy code to save the last PM event point in the


---
~Randy
