Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWIYKxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWIYKxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWIYKxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:53:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54679 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751119AbWIYKxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:53:37 -0400
Subject: Re: [PATCH] libata: rework legacy handling to remove much of the
	cruft
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>, rmk@arm.linux.org.uk
In-Reply-To: <1159179290.320.11.camel@pmac.infradead.org>
References: <200609241805.k8OI5Xkn007593@hera.kernel.org>
	 <1159179290.320.11.camel@pmac.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 12:18:02 +0100
Message-Id: <1159183082.11049.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 11:14 +0100, ysgrifennodd David Woodhouse:
> We should register the non-discoverable devices as platform devices (or
> of_devices, or something), and not just hardcode stuff like this in
> asm/foo.h headers

That would be too late. Those "constants"[1] are part of the actual PCI
bus setup. I have some patches to push most of them into
drivers/pci/quirks.c. We cannot use platform devices for this in most
cases because we already have a device for it - the PCI one.

In the non PCI case we can use platform devices and we do, but the
platform device itself has to know what I/O ports are being used so you
end up back with the "constants".

The old IDE layer works this way too except that it doesn't use platform
devices at all.

Alan
[1] as in "constants aren't, variables won't"



