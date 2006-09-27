Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWI0DxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWI0DxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 23:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWI0DxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 23:53:03 -0400
Received: from xenotime.net ([66.160.160.81]:15242 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932373AbWI0DxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 23:53:01 -0400
Date: Tue, 26 Sep 2006 20:54:15 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jesper Juhl <jesper.juhl@gmail.com>, gregkh <greg@kroah.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time:
 acpi_pm clocksource has been installed.
Message-Id: <20060926205415.98b8d95d.rdunlap@xenotime.net>
In-Reply-To: <200609270236.58148.jesper.juhl@gmail.com>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
	<20060926173347.04fd66dd.rdunlap@xenotime.net>
	<200609270236.58148.jesper.juhl@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 02:36:58 +0200 Jesper Juhl wrote:

> On Wednesday 27 September 2006 02:33, Randy Dunlap wrote:
> > On Wed, 27 Sep 2006 02:22:18 +0200 Jesper Juhl wrote:
> > 
> > > I get this in dmesg with 2.6.18-git6 :
> > >       a3:<6>Time: acpi_pm clocksource has been installed.
> > > 
> > > Looks like some printk() somewhere is not adding \n correctly after
> > > outputting a message priority or a message priority too much is
> > > used... I've not investigated where this happens, but just wanted to
> > > report it.
> > 
> > Hi,
> > How about posting (pasting) some of the message log before that?
> > 
> Sure, below is the entire dmesg output from this boot of the box 
> (including the line above) :

I suppose that you have CONFIG_PCI_MULTITHREAD_PROBE=y ?
What happens if you change to to =n ?

> eth0: VIA Rhine II at 0xff5fec00, 00:50:ba:f2:<6>serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> EDAC MC: Ver: 2.0.1 Sep 27 2006
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Starting balanced_irq
> Using IPI Shortcut mode
> a3:<6>Time: acpi_pm clocksource has been installed.
> 1d, IRQ 18.
> eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.

I'm pretty sure that this is caused by parallel device probing.
The serio and clocksource messages are interspersed with the
eth0 (via rhine) info.  Garbled.

Greg, is this expected?

---
~Randy
