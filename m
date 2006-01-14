Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWANT2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWANT2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWANT2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:28:16 -0500
Received: from host-226.cpws.net ([65.240.163.226]:40323 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S1750836AbWANT2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:28:15 -0500
Message-ID: <43C950B4.6020801@lorettotel.net>
Date: Sat, 14 Jan 2006 13:27:48 -0600
From: Walt H <walt_h@lorettotel.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, dmitry.torokhov@qmail.com,
       vojtech@suse.cz
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
References: <Pine.LNX.4.44L0.0601141206280.8167-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0601141206280.8167-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:

>  On Sat, 14 Jan 2006, Walt H wrote:
>
> > I've an AMD based SMP setup w/ Chaintech 7KDD motherboard. It's an
> > older board, and there are no more recent BIOS updates available
> > for me than what I'm running. I've tried enabling/disabling legacy
> > USB keyboard/mouse emulation in the BIOS with no change. I'm using
> > a USB mouse connected via the OHCI controller in addition to the
> > ps/2 keyboard. If I comment out the handoff code in pci-quirks.c
> > the keyboard works, even after loading the USB modules. I'm running
> > a ck based 2.6.15 kernel BTW.
> >
> > During bootup with handoff code enabled, I do see a message print
> > when PS/2 gets init'd, and I think it is "i8042.c: Can't read CTR
> > while initializing i8042", but it scrolls by too fast so I'm not
> > positive.
> >
> > lspci and config attached. Anything else you need? Please CC
> > replies to me, as I'm not subscribed. I tried to CC relevant
> > people involved, sorry if I missed anyone. Thanks,
>
>
>  What happens if you comment out only the OHCI part of the hand-off
>  code, or only the EHCI part?
>
>  Check dmesg to see exactly what that i8042 message says. Are there
>  any lines reporting handoff problems in ohci-hcd or ehci-hcd?
>
>  Alan Stern
>
>


OK.  No lines reporting handoff problems in any of the boots.  The only 
boot in which I still have a keyboard is when I comment out the OHCI 
handoff.  I saved dmesg's of all boots, and ran diffs against them.  The 
uncommented handoffs and the EHCI commented handoff are essentially the 
same (where the OHCI handoff code still executes in both).  The relevant 
(diff'd) sections are:

@@ -153,3 +153,2 @@
-i8042.c: Can't read CTR while initializing i8042.
-pnp: Device 00:09 does not supported disabling.
-pnp: Device 00:08 does not supported disabling.
+serio: i8042 AUX port at 0x60,0x64 irq 12
+serio: i8042 KBD port at 0x60,0x64 irq 1
@@ -219,0 +219 @@
+input: AT Translated Set 2 keyboard as /class/input/input0
@@ -234,0 +235 @@
+input: PS/2 Generic Mouse as /class/input/input1
@@ -268 +269 @@
-input: Logitech USB Mouse as /class/input/input0
+input: Logitech USB Mouse as /class/input/input2

Hope that helps,

-Walt


