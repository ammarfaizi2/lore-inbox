Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266093AbUEUWc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266093AbUEUWc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUEUWc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:32:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:20416 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266093AbUEUWc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:32:27 -0400
Date: Fri, 21 May 2004 15:30:24 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040521223024.GA7399@kroah.com>
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AE7CFE.5060805@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 06:04:46PM -0400, nardelli wrote:
> 
> Maybe I spoke too soon here.  We have 1 bulk in, 2 bulk out, and 1 interrupt
> in endpoint, which by the logic in usb-serial, translates to 2 ports.  Only
> one of those ports can have a read_urb associated with it, unless we want to
> do some really fancy juggling.  This means that we're going to have a port
> that does not have a valid read_urb associated with it, even after open().

But the call to open() fails, which prevents any of the other tty calls
from happening on that port.  That's why we don't need to make that
check anywhere else.

> I'm at a loss why this device has an uneven number of bulk in and bulk out
> endpoints.

Stupid hardware engineers?  Who really knows...

thanks,

greg k-h
