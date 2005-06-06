Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVFFSRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVFFSRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFFSRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:17:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:7147 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261625AbVFFSQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:16:39 -0400
Date: Mon, 6 Jun 2005 11:16:09 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050606181608.GA10988@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3AB@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3AB@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 11:27:53AM -0500, Abhay_Salunke@Dell.com wrote:
> > The firmware class creates a sysfs file.  That is what I am referring
> to
> > here.
> > 
> By doing a copy of the image to the sysfs file are we trying to do the
> automatic actions done by the hotplug scripts manually?

Ok, it seems everyone is way confused here.  This is what I was thinking
of when I suggested using the firmware code:
	- module loads and registers with firmware core doing the
	  "request_firmware_nowait" call.
	- a hotplug event gets generated that everyone just ignores
	  (because it isn't really a big deal.)
	- At some point, the user copies the firmware to the sysfs file
	  because they want to update their bios.
	- the module is then told that firmware is present and it does
	  something with it.

Note, that between step 2 and 3, it could be _days_ or _months_.  No
need to touch any hotplug scripts at all.

Does this make more sense now?  It seems pretty simple to me...

thanks,

greg k-h
