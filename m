Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWBOENH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWBOENH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 23:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWBOENH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 23:13:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50391 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422694AbWBOENF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 23:13:05 -0500
Date: Tue, 14 Feb 2006 20:13:26 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 2/9] isdn4linux: Siemens Gigaset drivers - common module
Message-ID: <20060215041326.GA23342@us.ibm.com>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.2006 [15:52:27 +0100], Hansjoerg Lipp wrote:
> From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>
> 
> This patch adds the common include file for the Siemens Gigaset drivers,
> providing definitions used by all of the Gigaset ISDN driver source files.
> It also adds the main source file of the gigaset module which manages
> common functions not specific to the type of connection to the device.

<snip>

> +#define GIG_TICK (HZ / 10)

This should probable be in milliseconds and use msecs_to_jiffies either
with another #define, or in the code directly (as Greg also indicated).
That way, we avoid rounding issues as best we can with HZ==250.

<snip>

> +/* gigaset_initcs
> + * Allocate and initialize cardstate structure for Gigaset driver
> + * Calls hardware dependent gigaset_initcshw() function
> + * Calls B channel initialization function gigaset_initbcs() for each B channel
> + * parameters:
> + *      drv		hardware driver the device belongs to
> + *	channels	number of B channels supported by device
> + *	onechannel	!=0: B channel data and AT commands share one communication channel
> + *			==0: B channels have separate communication channels
> + *	ignoreframes	number of frames to ignore after setting up B channel
> + *	cidmode		!=0: start in CallID mode
> + *	modulename	name of driver module (used for I4L registration)
> + * return value:
> + *	pointer to cardstate structure
> + */
> +struct cardstate *gigaset_initcs(struct gigaset_driver *drv, int channels,
> +				 int onechannel, int ignoreframes,
> +				 int cidmode, const char *modulename)
> +{

<snip>

> +	cs->timer.data = (unsigned long) cs;
> +	cs->timer.function = timer_tick;
> +	cs->timer.expires = jiffies + GIG_TICK;

setup_timer()?

Thanks,
Nish
