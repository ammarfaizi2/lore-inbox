Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWBGAmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWBGAmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWBGAmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:42:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964900AbWBGAma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:42:30 -0500
Date: Mon, 6 Feb 2006 16:44:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: olh@suse.de, davej@redhat.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       benh@kernel.crashing.org
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Message-Id: <20060206164410.2c7d3f49.akpm@osdl.org>
In-Reply-To: <200602070057.26925.rjw@sisk.pl>
References: <200602032312.k13NCDAc012658@hera.kernel.org>
	<200602061603.29989.rjw@sisk.pl>
	<20060206113809.51c230ba.akpm@osdl.org>
	<200602070057.26925.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > > --- linux-2.6.16-rc1-mm5.orig/drivers/macintosh/via-pmu.c
> > > +++ linux-2.6.16-rc1-mm5/drivers/macintosh/via-pmu.c
> > > @@ -2070,6 +2070,14 @@ restore_via_state(void)
> > >  	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
> > >  }
> > >  
> > > +#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
> > > +extern int pm_prepare_console(void);
> > > +extern void pm_restore_console(void);
> > > +#else
> > > +static int pm_prepare_console(void) { return 0; }
> > > +static void pm_restore_console(void) {}
> > > +#endif
> > > +
> > 
> > These should be in a header file.  Presumably one which
> > kernel/power/power.h includes, too.
> 
> Then I think I should move all that to include/linux/suspend.h.

Sounds sane.  Or <linux/console.h>.
