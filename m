Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVJ3W1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVJ3W1T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJ3W1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:27:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932365AbVJ3W1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:27:18 -0500
Date: Sun, 30 Oct 2005 14:27:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <43652F1C.7010500@vc.cvut.cz>
Message-ID: <Pine.LNX.4.64.0510301348540.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
 <1cb7.435fd492.4a69a@altium.nl> <Pine.LNX.4.61.0510281056230.24372@yvahk01.tjqt.qr>
 <43652F1C.7010500@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Oct 2005, Petr Vandrovec wrote:
>
> Jan Engelhardt wrote:
> > > Linus Torvalds <torvalds@osdl.org> wrote:
> > > | can you please test out this patch and report what it says in dmesg?
> > 
> > 
> > Here is an exotic one, from VMware (uses PIIX too). Says
> > 
> > 
> > PCI quirk: region 1000-103f claimed by PIIX4 ACPI
> > PCI quirk: region 1040-105f claimed by PIIX4 SMB
> > ...later...
> > PCI: Cannot allocate resource region 4 of device 0000:00:07.1
> 
> It is caused by Linux quirk which believes that SMB region needs 32 bytes,
> while i440BX datasheet says that 16 bytes are needed, and as we've not found
> any errata which would say that SMB region is 32 bytes on some revisions,
> system BIOS (and emulation) just allocates 16 bytes here.  Thus system BIOS
> puts SMB at 0x1040-0x104f (you can see it below as motherboard reported
> resource), and IDE busmastering registers are put at 0x1050-0x105f.

Hey, good point. I wonder where I got that 32 bytes from.

Fixed to 16.

		Linus
