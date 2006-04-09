Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWDIVg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWDIVg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWDIVg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:36:29 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:41476 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750823AbWDIVg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:36:29 -0400
Date: Sun, 9 Apr 2006 23:36:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/19] kconfig: improve config load/save output
Message-ID: <20060409213621.GC30208@mars.ravnborg.org>
References: <Pine.LNX.4.64.0604091727330.23124@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604091727330.23124@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 05:27:41PM +0200, Roman Zippel wrote:
> 
> During loading special case the first common case (.config), be silent
> about it and otherwise mark it as a change that requires saving. Instead
> output that the file has been changed.
> IOW if conf does nothing (special), it's silent.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> ---
> 
>  scripts/kconfig/confdata.c |   22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6-git/scripts/kconfig/confdata.c
> ===================================================================
> --- linux-2.6-git.orig/scripts/kconfig/confdata.c
> +++ linux-2.6-git/scripts/kconfig/confdata.c
> @@ -98,20 +98,28 @@ int conf_read_simple(const char *name)
>  		in = zconf_fopen(name);
>  	} else {
>  		const char **names = conf_confnames;
> +		name = *names++;
> +		if (!name)
> +			return 1;
> +		in = zconf_fopen(name);
> +		if (in)
> +			goto load;
> +		sym_change_count++;

sym_change_count is only used as a flag, not as a counter.
It would be less confusing to let the name reflect it is a flag.

 @@ -325,7 +335,7 @@ int conf_read(const char *name)
>  				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
>  	}
>  
> -	sym_change_count = conf_warnings || conf_unsaved;
> +	sym_change_count += conf_warnings || conf_unsaved;

One example where is obvious it is a flag.

	Sam
