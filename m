Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVLJPrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVLJPrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 10:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVLJPrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 10:47:19 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:35597 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964819AbVLJPrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 10:47:18 -0500
Date: Sat, 10 Dec 2005 16:49:28 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple
 prototype
Message-Id: <20051210164928.3a7f57fb.khali@linux-fr.org>
In-Reply-To: <20051208232254.GC9357@flint.arm.linux.org.uk>
References: <20051205202707.GH15201@flint.arm.linux.org.uk>
	<200512070105.40169.dtor_core@ameritech.net>
	<d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
	<20051207180842.GG6793@flint.arm.linux.org.uk>
	<d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
	<20051207190352.GI6793@flint.arm.linux.org.uk>
	<d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com>
	<20051207225126.GA648@kroah.com>
	<d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com>
	<20051208215257.78d7c67a.khali@linux-fr.org>
	<20051208232254.GC9357@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> On Thu, Dec 08, 2005 at 09:52:57PM +0100, Jean Delvare wrote:
> > BTW, doesn't this suggest that the error path in
> > platform_device_register_simple() is currently broken as well? If
> > platform_device_add() fails therein, I take it that the resources
> > previously allocated by platform_device_add_resources() will never be
> > freed.
> 
> No.  If platform_device_add() fails then you platform_device_put()
> it with no other action.  If it's been added, with the current
> available interfaces, your only option is to
> platform_device_unregister() it.
> 
> So:
> 
> - error during platform_device_alloc, no additional action necessary
> - error returned by platform_device_add, you have a structure allocated
>   and initialised, you platform_device_put it.
> - subsequently you want to get rid of it, platform_device_unregister it,
>   or alternatively platform_device_del + platform_device_put it (where
>   provided.)
> 
> This is actually a generic driver model rule which can be applied to
> all driver model interfaces which have the alloc/init, add, del, put,
> register, unregister methods.

I was fine with the sequence you are describing above. The only thing
which was worrying me was platform_device_add_resources(), until I
realized that this function was really only preparing the resources for
reservation. For some reason I was erroneously thinking that it was
also requesting the resources "for real", so I was worried that
platform_device_put wouldn't release these if platform_device_add was
failing.

This all makes sense to me now. Thanks for the clarification, and sorry
for being a bit slow to figure out how the platform stuff works.

I'll post the platform driver I am currently working on later today for
comments. I'm pretty sure I'm still not using the platform
infrastructure the way it was meant to be, and would appreciate hints on
how I can do it better.

Thanks again,
-- 
Jean Delvare
