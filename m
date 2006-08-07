Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWHGXhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWHGXhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWHGXhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:37:05 -0400
Received: from xenotime.net ([66.160.160.81]:31172 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932415AbWHGXhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:37:03 -0400
Date: Mon, 7 Aug 2006 16:39:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded
 controller access
Message-Id: <20060807163946.ffeb4ba1.rdunlap@xenotime.net>
In-Reply-To: <20060807134440.GD4032@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com>
	<11548492242899-git-send-email-multinymous@gmail.com>
	<20060807134440.GD4032@ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 13:44:41 +0000 Pavel Machek wrote:

> Hi!
> 
> > The embedded controller on ThinkPad laptops has a non-standard interface
> > at IO ports 0x1600-0x161F (mapped to LCP channel 3 of the H8S chip).
> > The interface provides various system management services (currently 
> > known: battery information and accelerometer readouts). This driver
> > provides access and mutual exclusion for the EC interface.
> > 
> > The mainline hdaps driver already uses this hardware interface (in an 
> > incorrect and unsafe way), and will be converted to use this module in
> > the following patches. Another driver using this module, tp_smapi, will 
> > be submitted later.
> > 
> > The Kconfig entry is set to tristate and will be selected by hdaps and
> > (eventually) tp_smapi, since thinkpad_ec does nothing by itself.
> > 
> > Signed-off-by: Shem Multinymous <multinymous@gmail.com>
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> > +/* Module parameters: */
> > +static int tp_debug = 0;
> 
> Static variables do not need initializers.
> 
> > +module_param_named(debug, tp_debug, int, 0600);
> > +MODULE_PARM_DESC(debug, "Debug level (0=off, 1=on)");
> > +
> > +/* A few macros for printk()ing: */
> > +#define DPRINTK(fmt, args...) \
> > +  do { if (tp_debug) printk(KERN_DEBUG fmt, ## args); } while (0)
> 
> Is not there generic function doing this?
> 
> > +/* thinkpad_ec_lock:
> > + * Get exclusive lock for accesing the controller. May sleep.
> > + * Returns 0 iff lock acquired .
> > + */
> 
> Linuxdoc?

Yes.  Usually known as kernel-doc.
See Documenation/kernel-doc-nano-HOWTO.txt for more info.
Thanks.


---
~Randy
