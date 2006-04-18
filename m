Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWDRXNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWDRXNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDRXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:13:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWDRXNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:13:50 -0400
Date: Tue, 18 Apr 2006 16:16:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel doesn't compile with CONFIG_HOTPLUG &&
 !CONFIG_NET
Message-Id: <20060418161614.321b61e7.akpm@osdl.org>
In-Reply-To: <200604190844.25476.ncunningham@cyclades.com>
References: <200604190844.25476.ncunningham@cyclades.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
>
> --- 9904.patch-old/kernel/sysctl.c	2006-04-19 08:40:47.000000000 +1000
> +++ 9904.patch-new/kernel/sysctl.c	2006-04-17 21:06:23.000000000 +1000
> @@ -401,7 +401,7 @@ static ctl_table kern_table[] = {
>  		.strategy	= &sysctl_string,
>  	},
>  #endif
> -#ifdef CONFIG_HOTPLUG
> +#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)

I've had this in -mm for a couple of weeks now but rmk points out that it's
rather silly.  Because if you have CONFIG_HOTPLUG=y, CONFIG_NET=n then the
kernel cannot deliver hotplug events to userspace..

So perhaps CONFIG_HOTPLUG should depend upon CONFIG_NET or, better,
CONFIG_NETLINK.

Dunno.  I left this in Greg's lap, but he's hiding.
