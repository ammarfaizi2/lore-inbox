Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFDTMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFDTMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVFDTMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 15:12:17 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:3557 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261420AbVFDTMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 15:12:13 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.12-rc5 : repeatable modprobe usb-storage hang
Date: Sat, 4 Jun 2005 12:12:04 -0700
User-Agent: KMail/1.7.1
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
References: <200506031341.17749.kernel-stuff@comcast.net>
In-Reply-To: <200506031341.17749.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200506041212.04476.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 June 2005 10:41 am, Parag Warudkar wrote:
> 
> Also interesting is this line -
> [   40.586298] ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Controller is 
> probably using the wrong IRQ.

So did you investigate these IRQ setup problem, or just ignore
that pointed diagnostic?

Controllers are not expected to behave if their drivers aren't given
the correct IRQ.  In particular, when software needs to wait until
the hardware reports it's finished with something, and the hardware
never reports that (== never issues the IRQ) then things may hang.


Also this earlier line already identified a potential root cause:

> [   38.927690] ACPI: PCI Interrupt 0000:00:02.0[P]: no GSI - using IRQ 11

This could be a problem in either the tables BIOS provided, or in the
way ACPI is interpreting them, or something else ... I'm not an ACPI guru.

You should be experimenting with ways to get the right IRQ assigned to this
controller; such problems are common enough that there are probably half a
dozen boot options affecting what happens.  Or maybe look at BIOS options that
affect that controller; you might need to update your board's BIOS firmware.

- Dave


