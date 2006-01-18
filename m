Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWARBMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWARBMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWARBMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:12:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:53132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932441AbWARBMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:12:19 -0500
Date: Tue, 17 Jan 2006 17:12:00 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Message-ID: <20060118011200.GA28086@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Define a release method for the ubd and network driver so that sysfs doesn't
> complain when one is removed via:

What?  No.  The kernel is complaining for a reason, don't try to
out-smart it.

> 
> host $ uml_mconsole <umid> remove <dev>
> 
> Done by Jeff around January for ubd only, later lost, then restored in his tree
> - however I'm merging it now since there's no reason to leave this here.
> 
> We don't need to do any cleanup in the new added method, because when hot-unplug
> is done by uml_mconsole we already handle cleanup in mconsole infrastructure,
> i.e.  mc_device->remove (net_remove/ubd_remove), which is also the calling
> method.

Huh?  You have 2 different release functions for the same object?  And
how do you know which one is correct?  That does not sound right at all.

Please fix this correctly.

thanks,

greg k-h
