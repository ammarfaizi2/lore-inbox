Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUIUFfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUIUFfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 01:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUIUFfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 01:35:05 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:47220 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267306AbUIUFe5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 01:34:57 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Tue, 21 Sep 2004 00:34:53 -0500
User-Agent: KMail/1.6.2
Cc: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409202020.05776.dtor_core@ameritech.net> <1095730900.8780.76.camel@mythbox>
In-Reply-To: <1095730900.8780.76.camel@mythbox>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409210034.53554.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 September 2004 08:41 pm, Alex Williamson wrote:
> Dmitry,
> 
>    I imagined the sanitized interfaces would be provided via a userspace
> library, similar to how lspci provides a clean interface to all of the
> PCI data.  An "lsacpi" tool could extract the information into something
> more like you suggest.  If you have objects exposed as human
> readable/writable files, I think you'll quickly end up with a _STA
> driver, _HID driver, _CID driver, _ADR driver, _UID driver, _EJx driver,
> etc, etc, etc...  I don't think we want that kind of bloat in the kernel
> (that's what userspace is for ;^).  Providing a solid, direct interface
> to ACPI methods in the kernel seems like the most flexible, powerful
> interface IMHO.

Hmm, I do not quite agree. Except for "eject" being writeable to initiate
eject action the rest of the attributes would reflect kernel's view of the
device state and not re-evaluated when userspace references them. Monitoring
(or rather reacting to various events, like DEVICE_CHECK and BUS_CHECK) and
updating devices' statuses and other data is responsibility of the core ACPI
system. If system administrator is forced to manually (via libacpi or sysfs)
query device status to "kick" the device into working state I'd consider it
a bug, would'nt you agree? 

I see that in your other mail you mention _CRS parsing and chipset discovery.
I think that if you had an ability to just retrieve raw ACPI data from the
system that would suffice. In other words during normal operations there
is no need for "active" ACPI methods (such as _WAK, _S4, etc) to be available
from userspace. And just exporting raw data solves problem of bloating kernel
with parsing of vendor-specific data. I wonder if any of these methods need
arguments to run - if not then we would not need any adjustments to sysfs
opeen/close methods.

I am not saying that we should chose one method or another. I think they both
can co-exist, as they can be used for diffectent purposes - the raw ACPI access 
can affect state of the box while the sanitized attributes present kernel's
view and can be used to verify results of some action from kernel's POV.

-- 
Dmitry
