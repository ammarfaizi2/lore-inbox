Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbTCJRug>; Mon, 10 Mar 2003 12:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbTCJRug>; Mon, 10 Mar 2003 12:50:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5395 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261387AbTCJRue>;
	Mon, 10 Mar 2003 12:50:34 -0500
Date: Mon, 10 Mar 2003 09:50:44 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linux-kernel@vger.kernel.org, michael.ni@hp.com, torben.mathiasen@hp.com
Subject: Re: PCI hotplug w/ drivers linked statically vs. module
Message-ID: <20030310175044.GB9792@kroah.com>
References: <20030307032740.GA5236@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307032740.GA5236@zuul.cca.cpqcorp.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 09:27:40AM +0600, Stephen Cameron wrote:
> 
> I noticed a difference in behavior with PCI hotplug, depending
> on if the driver in questino is loaded as a module, or statically
> linked.
> 
> For example, the tg3 driver, hot-unplugging, then hot-replugging
> works seemingly well if the driver is a module, but differnetly (poorly?)
> if it is statically linked. (eth0 disappears and does not come
> back.)

Is the tg3 driver's remove() function actually being called?  In looking
at the driver, the callback is declared properly, so it should be
present when building the driver into the kernel.

> So why the difference in behavior with PCI hotplug and drivers
> linked statically vs. as a module?

I have no idea right now, sorry.
Only thing I can think of is you have to mark the remove function as
"__devexit" and not "__exit" to make sure the function is really there
if CONFIG_HOTPLUG is enabled.

thanks,

greg k-h
