Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTIDXrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTIDXro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:47:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:65209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261530AbTIDXrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:47:31 -0400
Date: Thu, 4 Sep 2003 16:47:38 -0700
From: Greg KH <greg@kroah.com>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org,
       linux-security-module@mail.wirex.com
Subject: Re: [PATCH] (improved) LSM root_plug fixup
Message-ID: <20030904234738.GA12556@kroah.com>
References: <20030804200130.GA8719@outpost.ds9a.nl> <20030805095840.GA29628@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805095840.GA29628@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 11:58:40AM +0200, bert hubert wrote:
> Stephen Smalley noticed a typo in my new Makefile and suggested rediffing
> against bitkeeper which now has SELinux merged. 
> 
> Further changes, added small comment, added module license & description,
> actually tested compiling the kernel with different security settings.
> 
> Please consider applying.

Sorry for the long delay, I've been busy with other stuff.

Yes, you are correct, this kind of change is necessary in order to get
root_plug working again.

I only have one very tiny, cosmetic, problem with the patch:


> --- linux-2.6.0-test2-bk/security/capability.c	2003-08-05 09:45:07.000000000 +0200
> +++ linux-2.6.0-test2-bk-ahu/security/capability.c	2003-08-05 11:03:58.000000000 +0200
> @@ -6,6 +6,7 @@
>   *	the Free Software Foundation; either version 2 of the License, or
>   *	(at your option) any later version.
>   *
> + *	2003-08-05	Split out common functions to commoncap.c (ahu@ds9a.nl)
>   */
>  
>  #include <linux/config.h>
> @@ -23,333 +24,6 @@

and:

> --- linux-2.6.0-test2-bk/security/commoncap.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.0-test2-bk-ahu/security/commoncap.c	2003-08-05 11:04:01.000000000 +0200
> @@ -0,0 +1,354 @@
> +/* Common capabilities, needed by capability.o and root_cap.o 
> + *
> + *	This program is free software; you can redistribute it and/or modify
> + *	it under the terms of the GNU General Public License as published by
> + *	the Free Software Foundation; either version 2 of the License, or
> + *	(at your option) any later version.
> + *
> + *	2003-08-05	Split out from capability.c (ahu@ds9a.nl)
> + */

Please do not add "changelog" type comments to files that do not already
have changelogs in them.  They are unmaintainable within the kernel and
do nothing to help anyone out.

Rely on the change history that we now have due to the use of bitkeeper,
which shows your name associated with a specific changeset.

If you take these lines out, I have no problem with the patch.

thanks,

greg k-h
