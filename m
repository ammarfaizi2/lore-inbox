Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269364AbUJFSif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269364AbUJFSif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUJFSif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:38:35 -0400
Received: from trantor.org.uk ([213.146.130.142]:40098 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S269373AbUJFSiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:38:21 -0400
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
	availlable
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041005185214.GA3691@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=utf-8
Date: Wed, 06 Oct 2004 19:37:30 +0100
Message-Id: <1097087850.27683.3.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-2) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 20:52 +0200, Jörn Engel wrote:
> 
>  main.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.8cow/init/main.c~console  2004-10-05 20:46:40.000000000 +0200
> +++ linux-2.6.8cow/init/main.c  2004-10-05 20:46:08.000000000 +0200
> @@ -695,8 +695,11 @@
>         system_state = SYSTEM_RUNNING;
>         numa_default_policy();
>  
> -       if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> +       if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0) {
>                 printk("Warning: unable to open an initial console.\n");
> +               if (open("/dev/null", O_RDWR, 0) == 0)
> +                       printk("         Falling back to /dev/null.\n");
> +       }

BTW. What happens if /dev/console or /dev/null are regular files?

I don't see any check for this. I didn't think Linux imposed any
namespace layout/ownership/permission requirements.

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import

