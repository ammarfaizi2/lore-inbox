Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265028AbUD3AIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbUD3AIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbUD3AIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:08:37 -0400
Received: from fmr05.intel.com ([134.134.136.6]:27352 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265028AbUD3AI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:08:29 -0400
Date: Thu, 29 Apr 2004 18:55:14 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200404300155.i3U1tEs3004947@snoqualmie.dp.intel.com>
To: akpm@osdl.org, alex.williamson@hp.com, Matt_Domsch@dell.com
Subject: Re: [patch 1/3] efivars driver update and move
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2004-04-29 at 15:19, Matt Domsch wrote:
> > On Thu, Apr 29, 2004 at 01:50:54PM -0600, Alex Williamson wrote:
> > > # stat BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c\ /
> > >   File: `BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c /'
> > 
> > FWIW, my Intel Tiger2-based system doesn't have the space 
> at the end...
> > 
> > >         *(short_name + strlen(short_name)) = '-';
> > >         efi_guid_unparse(vendor_guid, short_name + 
> strlen(short_name));
> > >         *(short_name + strlen(short_name)) = ' ';
> > 
> > even though looking at this I would have expected it to...
> 
>    Yeah, I'm not sure how you couldn't have a space at the end...

That's odd. 

> > Can you remove that last line and see what it does?  Best as I can
> > tell, it isn't necessary or desired.
> 
>    Yes, removing that last line above gets rid of the space, 
> everything
> looks right, and efibootmgr doesn't complain.  I'd attach a patch but
> I'm curious if Matt T. had some reason for adding it.

I had it in there because when I originally rewrote this 
driver for sysfs it kept cutting off the last character.  I
had to put it aside for a bit and just didn't take it out
last week before I resent it.  I just retried it on local
ia64 and x86 machines and it worked fine on both accounts
without the extra space. 

Andrew, can you please apply the following patch to remove 
space?

thanks,
matt


diff -urN linux-2.6.6-rc3-clean/drivers/firmware/efivars.c linux-2.6.6-rc3/drivers/firmware/efivars.c
--- linux-2.6.6-rc3-clean/drivers/firmware/efivars.c	2004-04-27 18:36:33.000000000 -0700
+++ linux-2.6.6-rc3/drivers/firmware/efivars.c	2004-04-29 16:31:48.052355632 -0700
@@ -633,7 +633,6 @@
 
 	*(short_name + strlen(short_name)) = '-';
 	efi_guid_unparse(vendor_guid, short_name + strlen(short_name));
-	*(short_name + strlen(short_name)) = ' ';
 
 	kobject_set_name(&new_efivar->kobj, short_name);
 	kobj_set_kset_s(new_efivar, vars_subsys);
