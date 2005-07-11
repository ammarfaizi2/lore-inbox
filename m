Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVGKTfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVGKTfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVGKTfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:35:06 -0400
Received: from totor.bouissou.net ([82.67.27.165]:55019 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261672AbVGKTdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:33:15 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 21:33:06 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
References: <Pine.LNX.4.44L0.0507111432530.5164-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507111432530.5164-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507112133.07471@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 20:36, Alan Stern a écrit :
> It's also possible that the UHCI controllers are generating the unwanted
> interrupt requests.  You should make sure that Legacy USB Support is
> turned off in your BIOS settings.

My motherboard both holds USB 1.1 and USB 2.0 controllers. I don't have a 
"Legacy USB Support" option in my BIOS, all my USB options are the following:

Enable USB 1.1 controller: YES	(Surely relates to my true USB 1.1 controller)

Enable USB 2.0 controller: YES	(Same for the high speed controller ?)

Enable USB keyboard: NO

Enable USB mouse support: YES	(Well, I have one ;-)

I didn't change anything regarding these so far.

> You can also try adding the "usb-handoff" kernel parameter to your boot
> command line. 

Hey !! This one looks like the MIRACLE-OPTION !!

I just booted using my 2.6.12 kernel patched with Nathalie's patches (don't 
know if they help in there...) and the problem seems to be gone !

Nothing complains anymore about the interrupt. I have:

[root@totor etc]# cat /proc/interrupts
           CPU0
  0:     934501    IO-APIC-edge  timer
  1:       4611    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:       2779    IO-APIC-edge  serial
  7:          3    IO-APIC-edge  parport0
 14:       7909    IO-APIC-edge  ide4
 15:       7918    IO-APIC-edge  ide5
 16:      38447   IO-APIC-level  nvidia
 18:       2982   IO-APIC-level  eth0, eth1
 19:      37041   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
 21:      52036   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 22:       2850   IO-APIC-level  VIA8233
NMI:          0
LOC:     934453
ERR:          0
MIS:          0


...now let's see with time if this is stable...

A thousand thanks for your suggestion Alan !

(Kernel 2.4 was working plain good without such a boot option, I didn't know 
it existed...)

(Please copy me on answers, as I'm not subscribed to the linux-kernel mailing 
list.)

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
