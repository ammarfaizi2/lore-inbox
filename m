Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWD1JYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWD1JYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWD1JYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:24:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19659 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965195AbWD1JYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:24:22 -0400
Date: Fri, 28 Apr 2006 11:23:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Message-ID: <20060428092327.GI10737@elf.ucw.cz>
References: <200604242355.08111.rjw@sisk.pl> <200604271727.39194.rjw@sisk.pl> <20060427205533.GA10737@elf.ucw.cz> <200604281119.02575.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604281119.02575.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OK, I'm waiting for Nick to respond, then. :-)
> 
> Still I'd like to change one more thing in the final patch.  Namely,
> instead of this:
> 
> @@ -153,6 +153,10 @@ static int snapshot_ioctl(struct inode *
>         case SNAPSHOT_UNFREEZE:
>                 if (!data->frozen)
>                         break;
> +               if (data->ready && in_suspend) {
> +                       error = -EPERM;
> +                       break;
> +               }
>                 down(&pm_sem);
>                 thaw_processes();
>                 enable_nonboot_cpus();
> 
> I'd like to do:
> 
>  	case SNAPSHOT_UNFREEZE:
>  		if (!data->frozen)
>  			break;
> +               	if (data->ready)
> +			swsusp_free();
>  		down(&pm_sem);
> 		thaw_processes();
> 		enable_nonboot_cpus();
> 
> so unfreeze() won't return the error.

Seems okay to me...
						Pavel
-- 
Thanks for all the (sleeping) penguins.
