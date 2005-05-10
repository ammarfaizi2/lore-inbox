Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVEJMtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVEJMtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVEJMtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:49:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36367 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261627AbVEJMsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:48:46 -0400
Date: Tue, 10 May 2005 13:48:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] ds1337 driver works also with ds1339 chip
Message-ID: <20050510134834.A3358@flint.arm.linux.org.uk>
Mail-Followup-To: Ladislav Michl <ladis@linux-mips.org>,
	Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <sensors@Stimpy.netroedge.com>,
	James Chapman <jchapman@katalix.com>
References: <20050504061438.GD1439@orphique> <Ky47NT3d.1115201231.3150830.khali@localhost> <20050510120804.GA2492@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050510120804.GA2492@orphique>; from ladis@linux-mips.org on Tue, May 10, 2005 at 02:08:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 02:08:04PM +0200, Ladislav Michl wrote:
> On Wed, May 04, 2005 at 12:07:11PM +0200, Jean Delvare wrote:
> > > Chip is searched by bus number rather than its own proprietary id.
> > 
> > Yes, I think it makes much more sense (especially since the proprietary
> > id was not known by anyone outside of the ds1337 driver).
> > 
> > I think I understand that ds1337_do_command() will be called from some
> > other kernel driver. Why isn't it exported then? I'd expect:
> > EXPORT_SYMBOL(ds1337_do_command);
> 
> RTC is hooked early in boot process. It should be available even sooner
> than rootfs is mounted. Therefore RTC drivers are usualy compiled in
> kernel. Anyway, exporting that function shouldn't hurt :)

You don't have to set the kernel time during time_init(), and this
is especially true with I2C RTCs.  The only thing that time_init()
has to do is to start the kernel tick going.

There is no reason why it can't be initialised during the normal
driver initialisation - which is how we do it on a number of ARM
platforms.

There are some ARM platforms where we can only get the time via
ntpdate, and this is also satisfactory.

So please don't get hung up on the x86 way of doing things.  It's
both conceptually wrong and actually unnecessary.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
