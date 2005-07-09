Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVGIWM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVGIWM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 18:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVGIWM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 18:12:58 -0400
Received: from [203.171.93.254] ([203.171.93.254]:6301 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261702AbVGIWM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 18:12:56 -0400
Subject: Re: [PATCH] [37/48] Suspend2 2.1.9.8 for 2.6.12:
	613-pageflags.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050709121612.GG1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164434190@foobar.com>
	 <20050709121612.GG1878@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120912367.7716.150.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 09 Jul 2005 22:32:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-07-09 at 22:16, Pavel Machek wrote:
> Hi!
> 
> You know what I think about plugins, right? There are already plugins
> at block device level, like raid5, LVM, device mapper... I do not see
> why you should need another one.
> 
> > +/*
> > + * expected_compression_ratio
> > + *
> > + * Returns the expected ratio between the amount of memory
> > + * to be saved and the amount of space required on the
> > + * storage device.
> > + */
> > +int expected_compression_ratio(void)
> > +{
> > +	struct suspend_plugin_ops * this_filter;
> > +	unsigned long ratio = 100;
> > +	
> > +	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
> > +		if (this_filter->disabled)
> > +			continue;
> > +		if (this_filter->ops.filter.expected_compression)
> > +			ratio = ratio * this_filter->ops.filter.expected_compression() / 100;
> > +	}
> > +
> > +	return (int) ratio;
> > +}
> 
> Why the cast and why long in the first place?

My bad. Actually, since I recently switched to cryptoapi support, I can
get rid of this function.

> > +struct suspend_plugin_ops * find_plugin_given_name(char * name)
> > +{
> > +	struct suspend_plugin_ops * this_plugin, * found_plugin = NULL;
> > +	
> > +	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
> > +		if (!strcmp(name, this_plugin->name)) {
> > +			found_plugin = this_plugin;
> > +			break;
> > +		}			
> > +	}
> > +
> > +	return found_plugin;
> > +}
> 
> How often are you doing this? Would hash table be prefered? How many
> plugins do you have? Maybe statical registration is right solution?

There would only be half a dozen tops.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

