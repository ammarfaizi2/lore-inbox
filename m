Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267902AbUHPTjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267902AbUHPTjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267911AbUHPTjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:39:14 -0400
Received: from fmr01.intel.com ([192.55.52.18]:49806 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S267902AbUHPTjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:39:11 -0400
Subject: Re: eth*: transmit timed out since .27
From: Len Brown <len.brown@intel.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41210098.4080904@gmx.net>
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>
	 <1092678734.23057.18.camel@dhcppc4>  <41210098.4080904@gmx.net>
Content-Type: text/plain
Organization: 
Message-Id: <1092685109.23057.27.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Aug 2004 15:38:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 14:44, Oliver Feiler wrote:

>   14:       9296    IO-APIC-edge  ide0
>   15:       9078    IO-APIC-edge  ide1
>   17:         24   IO-APIC-level  eth1
>   18:     125085   IO-APIC-level  eth0
>   21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
>   22:          0   IO-APIC-level  via82cxxx
>   23:       2976   IO-APIC-level  eth2
> NMI:          0
> LOC:     112313
> ERR:          0
> MIS:         42

This is unusual.
MIS is a hardware workaround and should normally be 0.

> 
> 
> vs.
> 
> 00:11.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev
> 06) 
> (prog-if 8a [Master SecP PriP])
>          Subsystem: Unknown device 1849:0571
>          Flags: bus master, medium devsel, latency 32, IRQ 255
>          I/O ports at fc00 [size=16]
>          Capabilities: <available only to root>
> 
> This probably has to do with this boot message:
> PCI: No IRQ known for interrupt pin A of device 00:11.1

> I have found absolutely nothing that explains if this is an error or 
> just some sort of debug message one can ignore.

Yes, ignore it.

This is where that message about 255 came from.
When ACPI failed to find a PCI-routing-table entry
for this device, it looked in PCI config space
and found the 255 you see above.  The only recent
change is that it dosn't try to use an obviously
bogus value.  But in either case, with this device
it is moot as the hardware and the driver are hard-coded.

-Len


