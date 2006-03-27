Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWC0JTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWC0JTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 04:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWC0JTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 04:19:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40328 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750814AbWC0JTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 04:19:02 -0500
Date: Mon, 27 Mar 2006 11:18:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] vt: TIOCL to read kmsg_redirect from user space
Message-ID: <20060327091831.GE14248@elf.ucw.cz>
References: <200603251219.08415.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603251219.08415.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The userland suspend tool we're working on needs to get the current value
> of kmsg_redirect from the kernel so that it can save it and restore it after
> resume.  Unfortunetely there only is TIOCL_SETKMSGREDIRECT allowing us to
> set this value from the user space.
> 
> The appended patch adds the "missing" TIOCL_GETKMSGREDIRECT that we
> need.

> Comments welcome.

Looks good to me.
								Pavel

>  drivers/char/vt.c     |    4 ++++
>  include/linux/tiocl.h |    1 +
>  2 files changed, 5 insertions(+)
> 
> Index: linux-2.6.16-mm1/drivers/char/vt.c
> ===================================================================
> --- linux-2.6.16-mm1.orig/drivers/char/vt.c
> +++ linux-2.6.16-mm1/drivers/char/vt.c
> @@ -2328,6 +2328,10 @@ int tioclinux(struct tty_struct *tty, un
>  		case TIOCL_SETVESABLANK:
>  			set_vesa_blanking(p);
>  			break;
> +		case TIOCL_GETKMSGREDIRECT:
> +			data = kmsg_redirect;
> +			ret = __put_user(data, p);
> +			break;
>  		case TIOCL_SETKMSGREDIRECT:
>  			if (!capable(CAP_SYS_ADMIN)) {
>  				ret = -EPERM;
> Index: linux-2.6.16-mm1/include/linux/tiocl.h
> ===================================================================
> --- linux-2.6.16-mm1.orig/include/linux/tiocl.h
> +++ linux-2.6.16-mm1/include/linux/tiocl.h
> @@ -34,5 +34,6 @@ struct tiocl_selection {
>  #define TIOCL_SCROLLCONSOLE	13	/* scroll console */
>  #define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
>  #define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
> +#define TIOCL_GETKMSGREDIRECT	17	/* get the vt the kernel messages are restricted to */
>  
>  #endif /* _LINUX_TIOCL_H */

-- 
Picture of sleeping (Linux) penguin wanted...
