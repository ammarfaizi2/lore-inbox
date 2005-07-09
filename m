Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVGIMWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVGIMWq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVGIMUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:20:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:134 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261348AbVGIMUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 08:20:10 -0400
Date: Sat, 9 Jul 2005 14:16:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [37/48] Suspend2 2.1.9.8 for 2.6.12: 613-pageflags.patch
Message-ID: <20050709121612.GG1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164434190@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164434190@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You know what I think about plugins, right? There are already plugins
at block device level, like raid5, LVM, device mapper... I do not see
why you should need another one.

> +/*
> + * expected_compression_ratio
> + *
> + * Returns the expected ratio between the amount of memory
> + * to be saved and the amount of space required on the
> + * storage device.
> + */
> +int expected_compression_ratio(void)
> +{
> +	struct suspend_plugin_ops * this_filter;
> +	unsigned long ratio = 100;
> +	
> +	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
> +		if (this_filter->disabled)
> +			continue;
> +		if (this_filter->ops.filter.expected_compression)
> +			ratio = ratio * this_filter->ops.filter.expected_compression() / 100;
> +	}
> +
> +	return (int) ratio;
> +}

Why the cast and why long in the first place?

> +struct suspend_plugin_ops * find_plugin_given_name(char * name)
> +{
> +	struct suspend_plugin_ops * this_plugin, * found_plugin = NULL;
> +	
> +	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
> +		if (!strcmp(name, this_plugin->name)) {
> +			found_plugin = this_plugin;
> +			break;
> +		}			
> +	}
> +
> +	return found_plugin;
> +}

How often are you doing this? Would hash table be prefered? How many
plugins do you have? Maybe statical registration is right solution?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
