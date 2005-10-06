Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVJFXQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVJFXQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVJFXQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:16:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:37356 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751192AbVJFXQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:16:17 -0400
Date: Thu, 6 Oct 2005 16:15:01 -0700
From: Greg KH <greg@kroah.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Message-ID: <20051006231501.GB7488@kroah.com>
References: <200510060803.21470.mgross@linux.intel.com> <20051006182022.GA14414@kroah.com> <200510061554.35039.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510061554.35039.mgross@linux.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 03:54:34PM -0700, Mark Gross wrote:
> On Thursday 06 October 2005 11:20, Greg KH wrote:
> > > +?????????????printk(KERN_ERR" misc_register retruns %d \n", ret);
> > > +?????????????ret = ?-EBUSY;
> > > +?????????????goto out3;
> > > +?????}
> > > +?????class = tlclk_miscdev.class;
> > > +?????class_device_create_file(class, &class_device_attr_current_ref);
> > 
> > Try registering a whole attribute group instead. ?It's much nicer than
> > the 20 lines you have to register and unregister your devices (and you
> > don't handle the error condition properly if something goes wrong half
> > way through.)
> > 
> 
> I couldn't find such an API that wasn't static to class.c, or
> described in class.txt.  Any pointers on this would be helpful.

sysfs_create_group() is what you want.

> +ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
> +		loff_t *f_pos)
> +{
> +	if (count < sizeof(struct tlclk_alarms))
> +		return -EIO;
> +
> +	wait_event_interruptible(wq, got_event);
> +	if (copy_to_user(buf, alarm_events, sizeof(struct tlclk_alarms)))
> +		return -EFAULT;
> +
> +	memset(alarm_events, 0, sizeof(struct tlclk_alarms));
> +	got_event = 0;
> +
> +	return  sizeof(struct tlclk_alarms);
> +}

Two spaces after the return :(

> +
> +/* Read telecom clock IRQ number (Set by BIOS) */

Indent the comment please.

> +	init_timer(&switchover_timer);
> +/*	switchover_timer.function = switchover_timeout; */
> +/*	switchover_timer.data = 0; */

Remove these commented out lines?

Other than these minor things, and the attribute group stuff, this looks
good.

thanks,

greg k-h
