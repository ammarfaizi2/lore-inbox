Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbVLHV5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVLHV5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbVLHV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:57:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:12214 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932689AbVLHV5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:57:10 -0500
Date: Thu, 8 Dec 2005 13:55:22 -0800
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Driver bind/unbind and __devinit
Message-ID: <20051208215522.GA25925@suse.de>
References: <d120d5000512081314r6b574eb3jf5516ef5bc28730d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000512081314r6b574eb3jf5516ef5bc28730d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 04:14:58PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Many drivers have their probe routines declared as __devinit which is
> a no-op unless CONFIG_HOTPLUG is set. However driver's bind/unbind
> attributes are created unconditionally, as fas as I can see. Would not
> it cause an oops if someone tries to use these attributes with
> CONFIG_HOTPLUG=N? Am I missing something?

You are missing the CONFIG_HOTPLUG checks around the functions that add
and check the device ids from these sysfs files.  If CONFIG_HOTPLUG is
not enabled, those files do not do anything.

In 2.6.16, CONFIG_HOTPLUG is moving under CONFIG_EMBEDDED, so the odds
of people disabling it are going to be pretty small now.

> Also, unbind implementation does not seem safe - we check the driver
> before taking device's semaphore so we risk unbinding wrong driver (in
> the unlikely event that we manage to unbind and bind another driver in
> another thread).

Do you have a suggestion as to how to fix this?

thanks,

greg k-h
