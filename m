Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUEBGW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUEBGW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUEBGVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:21:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:45709 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261505AbUEBGVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:21:44 -0400
Date: Sat, 1 May 2004 23:01:09 -0700
From: Greg KH <greg@kroah.com>
To: stefan.eletzhofer@eletztrick.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6 I2C re-add i2c_get_client()
Message-ID: <20040502060109.GF31886@kroah.com>
References: <20040429140657.GC23468@gonzo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429140657.GC23468@gonzo.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 04:06:57PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> Hi,
> here's a patch which re-adds i2c_get_client() back to i2c_core.c.
> That call was removed in 2003 because there were no users of that
> function at that time.
> 
> I think this call is needed for I2C chip drivers which provide functionality to
> be used by other driver modules, for example RTC chips or EEPROMs. These chip
> drivers tend to encapsulate raw i2c chip access and provide function calls
> for other modulesi, for example via the i2c_driver->command() method.
> 
> I tried to get the locking right, so please comment. The patch is
> against 2.6.6-rc3 and works quite fine with my i2c rtc chip.

Locking looks correct, but you also need to increment either the
device's reference count, and/or the module reference count for the
client.

Care to fix that up?

thanks,

greg k-h
