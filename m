Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVGLWCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVGLWCP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVGLWCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:02:11 -0400
Received: from totor.bouissou.net ([82.67.27.165]:17056 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262382AbVGLWBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:01:23 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Wed, 13 Jul 2005 00:01:06 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507121730590.4764-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507121730590.4764-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507130001.06895@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 12 Juillet 2005 23:37, Alan Stern a écrit :
>
> Then it's definite.  The EHCI controller is issuing interrupt requests on
> IRQ 21, but its driver is registered on a different IRQ.  Hence the
> interrupts aren't getting handled correctly.
>
> So probably the usb_handoff parameter won't be needed.  And if you leave
> USB 2.0 disabled in the BIOS then there's no need to hide ehci_hcd.ko, as
> it won't get loaded anyway.  You should be able to remove the test patch
> and resume normal operations.

I've just booted an IO-APIC capable kernel without the test patch (but with 
Nathalie's 2 patches), without "usb_handoff", with USB 2.0 DISABLED and USB 
mouse support ENABLED in BIOS.

It seems it works good, and ehci support is not loaded.

[root@totor etc]# cat /proc/interrupts
           CPU0
  0:     425367    IO-APIC-edge  timer
  1:       1698    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:       1169    IO-APIC-edge  serial
  7:          2    IO-APIC-edge  parport0
 14:       3337    IO-APIC-edge  ide4
 15:       3346    IO-APIC-edge  ide5
 16:      15142   IO-APIC-level  nvidia
 18:       1707   IO-APIC-level  eth0, eth1
 19:      25211   IO-APIC-level  ide0, ide1, ide2, ide3
 21:       3210   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 22:       2761   IO-APIC-level  VIA8233
NMI:          0
LOC:     425302
ERR:          0
MIS:          0

Plugging or unplugging USB devices doesn't cause no IRQ insults anymore ;-)


> On Tue, 12 Jul 2005, Protasevich, Natalie wrote:
> > I suspect that some device is actually on the IRQ 21, and that's how its
> > IO-APIC line is set up. Later on, its driver tries to assign different
> > IRQ, due to some discrepancy, and the handler gets registered on say IRQ
> > 11, and to a wrong pin, so the actual interrupts go unattended. If this
> > what's happening, the trace will hopefully tell the story. I suggest to
> > boot with "apic=debug" and also perhaps with "pci=routeirq" and collect
> > the trace. You can attach the part up to the point when it reports usb
> > devices set up.
>
> At this point I can leave it up to the two of you.

Well, many thanks again for you precious help Alan !

> Now that we know which is the offending device, it should be easy to find
> out why the IRQ assignments go wrong.  That certainly needs to be fixed,
> even though Michel's problem appears to be solved.

Well, it's solved by currently giving me the choice between no USB 2.0 and 
IO-APIC, or USB 2.0 and no IO-APIC. That makes a temporary solution, but I'd 
love to have both (and recall the happy times of 2.4x that was happy with 
both ;-)

Natalie, could you please tell me which kernel (I have started to have a 
number of them ;-) you'd like me <<  to boot with "apic=debug" and also 
perhaps with "pci=routeirq" and collect the trace >>, and with which BIOS 
setup ? (i.e. USB 2.0 enabled or disabled ?).

When you speak about "collecting the trace", I assume you mean the dmesg 
or /var/log/messages I'll get after booting this way ?

Thanks again to both of you Alan and Natalie. Everytime I run into serious 
trouble I remember why I love Free Software and the Free Software 
Community ;-)

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
