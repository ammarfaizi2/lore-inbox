Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUHSJvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUHSJvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUHSJvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:51:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:15111 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264915AbUHSJsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:48:35 -0400
Date: Thu, 19 Aug 2004 10:48:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
       wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040819104829.A7705@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	alan@lxorguk.ukuu.org.uk, wtogami@redhat.com,
	linux-kernel@vger.kernel.org
References: <4123E171.3070104@shadowconnect.com> <20040819002448.A3905@infradead.org> <4123E73F.7040409@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4123E73F.7040409@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Thu, Aug 19, 2004 at 01:33:19AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > add a controller_add and add controller_remove method, taking a typesafe
> > i2o_controller * instead of the multiplexer.
> 
> I had this before, but i want the notification also for I2O devices, 
> because the driver model won't call probe functions for devices, which 
> are already occupied by a other driver.

Then please add more methods.  Multiplexer calls are an extremly bad idea.

> This is not the best solution, 
> if you have more then one drivers which could handle a device. This is 
> the case in e.g. i2o_proc, which only want to display information, and 
> is not a "real driver". So finally there will be controller_add, 
> controller_remove, device_add, device_remove... and i thought it would 
> be more generic, and i also don't have to add a function each time a new 
> notification is needed :-)

Yes, that's the whole point of this methods..

> Also i tried to implement the notification like the one already in the 
> kernel, so i could exchange my notification facility with the already 
> existing one (include/linux/notifier.h)...

linux/notifier.h is an bad example to follow and for many thing we're
moving slowly away from it (e.g. the shutdown notifications are now
exposed through the driver model)

