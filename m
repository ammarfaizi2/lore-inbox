Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVA2AJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVA2AJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 19:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVA2AJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 19:09:36 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48007 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262826AbVA2AJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 19:09:32 -0500
Subject: Re: [RFC][PATCH] add driver matching priorities
From: Adam Belay <abelay@novell.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: greg@kroah.com, rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <200501281851.28475.dtor_core@ameritech.net>
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <200501281823.27132.dtor_core@ameritech.net>
	 <1106955187.29709.24.camel@localhost.localdomain>
	 <200501281851.28475.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 19:05:10 -0500
Message-Id: <1106957111.15906.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 18:51 -0500, Dmitry Torokhov wrote:
> If generic driver binds to a device that is has no idea how to drive
> _at all_ then I will argue that the generic driver is broken. It should
> not bind to begin with.
> 

In the case of pci bridges, sometimes we can't really tell if we can
drive the hardware entirely.  It's a classcode match.  Generic drivers
may support a portion of hardware in a limited fashion.  It's not that
they have no idea what they're doing with the hardware.  It's more a
matter of not always doing the best or most complete thing.  For some
hardware this may work fine.  Because we don't support generic drivers
in the current driver model, we haven't had a chance to see how well
they would work, or where they could be used.

Also, consider this.  If the pci bridge driver binds to yenta, it will
(in theory, it also might explode) enumerate all of the cardbus devices.
If then later, it is discovered that there is a better driver for the
bridge, all of the bridge's children will have to be torn down.  Thier
drivers will be released, and  the devices removed.  This might increase
the odds of something going wrong.

Thanks,
Adam


