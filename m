Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271110AbTGPUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271112AbTGPUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:54:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:48094 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271110AbTGPUyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:54:01 -0400
Date: Wed, 16 Jul 2003 14:02:54 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030716210253.GD2279@kroah.com>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716130915.035a13ca.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 01:09:15PM -0700, Andrew Morton wrote:
> > Here's a patch against 2.6.0-test1-mm that fixes up the different places
> > where we export a dev_t to userspace.  This fixes all of the compiler
> > warnings that were previously reported with these files.
> 
> I added this as well:
> 
> static inline char *format_dev_t(char *buffer, dev_t dev)
> {
> 	sprintf(buffer, "%04lx\n", (unsigned long)dev);
> 	return buffer;
> }
> 
> tp be placed direct in a printk().

Nice.

> We'll probably need to do something more fancy in here later, because once
> a dev_t becomes 32:32, it'll need to be printed out with "%016llx", which
> is daft.
> 
> So we'll need to come up with some standardised way of presenting a dev_t
> to the user.  Presumably that will just be
> 
> 	sprintf(buf, "%d:%d", major(dev), minor(dev));
> 	
> But if we do this, will it break your existing stuff?

No, I don't think there are any users of udev right now :)

I wouldn't mind the ':' being there, makes my life a bit easier, but for
some reason Al Viro didn't want to do that a long time ago...

If we put the ':' in there, it protects userspace from having to deal
with different sized dev_t, so that really makes sense.

thanks,

greg k-h
