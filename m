Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWJ1Xem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWJ1Xem (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 19:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWJ1Xem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 19:34:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49820 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964915AbWJ1Xel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 19:34:41 -0400
Subject: Re: [patch] drivers: wait for threaded probes between initcall
	levels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <4543C22A.2060203@s5r6.in-berlin.de>
References: <20061026191131.003f141d@localhost.localdomain>
	 <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz>
	 <20061027113908.4a82c28a.akpm@osdl.org>
	 <20061027114144.f8a5addc.akpm@osdl.org>
	 <20061027114237.d577c153.akpm@osdl.org>
	 <1161989970.16839.45.camel@localhost.localdomain>
	 <20061027160626.8ac4a910.akpm@osdl.org>
	 <20061028050905.GB5560@colo.lackof.org>
	 <20061027221925.1041cc5e.akpm@osdl.org>
	 <20061028060833.GC5560@colo.lackof.org>
	 <4543C22A.2060203@s5r6.in-berlin.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 29 Oct 2006 00:34:57 +0100
Message-Id: <1162078498.29146.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-28 am 22:48 +0200, ysgrifennodd Stefan Richter:
> I hear network interfaces can be selected by their MACs, which are
> globally unique and persistent. Most SCSI hardware has globally unique
> and persistent unit properties too, and udev indeed uses them these days.

You hear incorrectly. The MAC address is only required to be *machine
unique*, please see the 802.1/2 specification documents for more detail.
Distinguishing by card MAC is a hack that works on some systems only.

SCSI is also unreliable for serial numbers because of USB, brain-dead
raid controllers and other devices that fake the same ident for many
devices.

There is another ugly too - many driver/library layers "know" that
during boot the code is not re-entered so has no locking. Before you can
go multi-probe you also have to fix all the locking in the drivers that
have boot time specific functionality (eg IDE).

Alan

