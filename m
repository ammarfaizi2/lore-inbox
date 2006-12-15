Return-Path: <linux-kernel-owner+w=401wt.eu-S932620AbWLOA6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWLOA6k (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWLOA6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:58:40 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:25063 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932620AbWLOA6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:58:39 -0500
Date: Thu, 14 Dec 2006 16:59:08 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Zack Weinberg <zackw@panix.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] Add <linux/klog.h>
Message-Id: <20061214165908.4dc93496.randy.dunlap@oracle.com>
In-Reply-To: <20061215002333.920560000@panix.com>
References: <20061215001639.988521000@panix.com>
	<20061215002333.920560000@panix.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 16:16:40 -0800 Zack Weinberg wrote:

> This patch introduces <linux/klog.h> with symbolic constants for the
> various sys_syslog() opcodes, and changes all in-kernel references to
> those opcodes to use the constants.  The header is added to the set of
> user/kernel interface headers.  (Unlike the previous revision of this
> patch series, no kernel-private additions to this file are contemplated.)

Hi Zack,

This patch looks good except for one nit:

> --- linux-2.6.orig/fs/proc/kmsg.c	2006-12-13 15:53:29.000000000 -0800
> +++ linux-2.6/fs/proc/kmsg.c	2006-12-13 16:04:46.000000000 -0800
> @@ -21,27 +22,28 @@
>  
>  static int kmsg_open(struct inode * inode, struct file * file)
>  {
> -	return do_syslog(1,NULL,0);
> +	return do_syslog(KLOG_OPEN,NULL,0);
>  }
>  
>  static int kmsg_release(struct inode * inode, struct file * file)
>  {
> -	(void) do_syslog(0,NULL,0);
> +	(void) do_syslog(KLOG_CLOSE,NULL,0);
>  	return 0;
>  }

Please use a space after the commas (even though you just left it
as it already was).

---
~Randy
