Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268034AbUIJWwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268034AbUIJWwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIJWtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:49:47 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:6582 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S268014AbUIJWqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:46:17 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
Subject: Re: FYI: my current bigdiff
Date: Fri, 10 Sep 2004 16:46:01 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20040909134421.GA12204@elf.ucw.cz> <20040910041320.DF700E7504@voldemort.scrye.com>
In-Reply-To: <20040910041320.DF700E7504@voldemort.scrye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409101646.01558.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 10:13 pm, Kevin Fenzi wrote:
> First suspend worked.
> First resume came back, but all kinds of problems with my network,
> with my usb, and with sound.
> ...
> After booting with the pci=routeirq as suggested wireless and usb
> played nice on suspend resume again.

Yes, I've had a couple other reports of this, but haven't made any
progress on tracking it down yet.  (The other reports were from
vanilla -mm kernels, so I don't think it's related to Pavel's patch.)

I'm completely ignorant about how swsusp works; I guess this is my
chance to learn.  "pci=routeirq" just causes us to do all the PCI
ACPI IRQ routing at boot-time, before the drivers start up.  This
happens in pci_acpi_init(), which is a subsys_initcall that is run
at initial boot-time, but (I assume) not during a resume.

	- Can you confirm that your USB and prism drivers were loaded
	  and working fine before the suspend?

	- Could you post the whole dmesg log, including the part from
	  boot to suspend, and also the part after resume?  I'd like
	  to see these both with and without "pci=routeirq" to see if
	  there's some meaningful difference.

	- Can you capture the contents of /proc/interrupts before the
	  suspend?

Thanks for the problem report.
