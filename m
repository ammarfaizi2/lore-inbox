Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUIBTqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUIBTqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUIBTqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:46:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:3473 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268438AbUIBTp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:45:57 -0400
Subject: RE: [PATCH] Early USB handoff
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B30162E74A@scl-exch2k.phoenix.com>
References: <5F106036E3D97448B673ED7AA8B2B6B30162E74A@scl-exch2k.phoenix.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094150607.5645.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 19:43:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 20:03, Aleksey Gorelov wrote:
>   Basically, in a case of legacy free BIOS, HC is not in 
> SMM mode, and USB IRQ is routed to PCI IRQ line and generates
> interrupts. When this IRQ is enabled in PIC (by driver that 
> starts before HC driver), system is flooded with interrupts.

The BIOS should not be leaving the device generating interrupts surely ?
If that IRQ line ends up shared we are in trouble at boot time. 

>   One solution is to reset HC, but it takes some time (at 
> least 50ms). I agree that it might duplicate SOME code in HC 
> driver, but HC init executes too late. Well, if handoff has 
> been done early, it might not be necessary to do the same in 
> HC driver.

We don't always want to hand off. Some setups only work in USB legacy
mode because of other bugs. Thats why the SMM fixup I did for E750x is
triggered in specific cases. We can do such things with DMI table
blacklists easily enough.

My E750x fix already duplicates some of the hand off code so we are
going to need it anyway and if there are more reasons for needing it
then so be it. I happened to only need to fix UHCI thats all.

Alan

