Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWGXW5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWGXW5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGXW5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:57:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39619 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932311AbWGXW5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:57:15 -0400
Date: Tue, 25 Jul 2006 00:56:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Linux List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [resend] Fix swsusp with PNP BIOS
Message-ID: <20060724225654.GB6263@elf.ucw.cz>
References: <200607242028.01666.linux@rainbow-software.org> <200607242325.50229.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607242325.50229.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-07-24 23:25:50, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday 24 July 2006 20:28, Ondrej Zary wrote:
> > Hello,
> > swsusp is unable to suspend my machine (DTK FortisPro TOP-5A notebook) with 
> > kernel 2.6.17.5 because it's unable to suspend PNP device 00:16 (mouse).
> > 
> > The problem is in PNP BIOS. pnp_bus_suspend() calls pnp_stop_dev() for the 
> > device if the device can be disabled according to pnp_can_disable(). The 
> > problem is that pnpbios_disable_resources() returns -EPERM if the device is 
> > not dynamic (!pnpbios_is_dynamic()) but insert_device() happily sets 
> > PNP_DISABLE capability/flag even if the device is not dynamic. So we try to 
> > disable non-dynamic devices which will fail. 
> > This patch prevents insert_device() from setting PNP_DISABLE if the device is 
> > not dynamic and fixes suspend on my system.
> 
> Thanks for the patch.
> 
> Pavel, what do you think?

Knowing nothing about pnpbios it looks okay to me.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
