Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUBMTM2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUBMTM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:12:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:55187 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267175AbUBMTM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:12:26 -0500
Date: Fri, 13 Feb 2004 11:12:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org
Subject: Re: [SELINUX] mark avc_init with __init
Message-Id: <20040213111242.0d3e8583.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0402130921580.20552-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0402130921580.20552-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> The avc_init function is only called during kernel init, so it can be 
> marked with __init.
> 
> ...
> --- linux-2.6.3-rc2-mm1.o/security/selinux/include/avc.h	2004-02-04 08:39:07.000000000 -0500
> +++ linux-2.6.3-rc2-mm1.w2/security/selinux/include/avc.h	2004-02-13 09:21:38.704303416 -0500
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kdev_t.h>
>  #include <linux/spinlock.h>
> +#include <linux/init.h>
>  #include <asm/system.h>
>  #include "flask.h"
>  #include "av_permissions.h"
> @@ -121,7 +122,7 @@
>   * AVC operations
>   */
>  
> -void avc_init(void);
> +void __init avc_init(void);
>  

The section specifier only needs to be at the definition site, not at the
declaration site.  I guess it adds a little value for the header fle to say
"hey, this is __init", but as nothing checks that at runtime or compile
time it can easily become stale.


