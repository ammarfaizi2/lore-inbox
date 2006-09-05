Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWIEG25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWIEG25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWIEG25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:28:57 -0400
Received: from ns1.suse.de ([195.135.220.2]:26262 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965180AbWIEG24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:28:56 -0400
Date: Tue, 5 Sep 2006 08:28:42 +0200
From: Stefan Seyfried <seife@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] PM: Remove sleeping from suspend_console
Message-ID: <20060905062842.GA21738@suse.de>
References: <200609042250.41592.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609042250.41592.rjw@sisk.pl>
X-Operating-System: openSUSE 10.2 (i586) Alpha4, Kernel 2.6.18-rc5-2-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 10:50:40PM +0200, Rafael J. Wysocki wrote:
> Remove ssleep() from suspend_console().
> 
> Stefan thinks it is unnecessary and will slow down the suspend too much.

"unnecessary" is not exactly what i think, rather "unacceptable" :-)
We probably need to do something for some kinds of consoles to make sure all
characters are sent, but sleeping unconditionally is not the right thing IMO.

> --- linux-2.6.18-rc5-mm1.orig/kernel/printk.c
> +++ linux-2.6.18-rc5-mm1/kernel/printk.c
> @@ -713,11 +713,6 @@ void suspend_console(void)
>  	printk("Suspending console(s)\n");
>  	acquire_console_sem();
>  	console_suspended = 1;
> -	/* This is needed so that all of the messages that have already been
> -	 * written to all consoles can be actually transmitted (eg. over a
> -	 * network) before we try to suspend the consoles' devices.
> -	 */
> -	ssleep(2);
>  }
>  
>  void resume_console(void)

-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
