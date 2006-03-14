Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWCNVeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWCNVeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWCNVeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:34:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932463AbWCNVeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:34:23 -0500
Date: Tue, 14 Mar 2006 13:36:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stone, Joshua I" <joshua.i.stone@intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] provide hrtimer exports for module use [Was: Exports
 for hrtimer APIs]
Message-Id: <20060314133633.2814cdf7.akpm@osdl.org>
In-Reply-To: <CBDB88BFD06F7F408399DBCF8776B3DC06A92A13@scsmsx403.amr.corp.intel.com>
References: <CBDB88BFD06F7F408399DBCF8776B3DC06A92A13@scsmsx403.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stone, Joshua I" <joshua.i.stone@intel.com> wrote:
>
> Andrew Morton wrote:
> > "Stone, Joshua I" <joshua.i.stone@intel.com> wrote:
> >> I have noticed that the hrtimer APIs in 2.6.16 RCs are not exported,
> >> and therefore modules are unable to use hrtimers.  I have not seen
> >> any discussion on this point, so I presume that this is either an
> >> oversight, or there has not been any case presented for exporting
> >> hrtimers. 
> >> 
> >> I would like to add hrtimer support to SystemTap, which by design
> >> requires the use of dynamically loaded kernel modules.  Can the
> >> appropriate exports for hrtimers please be added?
> > 
> > Please send a patch, so we can see what's needed.
> > 
> > EXPORT_SYMBOL_GPL would be preferred.
> 
> This patch adds the exports needed for modules to use the
> hrtimer APIs.
> 
> --- linux-2.6.16-rc6/kernel/hrtimer.c	2006-03-14 10:44:13.000000000
> -0800
> +++ linux-2.6.16-rc6-hrtexp/kernel/hrtimer.c	2006-03-14
> 11:13:48.000000000 -0800

Wordwrapped...

> +EXPORT_SYMBOL_GPL(ktime_add_ns);
> +EXPORT_SYMBOL_GPL(hrtimer_forward);
> +EXPORT_SYMBOL_GPL(hrtimer_start);
> +EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel);
> +EXPORT_SYMBOL_GPL(hrtimer_cancel);
> +EXPORT_SYMBOL_GPL(hrtimer_get_remaining);
> +EXPORT_SYMBOL_GPL(hrtimer_get_next_event);
> +EXPORT_SYMBOL_GPL(hrtimer_init);
> +EXPORT_SYMBOL_GPL(hrtimer_get_res);
> +EXPORT_SYMBOL_GPL(hrtimer_nanosleep);

gee, that's a lot of exports.  I don't know whether all of these would be
considered stable over the long-term?

Can you tell us a bit about why systemtap modules need the hrtimer
capability?  How it's being used and for what, etc?

Thanks.
