Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUIJUjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUIJUjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUIJUjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:39:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:50831 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267779AbUIJUiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:38:50 -0400
Date: Fri, 10 Sep 2004 13:30:46 -0700
From: Greg KH <greg@kroah.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev: udevd shall inform us abot trouble
Message-ID: <20040910203046.GA19655@kroah.com>
References: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 10:18:43AM +0300, Denis Vlasenko wrote:
> Hi Greg,
> 
> I found out why udev didn't work for me.
> At first I compiled it with wrong install path ($DESTDIR).
> On subsequent recompiles with corrected DESTDIR binaries
> were still compiled with old DESTDIR hardcoded into them.
> 
> I think this Make rule is generating a udev_version.h:
> 
> # Rules on how to create the generated header files
> udev_version.h:
>         @echo \#define UDEV_VERSION             \"$(VERSION)\" > $@
>         @echo \#define UDEV_ROOT                \"$(udevdir)/\" >> $@
>         @echo \#define UDEV_DB                  \"$(udevdir)/.udev.tdb\" >> $@
>         @echo \#define UDEV_CONFIG_DIR          \"$(configdir)\" >> $@
>         @echo \#define UDEV_CONFIG_FILE         \"$(configdir)/udev.conf\" >> $@
>         @echo \#define UDEV_RULES_FILE          \"$(configdir)/rules.d\" >> $@
>         @echo \#define UDEV_PERMISSION_FILE     \"$(configdir)/permissions.d\" >> $@
>         @echo \#define UDEV_LOG_DEFAULT         \"yes\" >> $@
>         @echo \#define UDEV_BIN                 \"$(DESTDIR)$(sbindir)/udev\" >> $@
>         @echo \#define UDEVD_BIN                \"$(DESTDIR)$(sbindir)/udevd\" >> $@
> 
> which is not re-created even if DESTDIR has changed.
> 
> As a result, udevd was trying to exec udev with wrong path.

Ick, not nice.

> I built udev with:
> 
> USE_LOG = true
> DEBUG = false
> 
> but udevd does not log anything under such setting (all
> udevd messages are coded as debug messages).
> 
> This patch improves situation by changing some dbg()'s
> into info()'s.

No, I don't like this change, as it increases the size of udevd pretty
unnecessarily (errors like what happened to you are very rare, and we
could blame them on pilot error...)

thanks,

greg k-h
