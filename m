Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWIDJIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWIDJIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWIDJIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:08:43 -0400
Received: from ns2.suse.de ([195.135.220.15]:53687 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751097AbWIDJIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:08:41 -0400
Date: Mon, 4 Sep 2006 11:08:20 +0200
From: Stefan Seyfried <seife@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 2/3] PM: Make console suspending configureable
Message-ID: <20060904090820.GA4500@suse.de>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl> <200608161309.34370.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608161309.34370.rjw@sisk.pl>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-rc5-2-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry, i am only slowly catching up after vacation.

On Wed, Aug 16, 2006 at 01:09:34PM +0200, Rafael J. Wysocki wrote:
> Change suspend_console() so that it waits for all consoles to flush the
> remaining messages and make it possible to switch the console suspending
> off with the help of a Kconfig option.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

> +#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
>  /**
>   * suspend_console - suspend the console subsystem
>   *
> @@ -709,8 +710,14 @@ int __init add_preferred_console(char *n
>   */
>  void suspend_console(void)
>  {
> +	printk("Suspending console(s)\n");
>  	acquire_console_sem();
>  	console_suspended = 1;
> +	/* This is needed so that all of the messages that have already been
> +	 * written to all consoles can be actually transmitted (eg. over a
> +	 * network) before we try to suspend the consoles' devices.
> +	 */
> +	ssleep(2);

Sorry, but no. Suspend and resume is already slow enough, no need to make
both of them much slower.
If we can condition this on the netconsole being used, ok, but not for the
most common case of "console is on plain VGA".

-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

-- 
VGER BF report: U 0.49988
