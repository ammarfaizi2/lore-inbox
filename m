Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272616AbTHFVYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272619AbTHFVYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:24:04 -0400
Received: from mail.kroah.org ([65.200.24.183]:26843 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272616AbTHFVYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:24:01 -0400
Date: Wed, 6 Aug 2003 14:23:36 -0700
From: Greg KH <greg@kroah.com>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: usbcore module can't unload after swsusp
Message-ID: <20030806212335.GA7387@kroah.com>
References: <1060197664.1368.14.camel@litshi.luna.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060197664.1368.14.camel@litshi.luna.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 10:42:06PM +0300, Micha Feigin wrote:
> I am running a patched kernel 2.4.21 with acpi and swsusp ver 1.0.3
> with usb compiled in as a module.
> 
> When kernel loads for the first time everything works fine, all usb
> modules can be loaded and unloaded properly. After suspending and
> restarting, the computer comes up fine and everything works. The
> problem is that at this point, when I try to unload the usbcore module
> it gets to the point of calling usb_hub_cleanup in drivers/usb/hub.c.
> At this points it tried to kill khubd with killproc, which works fine
> (the process is stoped), with a return value of 0. The problem is that
> at this point the function locks on the call
> wait_for_completion(&khubd_exited); which never returns, and rmmod gets
> locked. I tried changing the DECLARE_COMPLETION call so that it will be
> redone each time the module starts but it didn't solve the problem. Any
> ideas on how to further persue this or whether there is a known
> solution?

Unload the usb modules before suspending.

Good luck,

greg k-h
