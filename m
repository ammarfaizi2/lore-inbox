Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVBNSoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVBNSoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVBNSoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:44:19 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:11784 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261520AbVBNSmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:42:15 -0500
Date: Mon, 14 Feb 2005 19:42:35 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-Id: <20050214194235.073f5850.khali@linux-fr.org>
In-Reply-To: <20050214123822.GF3233@crusoe.alcove-fr>
References: <20050214100738.GC3233@crusoe.alcove-fr>
	<CKthPPXN.1108383209.9808960.khali@localhost>
	<20050214123822.GF3233@crusoe.alcove-fr>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> > > * pbr is the power-on brightness. It's the brightness that the
> > >   laptop uses at power-on time.
> > 
> > Will test this evening.

I can confirm, that works for me too.

> > > * cdp is the CD-ROM power. Writing 0 to cdp turns off the cdrom in
> > >   order to save a bit of power consumption.
> > 
> > I don't seem to have cdp on my system. Is this something I need to
> > manually activate in the driver, or does it simply mean that my
> > laptop doesn't support that feature?
> 
> sony_acpi doesn't create this node. But if it is supported on your
> system you should see 'method: name: GCDP' and 'method: name: SCDP'
> in the logs because sony_acpi does enumerate all the methods it
> finds for the snc device.

I don't have this one. The logs say:

sony_acpi: method: name: GPID, args 0
sony_acpi: method: name: GBRT, args 0
sony_acpi: method: name: SBRT, args 1
sony_acpi: method: name: GPBR, args 0
sony_acpi: method: name: SPBR, args 1
sony_acpi: method: name: GCTR, args 0
sony_acpi: method: name: SCTR, args 1
sony_acpi: method: name: GPCR, args 0
sony_acpi: method: name: SPCR, args 1
sony_acpi: method: name: GCMI, args 1
sony_acpi: method: name: SCMI, args 1
sony_acpi: method: name: PWAK, args 0
sony_acpi: method: name: PWRN, args 0
sony_acpi: method: name: CSXB, args 1

So, let alone the ones the driver already exposes when loaded with
debug=1, I have:
GPID, GPCR/SPCR, PWAK and PWRN.

A few random comments:
* GPID could be "get product id"?
* I'll give a try to GPCR/SPCR, seems to be another get/set pair.
* Isn't is strange that GCMI takes one argument?
* CSXB is obviously not part of a standard get/set pair, which might
  (somewhat) explain why it crashed my system the other day.

I'll report if I can find more.

Thanks,
-- 
Jean Delvare
