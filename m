Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUCSBNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUCSBNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:13:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:31706 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261803AbUCSBNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:13:39 -0500
Date: Thu, 18 Mar 2004 17:00:15 -0800
From: Greg KH <greg@kroah.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: whiteheat USB serial compile failure on PPC (2.6)
Message-ID: <20040319010015.GE19053@kroah.com>
References: <Pine.GSO.4.44.0403181205080.15185-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403181205080.15185-100000@math.ut.ee>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:06:38PM +0200, Meelis Roos wrote:
> Whiteheat USB serial driver doesn't compile on PPC in 2.6 (in fact,
> hasn't compiled fo some time):
> 
> drivers/usb/serial/whiteheat.c: In function `firm_setup_port':
> drivers/usb/serial/whiteheat.c:1225: error: `CMSPAR' undeclared (first use in this function)
> drivers/usb/serial/whiteheat.c:1225: error: (Each undeclared identifier is reported only once
> drivers/usb/serial/whiteheat.c:1225: error: for each function it appears in.)

Bah, looks like PPC doesn't ever define CMSPAR :(

How about adding something like:
	#ifndef CMSPAR
	#define CMSPAR 0
	#endif
To the beginning of the driver like the cdc-acm.c driver does?  If that
works, care to send me a patch?

thanks,

greg k-h
