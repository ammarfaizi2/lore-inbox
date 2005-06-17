Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVFQMkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVFQMkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVFQMkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 08:40:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28804 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261515AbVFQMke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 08:40:34 -0400
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  
	nobody cared!"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Fieroch <fieroch@web.de>
Cc: bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <42B2AACC.7070908@web.de>
References: <d6gf8j$jnb$1@sea.gmane.org>
	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>
	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>
	 <20050615143039.24132251.akpm@osdl.org>
	 <1118960606.24646.58.camel@localhost.localdomain> <42B2AACC.7070908@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119011887.24646.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Jun 2005 13:38:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-17 at 11:49, Alexander Fieroch wrote:
> I've tested linux 2.6.11-ac7 with IT8212 compiled into the kernel. I can
> see my devices and mount them, but the kernel hangs for a while when I
> access hdb and the errors this thread is about appear too.
> The complete syslog is attached.

That trace is really useful. Its showing the problem is not apparently
IDE but IRQ routing.

> I don't know who the IDE maintainers are, but they are reading this list
> too, aren't they?

Bartlomiej is IDE maintainer, Jens is cdrom wizard and you cc'd both the
right people.

> Jun 17 12:07:49 orclex kernel: ICH6: 100% native mode on irq 18
> Jun 17 12:07:49 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:DMA
> Jun 17 12:07:49 orclex kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio

This seems an unusual setup - the ICH6 is in native mode not legacy as
I'd have expected.

> Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
> Jun 17 12:07:49 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.

Something failed to clear IRQ 18, that typically means there are IRQ
routing problems rather than IDE ones and would explain your traces.

Try booting with acpi=off and see what trace you get then.


