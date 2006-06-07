Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWFGVm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWFGVm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWFGVm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:42:26 -0400
Received: from xenotime.net ([66.160.160.81]:59821 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932355AbWFGVmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:42:25 -0400
Date: Wed, 7 Jun 2006 14:45:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Get rid of /proc/sys/debug
Message-Id: <20060607144512.1e5b0e96.rdunlap@xenotime.net>
In-Reply-To: <20060607142232.6cc6cd2f@localhost.localdomain>
References: <20060607142127.37da7eb7@localhost.localdomain>
	<20060607142232.6cc6cd2f@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 14:22:32 -0700 Stephen Hemminger wrote:

> Another empty table with no entries.

Did you check on x86_64?  I see this:

rddunlap@midway:/var/linsrc/linux-2617-rc6> ll /proc/sys/debug
-rw-r--r--  1 root root 0 2006-06-07 14:44 exception-trace

from arch/x86_64/mm/init.c


> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> --- sky2.orig/include/linux/sysctl.h	2006-06-07 14:12:29.000000000 -0700
> +++ sky2/include/linux/sysctl.h	2006-06-07 14:20:15.000000000 -0700
> @@ -57,7 +57,7 @@
>  	CTL_NET=3,		/* Networking */
>  	/* was CTL_PROC */
>  	CTL_FS=5,		/* Filesystems */
> -	CTL_DEBUG=6,		/* Debugging */
> +	/* was CTL_DEBUG */
>  	CTL_DEV=7,		/* Devices */
>  	CTL_BUS=8,		/* Busses */
>  	CTL_ABI=9,		/* Binary emulation */
> @@ -800,8 +800,6 @@
>  	FS_DQ_WARNINGS = 9,
>  };
>  
> -/* CTL_DEBUG names: */
> -
>  /* CTL_DEV names: */
>  enum {
>  	DEV_CDROM=1,
> --- sky2.orig/kernel/sysctl.c	2006-06-07 14:06:38.000000000 -0700
> +++ sky2/kernel/sysctl.c	2006-06-07 14:18:34.000000000 -0700
> @@ -143,7 +143,6 @@
>  static ctl_table kern_table[];
>  static ctl_table vm_table[];
>  static ctl_table fs_table[];
> -static ctl_table debug_table[];
>  static ctl_table dev_table[];
>  extern ctl_table random_table[];
>  #ifdef CONFIG_UNIX98_PTYS
> @@ -207,12 +206,6 @@
>  		.child		= fs_table,
>  	},
>  	{
> -		.ctl_name	= CTL_DEBUG,
> -		.procname	= "debug",
> -		.mode		= 0555,
> -		.child		= debug_table,
> -	},
> -	{
>  		.ctl_name	= CTL_DEV,
>  		.procname	= "dev",
>  		.mode		= 0555,
> @@ -1037,10 +1030,6 @@
>  	{ .ctl_name = 0 }
>  };
>  
> -static ctl_table debug_table[] = {
> -	{ .ctl_name = 0 }
> -};
> -
>  static ctl_table dev_table[] = {
>  	{ .ctl_name = 0 }
>  };


---
~Randy
