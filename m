Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbTILAKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 20:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTILAKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 20:10:51 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:52236 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S261612AbTILAKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 20:10:48 -0400
Message-ID: <3F610C1B.6000307@boxho.com>
Date: Thu, 11 Sep 2003 19:58:19 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: undisclosed-recipients:;
Subject: Re: Problem: IDE data corruption with VIA chipsets on 2.4.20-19.8+others
References: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
In-Reply-To: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIA KT333
VIA KT400
SiS 745

The problem definately occurs on 2.4.20-19.8

B> I saw that on VIA KT266 k2.6.0-test5 and it
seems to go away if I use anticipatory scheduling
instead of deadline scheduling in kernel config and
don't use aggressive mem settings in cmos, and USB
on a server what's that for?

Did you flash all your bioses before trying anything?
I saw acpi-derivative problems go away after flashing
an award bios on another server. It seems there was
no graceful fail or default when acpi id info is not
in bios, so improvement was drastic. ACPI problems
cause USB to go clunk when ide is active, and downstream
conflicts like that are not too informative or productive
to look at if flashing the bios would "fix the code" as
if by magic.

-Bob


Eric Bickle wrote:

>....
>RedHat Linux 8....two IDE
>80gig hard-drives in a Software RAID-1... they all crash, they all
>run RedHat Linux, and they all use IDE.
>
>We also get various IDE errors in the /var/log files, such as: (also another
>weird IRQ error - except we're running a stock config! (ie/ no PCI devices
>other than one NIC... No idea if they're related to the IDE thing <sigh>.
>The IRQ thing appears to be USB related)
>== during server runtime ==
>kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150637065,
>sector=150636992
>kernel: end_request: I/O error, dev 16:01 (hdc), sector 150636992
>kernel: hdc: dma_intr: status=0x53 { DriveReady SeekComplete Index Error }
>kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150630007,
>sector=150629920
>kernel: end_request: I/O error, dev 16:01 (hdc), sector 150629920
>== during server boot ==
>kernel: usb.c: new USB bus registered, assigned bus number 3
>kernel: hub.c: USB hub found
>kernel: hub.c: 2 ports detected
>kernel: PCI: Found IRQ 3 for device 00:10.2
>kernel: IRQ routing conflict for 00:10.0, have irq 9, want irq 3
>kernel: IRQ routing conflict for 00:10.1, have irq 9, want irq 3
>kernel: IRQ routing conflict for 00:10.2, have irq 9, want irq 3
>kernel: IRQ routing conflict for 00:10.3, have irq 9, want irq 3
>kernel: usb-uhci.c: USB UHCI at I/O 0x9400, IRQ 9
>
>Usually after that happens (the IDE errors) it will crash fairly soon. Other
>times no errors are logged but the server is *extremely* slow - likely due
>to disk performance. My guess is that there is some sort of internal IDE
>error (A "CorrectableError"?) that the kernel is recovering from and not
>writing a message to the log.
>
>Once and awhile after a major kernel panic or reboot, the system refused to
>reboot at all, going into an endless cycle of disk checking. We tried
>various brand-name ram suppliers in case it was a ram corruption - no luck.
>Everything points to IDE.
>
>We tried various motherboards, including the following chipsets:
>VIA KT333
>VIA KT400
>SiS 745
>
>The problem definately occurs on 2.4.20-19.8, but also some earlier kernel
>versions as well (which I can't remember). It only happens during extremely
>high disk usage (I've seen it fail with about 8% CPU and Memory Usage...)
>It's not our database server - it runs fine on our older "BX-Boards" (the
>older 300mhz intels) and on various Windows NT/2000 boxes. The configuration
>of the database server is exactially the same as on the other servers (I
>double checked at least 5 times...)
>
>After about 4 months of random server crashes and corruption, various trials
>and testing, I'm fairly certain it must be a hardware interaction between
>the IDE hard-drives and the Linux kernel. We've gone through 20 IDE
>hard-drives that work fine and look fine after the crashes - definately not
>a physical hard-drive problem. Definately not a motherboard problem because
>we've been through 4 different motherboards, different manufacturers and 3
>different chipsets.
>
>Ideas..? Help..? :( The clients are going to be banging down the doors any
>day if we don't get operational servers, and so far the only solution that I
>believe works 100% is to install Windows (doh). As a last resort I'm asking
>to see if any of you Kernel-gurus have ideas :-)
>
>Thanks,
>-Eric Bickle
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

