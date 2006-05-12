Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWELVsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWELVsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWELVsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:48:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45323 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932174AbWELVs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:48:26 -0400
Date: Fri, 12 May 2006 21:46:55 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
Message-ID: <20060512214655.GC4189@ucw.cz>
References: <20060509084945.373541000@sous-sol.org> <20060509085158.282993000@sous-sol.org> <200605091902.31327.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605091902.31327.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +
> > +/* Ignore multiple shutdown requests. */
> > +static int shutting_down = SHUTDOWN_INVALID;
> > +static void __shutdown_handler(void *unused);
> > +static DECLARE_WORK(shutdown_work, __shutdown_handler, NULL);
> > +
> > +static int shutdown_process(void *__unused)
> > +{
> > +	static char *envp[] = { "HOME=/", "TERM=linux",
> > +				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> > +	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
> 
> This should be configurable, probably in a sysctl

Actually we have similar code in sparc and acpi parts, IIRC. We
probably want to have one, common, shut-me-off routine.

-- 
Thanks for all the (sleeping) penguins.
