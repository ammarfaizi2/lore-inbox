Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263898AbUEHAVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUEHAVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbUEHAVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:21:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:34691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263898AbUEHAVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:21:15 -0400
Date: Fri, 7 May 2004 15:30:28 -0700
From: Greg KH <greg@kroah.com>
To: stefan.eletzhofer@eletztrick.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6 I2C re-add i2c_get_client()
Message-ID: <20040507223027.GE14660@kroah.com>
References: <20040429140657.GC23468@gonzo.local> <20040502060109.GF31886@kroah.com> <20040502150815.GA32603@gonzo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502150815.GA32603@gonzo.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 05:08:15PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> On Sat, May 01, 2004 at 11:01:09PM -0700, Greg KH wrote:
> > On Thu, Apr 29, 2004 at 04:06:57PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> > > Hi,
> > > here's a patch which re-adds i2c_get_client() back to i2c_core.c.
> > > That call was removed in 2003 because there were no users of that
> > > function at that time.
> > > 
> > > I think this call is needed for I2C chip drivers which provide functionality to
> > > be used by other driver modules, for example RTC chips or EEPROMs. These chip
> > > drivers tend to encapsulate raw i2c chip access and provide function calls
> > > for other modulesi, for example via the i2c_driver->command() method.
> > > 
> > > I tried to get the locking right, so please comment. The patch is
> > > against 2.6.6-rc3 and works quite fine with my i2c rtc chip.
> > 
> > Locking looks correct, but you also need to increment either the
> > device's reference count, and/or the module reference count for the
> > client.
> 
> I thought that would be the purpose of i2c_use_client(), like the comment
> in linux/i2c.h suggests? That call also takes care of the ALLOW_USE flag.

Yes, but your new function doesn't call it, right?  What happens if the
driver goes away between the get_client call and the use_client call?
oops...

thanks,

greg k-h
