Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUIUATM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUIUATM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUIUATK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:19:10 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:24727 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267413AbUIUATC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:19:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Mon, 20 Sep 2004 18:12:45 -0500
User-Agent: KMail/1.6.2
Cc: "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201333.42857.dtor_core@ameritech.net> <20040920122404.B15677@unix-os.sc.intel.com>
In-Reply-To: <20040920122404.B15677@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409201812.45933.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 September 2004 02:24 pm, Keshavamurthy Anil S wrote:
> On Mon, Sep 20, 2004 at 01:33:42PM -0500, Dmitry Torokhov wrote:
> > On Monday 20 September 2004 11:35 am, Keshavamurthy Anil S wrote:
> > > This patch support /sys/firmware/acpi/eject interface where in 
> > > the ACPI device say "LSB0" can be ejected by echoing "\_SB.LSB0" > 
> > > /sys/firmware/acpi/eject
> > > 
> > 
> > I wonder if eject should be an attribute of an individual device and visible
> > only when device can be ejected. Reading from it could show eject level
> > (_EJ0/_EJ3 etc).
> Hi Dmitry,
> 	Today there is really no sysfs representation of acpi devices apart from
> the acpi namespace representation. Evaluating acpi namespaces's _EJ0 method won't help,
> as we need acpi device and all its child devices to be removed as part of the eject.
> 
> Also for there is no 1:1 maping of acpi devices to pci devices to consider eject to be
> part of the pci devices.
> 
> Hence the best solution for now is to echo ACPI full path name of the device to be
> ejected onto the eject file and the code will make sure that the device supports _EJx method before actuall removing the device.
> 

Hi Anil,

I obviously failed to deliver my idea :) I meant that I would like add eject
attribute (along with maybe status, hid and some others) to kobjects in
/sys/firmware/acpi tree.

I also wonder if userspace should traverse tree and emit eject requests for
children. While it is OK for user[space]-initiated removal what about surprise
removal. My concern that scripts will not be ready for all devices to be
suddently gone... Would not it be beter if generic handler for BUS_CHECK was
implemented in acpi/bus.c that would add/remove acpi devices and notify
userspace via hotplug?

-- 
Dmitry
