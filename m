Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264490AbUEJCNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbUEJCNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbUEJCNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:13:04 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:36028 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264490AbUEJCM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:12:56 -0400
Date: Mon, 10 May 2004 11:12:40 +0900 (JST)
Message-Id: <20040510.111240.84363848.t-kochi@bq.jp.nec.com>
To: tokunaga.keiich@jp.fujitsu.com
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Subject: Re: [Lhns-devel] Re: [ANNOUNCE] [PATCH] Node Hotplug Support
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
In-Reply-To: <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
	<1083944945.23559.1.camel@nighthawk>
	<20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [Lhns-devel] Re: [ANNOUNCE] [PATCH] Node Hotplug Support
Date: Mon, 10 May 2004 10:47:25 +0900

> > How does this interoperate with the current NUMA topology already in
> > sysfs today?  I don't see any references at all to the current code.  
> 
> There is no NUMA support in the current code yet.  I'll post a
> rough patch to show my idea soon.  I'm thinking to regard a
> container device that has PXM as a NUMA node so far.

I've not looking closely into the code, but why do you use "PNP0A05"
for container device?
"PNP0A05" is defined as "Generic ISA devie" in the ACPI spec.

I think "module device (ACPI0004)"  sounds more suitable for the
purpose, though I don't know whether your hardware will support it
or not.

Also, assuming devices that have _PXM are nodes sounds a bit too
aggressive for me.  For example, something like below is possible.

Device(\_SB) {
  Processor(CPU0...) {
     Name(_PXM, 0)
  }
  Processor(CPU1...) {
     Name(_PXM, 1)
  }

  Device(PCI0) {
     Name(_PXM, 0)
  }
  Device(PCI1) {
     Name(_PXM,1)
  }
}

(I don't know if such an implementation exists, but from the spec,
it is possible)
In this case, OS has to group devices by same number.

Please don't assume specific ACPI AML implementatin as a generic
rule.

---
Takayoshi Kochi
