Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVFJJLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVFJJLT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVFJJLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:11:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42696 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262537AbVFJJKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:10:44 -0400
Date: Fri, 10 Jun 2005 11:10:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050610091008.GG4173@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610043018.GE18103@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some more nitpicking...

> +/*
> + * ---------------------------------------------------------------------------
> + * Command line options
> + * ---------------------------------------------------------------------------
> + */
> +static int __initdata dyntick_autoenable = 0;
> +static int __initdata dyntick_useapic = 0;
> +
> +/*
> + * dyntick=[enable|disable],[forceapic]
> + */ 
> +static int __init dyntick_setup(char *options)
> +{
> +	if (!options)
> +		return 0;
> +
> +	if (strstr(options, "enable"))
> +		dyntick_autoenable = 1;
> +
> +	if (strstr(options, "forceapic"))
> +		dyntick_useapic = 1;
> +
> +	return 0;
> +}
> +
> +__setup("dyntick=", dyntick_setup);


Well, your parsing is little too simplistic. If I pass
dyntick=do_not_dare_to_enable_it, it still enables :-).

> +/*
> + * ---------------------------------------------------------------------------
> + * Sysfs interface
> + * ---------------------------------------------------------------------------
> + */
> +
> +extern struct sys_device device_timer;
> +
> +static ssize_t show_dyn_tick_state(struct sys_device *dev, char *buf)
> +{
> +	return sprintf(buf, "suitable:\t%i\n"
> +		       "enabled:\t%i\n"
> +		       "using APIC:\t%i\n",
> +		       dyn_tick->state & DYN_TICK_SUITABLE,
> +		       (dyn_tick->state & DYN_TICK_ENABLED) >> 1,
> +		       (dyn_tick->state & DYN_TICK_USE_APIC) >> 3);

You basically hardcode values of DYN_TICK_* here. Why not use !!() and
loose dependency?

								Pavel
