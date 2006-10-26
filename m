Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWJZTTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWJZTTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWJZTTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 15:19:04 -0400
Received: from c60.cesmail.net ([216.154.195.49]:27183 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S932222AbWJZTTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 15:19:02 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Pavel Roskin <proski@gnu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1161859199.12781.7.camel@localhost.localdomain>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <1161859199.12781.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 15:19:00 -0400
Message-Id: <1161890340.9087.28.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 11:39 +0100, Alan Cox wrote:
> Really ndiswrapper shouldn't be using _GPLONLY symbols, that would
> actually make it useful to the binary driver afflicted again and more
> likely to be legal.

usb_register_driver is using EXPORT_SYMBOL_GPL_FUTURE, which means all
USB drivers will have to be GPL soon.  This would disable the USB
support in ndiswrapper.

There is no other way to register USB drivers.  Apparently, the USB
developers feel that every Linux USB driver should be considered a
derived work of Linux, and therefore should be under GPL.

This means that ndiswrapper would be considered as a derived work of
Linux.  Since ndiswrapper is under GPL, it would suffer unfairly if the
meaning of EXPORT_SYMBOL_GPL is extended to restrict GPLed modules
capable of loading proprietary code into the kernel.

The second problem is sysfs.  Again, using sysfs is only allowed to
GPLed modules for the same reason.  Although ndiswrapper is not using
sysfs now, it would be unfair to restrict it from doing that in the
future.

It's not like the proprietary modules would be using Linux USB or sysfs
API - they are unaware of Linux.  Only the free code can use it.

-- 
Regards,
Pavel Roskin

