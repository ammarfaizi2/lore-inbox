Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTDVDtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 23:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTDVDtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 23:49:51 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:4484 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262872AbTDVDtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 23:49:50 -0400
Date: Tue, 22 Apr 2003 05:01:17 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9
Message-ID: <20030422040117.GA31324@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304211509010.11700-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211509010.11700-100000@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 03:13:31PM -0400, Ingo Molnar wrote:

 > +/*
 > + * Is there a way to do this via Kconfig?
 > + */
 > +#if CONFIG_NR_SIBLINGS_2
 > +# define CONFIG_NR_SIBLINGS 2
 > +#elif CONFIG_NR_SIBLINGS_4
 > +# define CONFIG_NR_SIBLINGS 4
 > +#else
 > +# define CONFIG_NR_SIBLINGS 0
 > +#endif
 > +

Maybe this would be better resolved at runtime ?
With the above patch, you'd need three seperate kernel images
to run optimally on a system in each of the cases.
The 'vendor kernel' scenario here looks ugly to me.

 > +#if CONFIG_NR_SIBLINGS
 > +# define CONFIG_SHARE_RUNQUEUE 1
 > +#else
 > +# define CONFIG_SHARE_RUNQUEUE 0
 > +#endif

And why can't this just be a

	if (ht_enabled)
		shared_runqueue = 1;

Dumping all this into the config system seems to be the
wrong direction IMHO. The myriad of runtime knobs in the
scheduler already is bad enough, without introducing
compile time ones as well.

		Dave
