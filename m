Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264706AbUEVCcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbUEVCcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUEUWiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:38:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:32955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264834AbUEUWdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:54 -0400
Date: Fri, 21 May 2004 08:41:31 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040521154131.GA2283@kroah.com>
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE16D6.3070202@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AE16D6.3070202@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 10:48:54AM -0400, nardelli wrote:
> 
> The old check would error out of visor_open() with -ENODEV if there was
> not a read_urb for any device, and there was a comment that this was
> needed for 'some brain dead Sony devices'.  I modified this to error out
> only for Sony devices, instead of just a comment about them.  This
> should not modify the behavior on Sonys, but may on others (namely treos).
> 
> I'd really like to know more about why some Sony devices do not have a
> read_urb, but at least for now, I did not change functionality for them.

The problem is that the "bad" Sony devices return that they have 2 ports
available, however their endpoints do not reflect this.  So I check for
a read urb to test if this really is a valid port or not.

Hm, now that I can modify the number of ports on the fly, we should just
catch this in the initialization of the device which would solve this
problem the "right way".

thanks,

greg k-h
