Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUEBPIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUEBPIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 11:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUEBPIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 11:08:36 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:48599 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261443AbUEBPIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 11:08:34 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Sun, 2 May 2004 17:08:15 +0200
From: stefan.eletzhofer@eletztrick.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6 I2C re-add i2c_get_client()
Message-ID: <20040502150815.GA32603@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
References: <20040429140657.GC23468@gonzo.local> <20040502060109.GF31886@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502060109.GF31886@kroah.com>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 11:01:09PM -0700, Greg KH wrote:
> On Thu, Apr 29, 2004 at 04:06:57PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> > Hi,
> > here's a patch which re-adds i2c_get_client() back to i2c_core.c.
> > That call was removed in 2003 because there were no users of that
> > function at that time.
> > 
> > I think this call is needed for I2C chip drivers which provide functionality to
> > be used by other driver modules, for example RTC chips or EEPROMs. These chip
> > drivers tend to encapsulate raw i2c chip access and provide function calls
> > for other modulesi, for example via the i2c_driver->command() method.
> > 
> > I tried to get the locking right, so please comment. The patch is
> > against 2.6.6-rc3 and works quite fine with my i2c rtc chip.
> 
> Locking looks correct, but you also need to increment either the
> device's reference count, and/or the module reference count for the
> client.

I thought that would be the purpose of i2c_use_client(), like the comment
in linux/i2c.h suggests? That call also takes care of the ALLOW_USE flag.

i2c_use_client() increments both the drivers and the adapters module ref
count, if I see it correctly. Then it also increments the clients usage count,
after checking the ALLOW_MULTIPLE_USE flag.

Its counterpart is i2c_release_client().

> 
> Care to fix that up?
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
