Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUALXEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUALXEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:04:11 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:11407 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261775AbUALXEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:04:07 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave> 
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jan 2004 18:04:00 -0500
Message-Id: <1073948641.4178.76.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, the bars in the previous mail are rubbish.  I put debugging into the
start up, so these are the correct bars:



PCI: Dev 0000:00:0f.0 Resource(0) fec01000-fec013ff (f=10001208, d=0,
p=0)
PCI: Cannot allocate resource region 0 of device 0000:00:0f.0
PCI: Dev 0000:00:0f.0 Resource(1) fffffc00-ffffffff (f=10001208, d=0,
p=0)
PCI: Cannot allocate resource region 1 of device 0000:00:0f.0
PCI: Dev 0000:00:0f.0 Resource(2) fffffc00-ffffffff (f=10001208, d=0,
p=0)
PCI: Cannot allocate resource region 2 of device 0000:00:0f.0
PCI: Dev 0000:00:0f.0 Resource(3) fffffc00-ffffffff (f=10001208, d=0,
p=0)
PCI: Cannot allocate resource region 3 of device 0000:00:0f.0
PCI: Dev 0000:00:0f.0 Resource(4) fffffc00-ffffffff (f=10001208, d=0,
p=0)
PCI: Cannot allocate resource region 4 of device 0000:00:0f.0
PCI: Dev 0000:00:0f.0 Resource(5) fffffc00-ffffffff (f=10001208, d=0,
p=0)
PCI: Cannot allocate resource region 5 of device 0000:00:0f.0

So BAR0 is actually the location of the second I/O APIC's mapped address
range (which we've already covered with a fixmap from the MP TABLE). 
I've no idea what the other four BARs all with addresses at 0xfffffc00
are doing.

The only way to prevent the current code (in arch/i386/pci/i386.c) from
reassigning this range seems to be to set the resource start to zero.

James




