Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUIUBjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUIUBjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 21:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIUBjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 21:39:17 -0400
Received: from fmr04.intel.com ([143.183.121.6]:56980 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S267460AbUIUBiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 21:38:55 -0400
Date: Mon, 20 Sep 2004 18:38:46 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Message-ID: <20040920183845.C17763@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201333.42857.dtor_core@ameritech.net> <20040920122404.B15677@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409201812.45933.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Mon, Sep 20, 2004 at 06:12:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 06:12:45PM -0500, Dmitry Torokhov wrote:
> On Monday 20 September 2004 02:24 pm, Keshavamurthy Anil S wrote:
> > On Mon, Sep 20, 2004 at 01:33:42PM -0500, Dmitry Torokhov wrote:
> > > On Monday 20 September 2004 11:35 am, Keshavamurthy Anil S wrote:
> > > > This patch support /sys/firmware/acpi/eject interface where in 
> > > > the ACPI device say "LSB0" can be ejected by echoing "\_SB.LSB0" > 
> > > > /sys/firmware/acpi/eject
> > > > 
> > > 
> > > I wonder if eject should be an attribute of an individual device and visible
> > > only when device can be ejected. Reading from it could show eject level
> > > (_EJ0/_EJ3 etc).
> > Hi Dmitry,
> > 	Today there is really no sysfs representation of acpi devices apart from
> > the acpi namespace representation. Evaluating acpi namespaces's _EJ0 method won't help,
> > as we need acpi device and all its child devices to be removed as part of the eject.
> > 
> > Also for there is no 1:1 maping of acpi devices to pci devices to consider eject to be
> > part of the pci devices.
> > 
> > Hence the best solution for now is to echo ACPI full path name of the device to be
> > ejected onto the eject file and the code will make sure that the device supports _EJx method before actuall removing the device.
> > 
> 
> Hi Anil,
> 
> I obviously failed to deliver my idea :) I meant that I would like add eject
> attribute (along with maybe status, hid and some others) to kobjects in
> /sys/firmware/acpi tree.
I got this one and as I have said I will come up with the path soon:)
> 
> I also wonder if userspace should traverse tree and emit eject requests for
> children. While it is OK for user[space]-initiated removal what about surprise
> removal. My concern that scripts will not be ready for all devices to be
> suddently gone... Would not it be beter if generic handler for BUS_CHECK was
> implemented in acpi/bus.c that would add/remove acpi devices and notify
> userspace via hotplug?

Can you please clarify my concern here.

Currently I am handling both the surprise removal and the eject request in the same
way, i,e send the notification to the userland and the usermode agent scripts
is responsible for offlining of all the devices and then echoing onto eject file.

My worry is if we implement a generic handler for BUS_CHECK, then what would you 
do if the device fails to remove, i.e what action to take if the device remove fails?

Thanks,
Anil

