Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUEJLVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUEJLVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUEJLVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:21:50 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:26270 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264639AbUEJLV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:21:28 -0400
Date: Mon, 10 May 2004 20:20:36 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [Lhns-devel] Re: [ANNOUNCE] [PATCH] Node Hotplug Support
In-reply-to: <20040510.111240.84363848.t-kochi@bq.jp.nec.com>
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Message-id: <20040510202036.64794519.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
 <1083944945.23559.1.camel@nighthawk>
 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
 <20040510.111240.84363848.t-kochi@bq.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 11:12:40 +0900 (JST)
Takayoshi Kochi <t-kochi@bq.jp.nec.com> wrote:

> From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
> Subject: [Lhns-devel] Re: [ANNOUNCE] [PATCH] Node Hotplug Support
> Date: Mon, 10 May 2004 10:47:25 +0900
> 
> > > How does this interoperate with the current NUMA topology already in
> > > sysfs today?  I don't see any references at all to the current code.  
> > 
> > There is no NUMA support in the current code yet.  I'll post a
> > rough patch to show my idea soon.  I'm thinking to regard a
> > container device that has PXM as a NUMA node so far.
> 
> I've not looking closely into the code, but why do you use "PNP0A05"
> for container device?
> "PNP0A05" is defined as "Generic ISA devie" in the ACPI spec.
> 
> I think "module device (ACPI0004)"  sounds more suitable for the
> purpose, though I don't know whether your hardware will support it
> or not.

Yes.  ACPI0004 could be used as well.  Actually, PNP0A05 is
redefined as "Generic Container Device" in ACPI spec2.0c.
According to that, both PNP0A05 and ACPI0004 behave
almost the same way.  PNP0A05 also sounds nice for me:)
 
> Also, assuming devices that have _PXM are nodes sounds a bit too
> aggressive for me.  For example, something like below is possible.
> 
> Device(\_SB) {
>   Processor(CPU0...) {
>      Name(_PXM, 0)
>   }
>   Processor(CPU1...) {
>      Name(_PXM, 1)
>   }
> 
>   Device(PCI0) {
>      Name(_PXM, 0)
>   }
>   Device(PCI1) {
>      Name(_PXM,1)
>   }
> }
> 
> (I don't know if such an implementation exists, but from the spec,
> it is possible)
> In this case, OS has to group devices by same number.
> Please don't assume specific ACPI AML implementatin as a generic
> rule.

If ACPI ASL is written that way, LHNS cannot do anything since
there is no container device (this is not ACPI term here) in the
system.  LHNS's target is a container *device* (again, not ACPI
term:) and hotplugs it physically (of course, the device needs to
be hotpluggable).  So, LHNS can handle a NUMA node if all
CPUs and memory of the node are on a container device. I know
that it's a big restriction :(

Thanks,
kei
