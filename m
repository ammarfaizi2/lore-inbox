Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbUAVIFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAVIFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:05:35 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7296 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264449AbUAVIFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:05:34 -0500
Date: Thu, 22 Jan 2004 08:13:33 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
To: Andrew Morton <akpm@osdl.org>, ncunningham@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040121234956.557d8a40.akpm@osdl.org>
References: <1074735774.31963.82.camel@laptop-linux>
 <20040121234956.557d8a40.akpm@osdl.org>
Subject: Re: PATCH: Shutdown IDE before powering off.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Andrew Morton <akpm@osdl.org>:
> Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
> >
> > +static void ide_drive_shutdown (struct device * dev)
> >  +{
> >  +	generic_ide_suspend(dev, 5);
> >  +}
> >  +
> >   int ide_register_driver(ide_driver_t *driver)
> >   {
> >   	struct list_head list;
> >  @@ -2519,6 +2524,7 @@
> >   	driver->gen_driver.name = (char *) driver->name;
> >   	driver->gen_driver.bus = &ide_bus_type;
> >   	driver->gen_driver.remove = ide_drive_remove;
> >  +	driver->gen_driver.shutdown = ide_drive_shutdown;
> 
> This spins down the disk(s) when you're just doing do a reboot.  That's
> fairly irritating and could affect reboot times if one has many disks.

I think it is an attempt to force some broken drives to flush their
cache, but I wonder whether it will simply move the problem from one
set of broken drives to another :-).

John.
