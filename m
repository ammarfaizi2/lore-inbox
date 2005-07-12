Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVGLUo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVGLUo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGLUmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:42:49 -0400
Received: from totor.bouissou.net ([82.67.27.165]:54182 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261945AbVGLUkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:40:55 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 22:40:53 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507121440020.6281-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507121440020.6281-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507122240.53390@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 12 Juillet 2005 20:57, Alan Stern a écrit :
> On the other hand, _something_ was generating an interrupt request that
> got mapped to IRQ 21 by the hardware.  And these requests do seem to be
> associated with USB activity.  Maybe the EHCI controller is responsible?
> One of your postings showed both uhci_hcd:usb2 and ehci_hcd:usb4 mapped to
> IRQ 11.  That could indicate a shared signal line, which is currently
> being mapped incorrectly.
>
> You can test this a couple of ways.  The easiest is to rmmod ehci_hcd, or
> prevent it from being loaded in the first place, by renaming
> /lib/modules/.../drivers/usb/host/ehci_hcd.ko so that modprobe can't find
> it.  Also your BIOS may offer the option of disabling USB 2.0 support
> entirely.  Try doing this under the kernel that has the test patch
> installed.

I've tested as you suggest :

- Disabled USB 2.0 in BIOS

- Renamed ehci_hcd.ko so that modprobe can't find it

- Booted the test-patched kernel with same options as previously, MOUSE 
UNPLUGGED.

- After boot "cat /proc/interrupts" shows "0" count for IRQ 21

- Nothing special isn't logged anymore in dmesg or /var/log/messages.

- Plugging / unplugging the mouse or other devices doesn't cause anything 
visible to happen. Nothing gets logged, IRQ 21 counter stays at 0. I could as 
well not have done it ;-)

> Without ehci_hcd loaded, the EHCI controller should not generate any
> interrupt requests.  If your problem then goes away, and plugging or
> unplugging the mouse doesn't cause anything unusual to happen, that will
> be a pretty clear indication.

Well, so that's a pretty clear indication, but surely clearer to you than to 
me ;-)

So, what's up, doc ? ;-))

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
