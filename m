Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTIHPul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbTIHPul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:50:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:41419 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262691AbTIHPuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:50:40 -0400
Date: Mon, 8 Sep 2003 08:50:48 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
Message-ID: <20030908155048.GA10879@kroah.com>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 10:53:08PM -0400, Zwane Mwaikambo wrote:
> Randy gave me the courage to delve in there... now that i'm lost to the 
> world here is one picked up from bugzilla;
> 
> The crux of it is that the floppy driver isn't deleting timers before 
> unloading itself. I've tested it locally somewhat, but the ioport 
> busy looks very strange (although things do function). There is one part 
> of this patch that i'd like Greg to look at, it's the 
> default_device_release addition...

Ick, no, I do not want to see this function get added, sorry.

What happens if someone grabs the struct device reference by opening a
sysfs file and then you unload the module?  Yeah, not nice.  Please do
_not_ create "empty" release() functions, unless you _really_ know what
you are doing (and providing a "default" one like this is just ripe for
abuse, that warning message in the kernel is there for a reason.)

thanks,

greg k-h
