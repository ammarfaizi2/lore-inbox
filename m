Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbUKDA2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUKDA2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUKDAZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:25:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:56209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261953AbUKDAVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:21:53 -0500
Date: Wed, 3 Nov 2004 16:21:39 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041104002138.GA32691@kroah.com>
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com> <20041103190757.GA25451@taniwha.stupidest.org> <41892DE3.5040402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41892DE3.5040402@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:13:39PM -0500, Jeff Garzik wrote:
> Chris Wedgwood wrote:
> >On Wed, Nov 03, 2004 at 12:46:40PM -0500, Jeff Garzik wrote:
> >
> >
> >>Wrong.  There are way too many __correct__ drivers to do this at
> >>present.
> >
> >
> >i could claim the same is true of MODULE_PARM yet we spew
> >warning-galore there...
> 
> There is a 2.4 version of module_param().
> 
> The semantics of pci_module_init() versus pci_register_driver() are 
> different across 2.4/2.6.  If you deprecate pci_module_init(), you are 
> breaking drivers which right now can be ported to 2.4 with a simple cp(1).

Yes, but any driver assuming that the pci_module_init() functionality
has not changed from 2.4 to 2.6 will be broken.  I've fixed up all of
the drivers that did this in the 2.6 tree.

> It's just downright silly to deprecate the API that is used most heavily 
> in drivers.

Due to the change in the way the function works, I'm slowly changing
drivers over to the new function.  It's just too dangerous over time to
leave it alone.

Chris, I agree with Christoph, convert more drivers over before marking
this function "obsolete".  In fact, just convert everyone and then
delete the #define all together, that's what I have been working toward.

thanks,

greg k-h
