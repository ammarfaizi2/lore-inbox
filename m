Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVLLDRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVLLDRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVLLDRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:17:19 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:15879 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751097AbVLLDRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:17:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=urwEzZXRT7c71K3t/CG20oIYCMZf2kOtSGUccd/d/7nCStpJ7gfbzWCSjnXbzMNHuxdieYzyjotK3m48DHf/UYJ/iqWfmgs4bbp85OVfvqq7sD2UJthWIzarR+cSw4zB23OpGop8+TB9oy2fhG7n6lS83qJJSzN7mBgQj+/D8k4=
From: Kurt Wall <kwallinator@gmail.com>
To: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/3] [kconfig] Direct use of lxdialog routines by menuconfig
Date: Sun, 11 Dec 2005 22:18:26 -0500
User-Agent: KMail/1.8.2
References: <20051212004159.31263.89669.stgit@machine.or.cz> <20051212004606.31263.37616.stgit@machine.or.cz>
In-Reply-To: <20051212004606.31263.37616.stgit@machine.or.cz>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, sam@ravnborg.org,
       kbuild-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512112218.27286.kwallinator@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 07:46 pm, Petr Baudis wrote:
> After three years, the zombie walks again!  This patch (against the latest
> git tree) cleans up interaction between kconfig's mconf (menuconfig
> frontend) and lxdialog. Its commandline interface disappears in this patch,
> instead a .so is packed from the lxdialog objects and the relevant
> functions are called directly from mconf.

> @@ -808,18 +684,22 @@ static void conf(struct menu *menu)
>     }
>     break;
>    case 4:
> -   if (type == 't')
> +   if (active_type == 't')
>      sym_set_tristate_value(sym, no);
>     break;
>    case 5:
> -   if (type == 't')
> +   if (active_type == 't')
>      sym_set_tristate_value(sym, mod);
>     break;
>    case 6:
> -   if (type == 't')
> +   if (active_type == 't') {
>      sym_toggle_tristate_value(sym);
> -   else if (type == 'm')
> -    conf(submenu);
> +   } else if (active_type == 'm') {
> +    if (single_menu_mode)
> +     submenu->data = (void *) !submenu->data;

Shouldn't this be:
     submenu->data = (void *) (long) !submenu->data;

> +    else
> +     conf(submenu);
> +   }
>     break;
>    case 7:
>     search_conf();

Kurt
-- 
The light at the end of the tunnel is the headlight of an approaching
train.
