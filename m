Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWFTNaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFTNaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWFTNaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:30:15 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:23449 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750822AbWFTNaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:30:12 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.2
Subject: Re: [linux-usb-devel] [Fwd: Re: [Linux-usb-users] Fwd: Re:
	2.6.17-rc6-mm2 - USB issues]
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Johny <kernel@agotnes.com>, Andrew Morton <akpm@osdl.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net, linux-acpi@vger.kernel.org,
       Alan Stern <stern@rowland.harvard.edu>, Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20060620120937.GR3206@master.mivlgu.local>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	 <20060620120937.GR3206@master.mivlgu.local>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 14:30:06 +0100
Message-Id: <1150810206.7194.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

someone has it has a case similar and said that won't work without
acpi=noirq

http://bugzilla.kernel.org/show_bug.cgi?id=6654



On Tue, 2006-06-20 at 16:09 +0400, Sergey Vlasov wrote:
> On Tue, Jun 20, 2006 at 09:21:35PM +1000, Johny wrote:
> [...]
> > Stock kernels break for me starting with 2.6.17-rc4 (I tested all rcs 
> > and also .17 itself), rc3 works a treat for using USB. I suspect the 
> > following line missing in dmesg for rc4 is the reason;
> > 
> > -PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11
> 
> Well, not exactly this line (0000:00:11.1 is the IDE controller, which is
> in legacy mode and therefore does not use its PCI interrupt), but the next
> similar line is for the USB 2.0 (EHCI) controller:
> 
> -PCI: Via IRQ fixup for 0000:00:10.3, from 5 to 10
> 
> > See the following dmesg files for details;
> > 
> > http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc3-working
> > http://www.agotnes.com/kernelStuff/dmesg-2.6.17-rc4-not-working
> > 
> > And the diff, for convenience;
> > 
> > http://www.agotnes.com/kernelStuff/diff-rc3_rc4
> 
> Try as root:
> 
> 	setpci -s 00:10.3 INTERRUPT_LINE=0a
> 
> (this matches "ehci_hcd 0000:00:10.3: irq 10, ..." in dmesg).
> 
> If after doing this USB works again (you will need to replug USB devices),
> the missing VIA IRQ quirk is definitely the problem.
> 
> > I have a Via chipset motherboard (for my sins), further details 
> > available on request, again, for convenience, the lspci;
> > 
> > http://www.agotnes.com/kernelStuff/lspci
> 
> You seem to have also the builtin audio and Ethernet on this board - these
> devices may have the same problem, if you tried to use them.
> 
> > A couple of possible suspect patches introduced in the changelog for rc4 
> > were (with the first one looking particularly interesting, the others 
> > less interesting as I go down the list);
> > 
> > [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
> > [PATCH] x86_64: avoid IRQ0 ioapic pin collision
> > [PATCH] PCI: fix via irq SATA patch
> > [ALSA] via82xx - Use DXS_SRC as default for VIA8235/8237/8251 chips
> > [ALSA] via82xx: tweak VT8251 workaround
> > [ALSA] via82xx: add support for VIA VT8251 (AC'97)
> > 
> > I'm no kernel hacker, so I'm not sure how I'd isolate this one patch and 
> > reverse / modify it. Please let me know how I can progress testing this 
> > as I'm currently prevented from using USB with the latest set of kernels 
> > on my test server...
> > 
> > I've got all kernels in the 2.6.17-rc1 through to .17 itself there, plus 
> > a variety of mm ones too, so patches against any of those I can very 
> > easily test.
> > 
> > Please keep me cc'd as I'm not on all these lists, thanks :)
> > 
> > :)Johny
> > 
> > Johny ?gotnes wrote:
> > > didn't go through due to missing vger. ...
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > Subject:
> > > Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues
> > > From:
> > > Johny <kernel@agotnes.com>
> > > Date:
> > > Sun, 18 Jun 2006 21:37:00 +1000
> > > To:
> > > Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > To:
> > > Alan Stern <stern@rowland.harvard.edu>
> > > CC:
> > > Johny <kernel@agotnes.com>, USB development list 
> > > <linux-usb-devel@lists.sourceforge.net>, kernel list 
> > > <linux-kernel@vger.kernel.org>, linux-acpi@kernel.org, akpm@osdl.org
> > > 
> > > 
> > > All,
> > > 
> > > I've now tested the following;
> > > 
> > > 2.6.17-rc6-mm2 with the following patch applied;
> > > ---
> > > git-acpi.patch from 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/broken-out/ 
> > > 
> > > ---
> > > 
> > > With no difference to the end-result.
> > > 
> > > Next I stripped out 802.11 generic support and acx111 drivers from the 
> > > kernel (including the acpi patches) to check if it clashes, but the same 
> > > errors occur....
> > > 
> > > Thirdly, I booted with acpi=off on the command line with two kernels, 
> > > the stock 2.6.17-rc6-mm2 (no acpi patch and including acx111) and the 
> > > one including the acpi patch and no acx111, the results were;
> > > 
> > > acpi_patch;
> > > works a treat, picks up USB devices as expected.
> > > 
> > > stock;
> > > works a treat, picks up USB devices as expected, and my acx111 card 
> > > works too :)
> > > 
> > > 
> > > Now I'm looking for good suggestions again, this definitely looks like 
> > > it is related to ACPI, hence the cc' to that list too, as requested by 
> > > Andrew M.
> > > 
> > > I'm happy to apply patches / config changes as appropriate and for those 
> > > who may ask for my .config files, please see;
> > > 
> > > http://www.agotnes.com/kernelStuff/config-2.6.17-rc6-mm2
> > > 
> > > http://www.agotnes.com/kernelStuff/config-2.6.17-rc6-mm2git-acpi_patch
> > > 
> > > Also, I left the output of lspci there for reference;
> > > 
> > > http://www.agotnes.com/kernelStuff/lspci
> > > 
> > > Cheers,
> > > 
> > > :)Johny
> > > 
> > > Alan Stern wrote:
> > >> [Moved to linux-usb-devel in the hope of getting additional help]
> > >>
> > >> On Thu, 15 Jun 2006, Johny wrote:
> > >>
> > >>> Alan,
> > >>>
> > >>> See comments interspersed, thanks for your assistance :)
> > >>>
> > >>> Alan Stern wrote:
> > >>>> On Tue, 13 Jun 2006, Johny wrote:
> > >>>>
> > >>>>> Is this best suited to this mailing list?
> > >>>> It's appropriate.
> > >>>>
> > >>>>> I tried the kernel list with zero responses (so far ;), let me know 
> > >>>>> if there is
> > >>>>> anywhere else this should go.
> > >>>> ...
> > >>>>
> > >>>>> Johny ?gotnes wrote:
> > >>>>>> All,
> > >>>>>>
> > >>>>>> My USB hub isn't recognised with the latest -mm series, whereas with
> > >>>>>> 2.6.16 vanilla it is picked up & used immediately.
> > >>>>>>
> > >>>>>> The error I get in dmesg is;
> > >>>>>>
> > >>>>>> hub 4-0:1.0: USB hub found
> > >>>>>> hub 4-0:1.0: 2 ports detected
> > >>>>>> usb 1-4: new high speed USB device using ehci_hcd and address 3
> > >>>>>> ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is probably
> > >>>>>> using the wrong IRQ.
> > >>>> That last line is a clue.  What interrupt numbers are assigned under
> > >>>> 2.6.16?  If you unplug the SonyEricsson DCU-11 Cable before booting 
> > >>>> (and
> > >>>> leave it unplugged), what shows up in /proc/interrupts for both 
> > >>>> versions
> > >>>> of the kernel?
> > >>> See attached, both with the DCU-11 cable disconnected.
> > >>
> > >> From 2.6.16:
> > >>            CPU0         0:      16101          XT-PIC  timer
> > >>   1:        148          XT-PIC  i8042
> > >>   2:          0          XT-PIC  cascade
> > >>   7:          0          XT-PIC  parport0
> > >>   9:          0          XT-PIC  acpi
> > >>  10:        151          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb4
> > >>  11:          0          XT-PIC  uhci_hcd:usb2, uhci_hcd:usb3
> > >>  12:        138          XT-PIC  i8042
> > >>  14:        172          XT-PIC  ide0
> > >>  15:       2458          XT-PIC  ide1
> > >> NMI:          0 ERR:          0
> > >>
> > >> From 2.6.17:
> > >>            CPU0         0:      35651    XT-PIC-level    timer
> > >>   1:        129    XT-PIC-level    i8042
> > >>   2:          0    XT-PIC-level    cascade
> > >>   6:          3    XT-PIC-level    floppy
> > >>   7:          0    XT-PIC-level    parport0
> > >>   9:          0    XT-PIC-level    acpi
> > >>  10:          0    XT-PIC-level    ehci_hcd:usb1, uhci_hcd:usb4
> > >>  11:       1940    XT-PIC-level    uhci_hcd:usb2, uhci_hcd:usb3, wlan0
> > >>  12:        162    XT-PIC-level    i8042
> > >>  14:        171    XT-PIC-level    ide0
> > >>  15:       4251    XT-PIC-level    ide1
> > >> NMI:          0 ERR:          0
> > >>
> > >> There's nothing obviously wrong.
> > >>
> > >>>> Most likely this is a problem with the ACPI subsystem, not a USB 
> > >>>> problem.
> > >>>>
> > >>> I guessed USB due to the number of USB changes in the -mm series and, 
> > >>> obviously, my USB devices stopped registering, however, I'd not know 
> > >>> one from the other ;)
> > >>
> > >> What happens if you boot with "acpi=off" on the boot command line?
> > >>
> > >> Alan Stern

