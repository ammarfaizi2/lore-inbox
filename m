Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVCEVTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVCEVTc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVCEVTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:19:32 -0500
Received: from linux.us.dell.com ([143.166.224.162]:7564 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261172AbVCEVTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:19:03 -0500
Date: Sat, 5 Mar 2005 15:18:56 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EFI missing failure handling
Message-ID: <20050305211856.GA28515@lists.us.dell.com>
References: <20050305153841.GA7808@mech.kuleuven.ac.be> <200503051906.31518.adobriyan@mail.ru> <20050305201734.GA8880@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305201734.GA8880@mech.kuleuven.ac.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 09:17:34PM +0100, Panagiotis Issaris wrote:
> Hi,
> 
> On Sat, Mar 05, 2005 at 07:06:29PM +0200 or thereabouts, Alexey Dobriyan wrote:
> > On Saturday 05 March 2005 17:38, Panagiotis Issaris wrote:
> > 
> > > The EFI driver allocates memory and writes into it without checking the
> > > success of the allocation:
> > > 
> > > 668     efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
> > > ...
> > > 696     memset(variable_name, 0, 1024);
> > 
> > > --- linux-2.6.11-orig/drivers/firmware/efivars.c
> > > +++ linux-2.6.11-pi/drivers/firmware/efivars.c
> > > @@ -670,6 +670,9 @@ efivars_init(void)
> > 
> > > +	if (!variable_name)
> > > +		return -ENOMEM;
> > > +
> > >  	if (!efi_enabled)
> > >  		return -ENODEV; 
> > 
> > I'd better move kmalloc() and checking for success down right before
> > memset(). Otherwise you leak if efi_enabled == 0.
> > Oh, and efivars_init() wants to return "error", not unconditionally 0.
> > 
> > 	Alexey
> 
> Thanks! How about the updated patch?

Looks good to me.  Good catch, and thanks for the patch!  Please
forward to Andrew Morton (akpm@osdl.org) directly, following the
format described here: http://linux.yyz.us/patch-format.html

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
