Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWGYXoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWGYXoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWGYXoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:44:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8123 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030258AbWGYXoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:44:15 -0400
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, greg@kroah.com, dsd@gentoo.org,
       jeff@garzik.org, harmon@ksu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20060724214046.1c1b646e.akpm@osdl.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
	 <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>
	 <20060717003418.GA27166@tuatara.stupidest.org>
	 <20060724214046.1c1b646e.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 01:42:55 +0100
Message-Id: <1153874577.7559.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few comments

"The legacy IDE is using IRQ 14 or 15 not PCI"

This is half correct - V-Link is not involved in this case, however the
legacy IRQs are configurable and steerable via func 0 reg 0x4C for some
chips. If this has been set by a weirdass bios (bits 3-0 not 0x0100 for
the 8233C  varies for others) then we've never supported it.


I have full IRQ routing info for some of the VIA chips and it varies by
chip how this all works.

The 8233/8233C routes via register 0x4C/0x4D of function 0 for internal
devices and via 0x55->0x57 (polarities on 0x54) for PCI interrupts. The
devices use the IRQ number not line. Also to add fun the 8233C has a
3com nic part that does this...

There are then a seperate set of register mappings for SCI and for ISA
IRQ mapping.

There is an errata with the internal devices of the 8235 and earlier
which can be used to detect them fairly well. Only the low four bits of
0ffset 0x3C are writable not the full IRQ value.


Some later chips use bits to indicate PIC v APIC routing.

