Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUHYQ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUHYQ2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268121AbUHYQ2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:28:17 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:55721 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S268117AbUHYQ2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:28:16 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: acyr@alumni.uwaterloo.ca
Subject: Re: ACPI + Floppy detection problem in 2.6.8.1-mm4
Date: Wed, 25 Aug 2004 10:28:08 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Petr Vandrovec <vandrove@vc.cvut.cz>
References: <20040825002220.4867cd17.akpm@osdl.org>
In-Reply-To: <20040825002220.4867cd17.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408251028.08180.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> inserting floppy driver for 2.6.8.1-mm4
> acpi_floppy_resource: 6 ioports at 0x3f0
> acpi_floppy_resource: 1 ioports at 0x3f7
> floppy: controller ACPI FDC0 at I/O 0x3f0-0x3f5, 0x3f7-0x3f7 irq 6 dma channel 2
> Floppy drive(s): fd0 is 1.44M
> floppy0: no floppy controllers found

Yup, the current -mm4 code assumes that if you have 6 ports in
the first region, they are 0x3f2-0x3f7.  But your BIOS reports
6 ports at 0x3f0-0x3f5.

So I guess we'll have to do something like Petr's approach of
ignoring the low three bits.  Thanks for the report.  I'll send
you a patch to try shortly.

Bjorn
