Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVERHb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVERHb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVERHb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:31:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:18593 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262118AbVERHbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:31:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 3/8] ppc64: add a watchdog driver for rtas
Date: Wed, 18 May 2005 09:14:41 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       Utz Bacher <utz.bacher@de.ibm.com>, Wim Van Sebroeck <wim@iguana.be>
References: <200505132117.37461.arnd@arndb.de> <200505132124.48963.arnd@arndb.de> <20050517204029.GA2748@otto>
In-Reply-To: <20050517204029.GA2748@otto>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505180914.44336.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 17 Mai 2005 22:40, Nathan Lynch wrote:
> Arnd Bergmann wrote:
> > +static volatile int wdrtas_miscdev_open = 0;
> ...
> > +static int
> > +wdrtas_open(struct inode *inode, struct file *file)
> > +{
> > +	/* only open once */
> > +	if (xchg(&wdrtas_miscdev_open,1))
> > +		return -EBUSY;
> 
> The volatile and xchg strike me as an obscure method for ensuring only
> one process at a time can open this file.  Any reason a semaphore
> couldn't be used?

A semaphore would also be the wrong approach since we don't want
processes to block but instead to fail opening the watchdog twice.
Other watchdog drivers use atomic_t or bitops to guard open, which
imho would be the better solution.

Of course, there is also Wim's plan to do a unified watchdog driver
that would solve this once and for all. 

> > +		printk("wdrtas: got unexpected close. Watchdog "
> > +		       "not stopped.\n");
> 
> printk's need a valid log level specified.  There are several in this
> file that lack them.

Right.

Utz, do you have time to fix up these issues? If not, I probably won't
look into it this week either.

Thanks,

	Arnd <><
