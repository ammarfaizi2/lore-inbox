Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTKLC5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 21:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTKLC5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 21:57:08 -0500
Received: from mxsf20.cluster1.charter.net ([209.225.28.220]:21768 "EHLO
	mxsf20.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261464AbTKLC5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 21:57:01 -0500
Date: Tue, 11 Nov 2003 21:55:07 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A7N8X (Deluxe) Madness
Message-ID: <20031112025507.GA18073@forming>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <frodoid.frodo.87r80eznz9.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <frodoid.frodo.87r80eznz9.fsf@usenet.frodoid.org>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test9-mm2 i686
X-Uptime: 21:39:49 up 1 day, 58 min,  3 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I would share some of my experiences with the ASUS A7N8X.  I
just got this mobo last week, so I haven't had a whole lot of time with
it nor do I have anything on the SATA controller.  2.6.0-test9-mm2 would
crash hard with any IDE activity with APIC and IO-APIC enabled.
recompiling the kernel without APIC or IO-APIC but with APCI still
enabled and and *no* pci=noacpi on the command line the board is
perfectly stable and I see no performance hit with the IDE disks.  Here
is my /proc/interrupts with the working config:

$ cat /proc/interrupts 
           CPU0       
  0:   90624732          XT-PIC  timer
  1:      21404          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      35712          XT-PIC  ohci_hcd
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:    6930402          XT-PIC  nvidia
 12:     114340          XT-PIC  ehci_hcd, ohci_hcd, eth0, NVidia
           nForce2
 14:        887          XT-PIC  ide0
 15:     133930          XT-PIC  ide1
NMI:          0 
ERR:          0
 
If there is anything else I could test or anymore info I could give to
help track down this problem I would be more than happy to help.  I am
planning on buying some SATA drives soon and might change my mind if
this issue isn't cleared up.

Thanks
 
On approximately Tue, Nov 11, 2003 at 08:47:38PM +0100, Julien Oster wrote:
> 
> Hello,
> 
> seriously, I'm pretty fed up with it.
> 
> I have an ASUS A7N8X Deluxe mainboard. Yeah, right, that thing causing
> serious trouble. I'm getting hard lockups all the time. No panic, no
> message, no sysrq, no blinking cursor in the framebuffer. Gone for good.
> 
> I went through the mailing list archive and tried out many
> things. However, this is how far I got:
> 
> With 2.6.0-test9, the machine locks up while booting or shortly
> after. This is clearly connected to high IDE (PATA) load, since it
> locks up with a 100% chance while doing an fsck. If I managed booting
> it (which means, if it doesn't do an fsck while booting) I can lock it
> up immediately by doing a hdparm -t /dev/hda. I don't know what SATA
> load would do on that kernel, I never got that far.
> 
> Specifying "noapic nolapic acpi=off noacpi=off" helps, I got no
> lockups. However, I don't like this, because of the performance flaws
> (I'll talk about this later).
> 
> So, one might suspect: Something between APIC or ACPI (or both) and
> the IDE controller broken, nothing to fix there, that's life. Right?
> Wrong. Because:
> 
> With 2.4.22-ac4 it actually works *better*. Not absolutely good, but
> better. I can achieve uptimes up to *several days*. However, it still
> locks up. Sometimes after several days, sometimes some minutes after
> booting. But basically I can actually use my computer with
> 2.4.22-ac4. Strangely, the lockups don't seem to be connected to IDE
> load with that kernel. When the machine locks up, it simply does,
> without any appearent cause. I can create as many CPU, disk, network
> or whatever load I want. All goes fine. Then I leave the computer, the
> machine staying idle, I come back and it's crashed. I even have the
> impression, that it only crashes when it has no load at all. Clearly
> spoken, I can't really remember that it locked up when I was sitting
> in front of the computer. Moving the mouse or typing things seems to
> create enough load to actually keep it from locking up?!
> 
> So, things are totally different between 2.6.0-test9 and
> 2.4.22-ac4. 2.6.0-test9 doesn't like the slightest IDE load with that
> mainboard at all. 2.4.22-ac4 doesn't care, runs for hours or for days
> and then locks up when it just gets bored or something similar.
> 
> The solution might look simple: why don't I just use 2.6.0-test9 with
> the enormous "noapic nolapic acpi=off pci=noacpi" command line?
> Because then, my SATA performance really is a pain compared to what I
> can get with 2.4.22-ac4. A simple example with hdparm -t (I tried
> other things, also, but this already gives a nice example): with
> 2.4.22-ac4 I get amazing 100 to 110 MB/s on the SATA RAID. With
> 2.6.0-test9 and the nasty command line, I get at most 40MB/s. To feel
> the difference, I just have to fire up Oracle and let it do some I/O
> expensive things.
> 
> Has nobody an idea what it could be? That's just strange, both kernels
> are unstable on that mainboard, but the one is much more stable while
> locking up in completely different situations.
> 
> If that continues like that, I'll begin to feel the urge of hunting
> ASUS and NVIDIA down.
> 
> Well, I hope I could give you some worthy information.
> 
> In great despair,
> Julien
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
