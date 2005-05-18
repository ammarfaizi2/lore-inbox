Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVERPbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVERPbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVERPBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:01:24 -0400
Received: from orb.pobox.com ([207.8.226.5]:446 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262275AbVEROpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:45:44 -0400
Date: Wed, 18 May 2005 09:45:34 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       Utz Bacher <utz.bacher@de.ibm.com>, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 3/8] ppc64: add a watchdog driver for rtas
Message-ID: <20050518144534.GA3723@otto>
References: <200505132117.37461.arnd@arndb.de> <200505132124.48963.arnd@arndb.de> <20050517204029.GA2748@otto> <200505180914.44336.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505180914.44336.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Dinsdag 17 Mai 2005 22:40, Nathan Lynch wrote:
> > Arnd Bergmann wrote:
> > > +static volatile int wdrtas_miscdev_open = 0;
> > ...
> > > +static int
> > > +wdrtas_open(struct inode *inode, struct file *file)
> > > +{
> > > +	/* only open once */
> > > +	if (xchg(&wdrtas_miscdev_open,1))
> > > +		return -EBUSY;
> > 
> > The volatile and xchg strike me as an obscure method for ensuring only
> > one process at a time can open this file.  Any reason a semaphore
> > couldn't be used?
> 
> A semaphore would also be the wrong approach since we don't want
> processes to block but instead to fail opening the watchdog twice.

I should have been more explicit.  What I had in mind was using
down_trylock and returning -EBUSY if it failed.

Nathan
