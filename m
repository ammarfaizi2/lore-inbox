Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVB1TrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVB1TrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVB1TrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:47:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:11406 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261521AbVB1TrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:47:20 -0500
Date: Mon, 28 Feb 2005 11:46:42 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: split kobject creation and hotplug event generation
Message-ID: <20050228194642.GA21323@kroah.com>
References: <20050226055316.GA14317@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226055316.GA14317@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 06:53:16AM +0100, Kay Sievers wrote:
> This splits the implicit generation of a hotplug events from
> kobject_add() and kobject_del(), to give the user of of these
> functions control over the time the event is created.
> 
> The kobject_register() and unregister functions still have the same
> behavior and emit the events by themselves.
> 
> The class, block and device core is changed now to emit the hotplug
> event _after_ the "dev" file, the "device" symlink and the default
> attributes are created. This will save udev from spinning in a stat() loop
> to wait for the files to appear, which is expensive if we have a lot of
> concurrent events.

So, does this solve the issue that everyone has been complaining about
for years with the hotplug event happening before the sysfs files are
present?  And if we add this, can we pretty much get rid of all of the
wait_for_sysfs like logic in udev?

thanks,

greg k-h
