Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbTIJXp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbTIJXp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:45:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:15336 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266055AbTIJXpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:45:22 -0400
Date: Wed, 10 Sep 2003 16:45:38 -0700
From: Greg KH <greg@kroah.com>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030910234538.GB6719@kroah.com>
References: <20030909222421.GA7703@kroah.com> <20030911003247.V30046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911003247.V30046@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 12:32:47AM +0100, Russell King wrote:
> On Tue, Sep 09, 2003 at 03:24:21PM -0700, Greg KH wrote:
> > A while ago we had talked about adding a kobject to struct module.  By
> > doing this we add support for module paramaters and other module info to
> > be exported in sysfs.  So here's a patch that does this that is against
> > 2.6.0-test4 (it applies with some fuzz, sorry.)
> 
> Please excuse my short-sightedness, but I think the following points
> haven't been thought deeply enough:
> 
> - modules which use their parameters on initialisation only once.
>   (eg, 3c59x "full_duplex" parameter)
> 
> - Also, what about module parameters which modules aren't expecting to
>   change beneath themselves? (eg, all the watchdog modules)
> 
> - Are we opening the floodgates for another round of races and driver
>   updates?

If you set the "perm" portion of the module_param() macro to 0, then the
sysfs file will not be created.  That will cause all of the old modules
that use the MODULE_PARAM() macro to not have things change for them, as
they will not be expecting it.

To quote from include/linux/moduleparam.h:
/* This is the fundamental function for registering boot/module
   parameters.  perm sets the visibility in driverfs: 000 means it's
   not there, read bits mean it's readable, write bits mean it's
   writable. */

Sound ok with you?

thanks,

greg k-h
