Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWATRzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWATRzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWATRzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:55:00 -0500
Received: from fmr20.intel.com ([134.134.136.19]:60816 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751005AbWATRy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:54:59 -0500
Subject: Re: [Pcihpd-discuss] [patch 2/4] acpiphp: handle dock bridges
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
In-Reply-To: <87r773a8dz.wl%muneda.takahiro@jp.fujitsu.com>
References: <20060116200218.275371000@whizzy>
	 <1137545819.19858.47.camel@whizzy>
	 <87r773a8dz.wl%muneda.takahiro@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 09:56:59 -0800
Message-Id: <1137779819.16192.5.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 20 Jan 2006 17:53:56.0925 (UTC) FILETIME=[7C28F6D0:01C61DEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 12:24 +0900, MUNEDA Takahiro wrote:
> Hi,
> 
> At Tue, 17 Jan 2006 16:56:59 -0800,
> Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> > 
> > @@ -681,6 +713,88 @@ static int acpiphp_configure_ioapics(acp
> (snip)
> > +static int acpiphp_bus_add(struct acpiphp_func *func)
> > +{
> > +	acpi_handle phandle;
> > +	struct acpi_device *device, *pdevice;
> > +	int ret_val;
> > +
> > +	acpi_get_parent(func->handle, &phandle);
> > +	if (acpi_bus_get_device(phandle, &pdevice)) {
> > +		dbg("no parent device, assuming NULL\n");
> > +		pdevice = NULL;
> > +	}
> > +	ret_val = acpi_bus_add(&device, pdevice, func->handle,
> > +			ACPI_BUS_TYPE_DEVICE);
> > +	if (ret_val)
> > +		dbg("cannot add bridge to acpi list\n");
> > +
> > +	/*
> > +	 * try to start anyway.  We could have failed to add
> > +	 * simply because this bus had previously been added
> > +	 * on another dock.  Don't bother with the return value
> > +	 * we just keep going.
> > +	 */
> > +	ret_val = acpi_bus_start(device);
> > +
> > +	return ret_val;
> > +}
> > +
> > +
> > +
> 
> When the device is docked, acpi_bus_add() is called to register
> the device into acpi list. But if the device is undocked,
> acpi_bus_trim() doesn't called.
> Can you hot-add/remove the dock station repeatedly?
> 
> Thanks,
> MUNE
> 

Yes you can.  The reason for this is because even if we fail the call to
acpi_bus_add(), we ignore the return value and call acpi_bus_start()
anyway.

