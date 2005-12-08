Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVLHVfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVLHVfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVLHVfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:35:00 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:47888 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932352AbVLHVfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:35:00 -0500
Date: Thu, 8 Dec 2005 22:37:05 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple
 prototype
Message-Id: <20051208223705.6d375083.khali@linux-fr.org>
In-Reply-To: <d120d5000512081321p36c422cdg4d360263d89fa826@mail.gmail.com>
References: <20051205212337.74103b96.khali@linux-fr.org>
	<20051205202707.GH15201@flint.arm.linux.org.uk>
	<200512070105.40169.dtor_core@ameritech.net>
	<20051207170426.GB28414@kroah.com>
	<d120d5000512081321p36c422cdg4d360263d89fa826@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> Another thing - bunch of input code currently creates platform devices
> but does not create corresponding platform drivers (because they don't
> support suspend/resume or shutdown and probing is done right there in
> module init function).
> 
> What is the general policy on platform devices? Should they always have
> a corresponding driver or is it OK to leave them without one?

If it wasn't OK, I'd expect platform_device_alloc and
platform_device_register to fail when no matching driver is found.
Since they do not, I'd guess it is considered OK not to have a matching
driver. But that's really only a guess and not a replacement for
Russell's (or Greg's) authoritative answer.

Reciprocally, if it is finally decided that it is *not* OK to have a
platform device without a driver, they we want to make both functions
mentioned above fail when no match is found.

I am interested in the answer myself, as I am just realizing that my
own driver registers a platform driver but doesn't use it at all, just
like Dmitry described for his input drivers - so if I am allowed not to
register this platform driver I may just drop that part.

Thanks,
-- 
Jean Delvare
