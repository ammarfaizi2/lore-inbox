Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbQKAQg7>; Wed, 1 Nov 2000 11:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129102AbQKAQgt>; Wed, 1 Nov 2000 11:36:49 -0500
Received: from styx.suse.cz ([195.70.145.226]:59387 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129029AbQKAQgg>;
	Wed, 1 Nov 2000 11:36:36 -0500
Date: Wed, 1 Nov 2000 17:36:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: raptor <raptor@antifork.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in hd geometry detect code?
Message-ID: <20001101173632.A387@suse.cz>
In-Reply-To: <Pine.LNX.4.20.0011011436350.516-100000@hacaro.rewt.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.20.0011011436350.516-100000@hacaro.rewt.mil>; from raptor@antifork.org on Wed, Nov 01, 2000 at 02:37:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 02:37:00PM +0100, raptor wrote:
> Hello, 
> I've recently experienced a problem with hd geometry on Linux kernel
> 2.2.17. I've got 2 identical hard drives, set up as LBA on BIOS. BIOS sees
> them both with geometry 1245/255/63, while Linux sees the second one as
> 19857/16/63. I know i can force the kernel to recognize the right geometry
> using lilo's append=... feature, but I cannot realize why this is
> happening. I've tested it ONLY on Asus motherboards (p2bf and p2b with
> latest BIOS version), so maybe this can be a simple hardware problem...
> Anyway here's a snip from the dmesg:
> 
> hda: FUJITSU MPF3102AH, ATA DISK drive
> hdc: FUJITSU MPF3102AH, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: FUJITSU MPF3102AH, 9773MB w/2048kB Cache, CHS=1245/255/63, UDMA
> hdc: FUJITSU MPF3102AH, 9773MB w/2048kB Cache, CHS=19857/16/63, UDMA
> 
> Now the OS version:
> seti:~# cat /proc/version
> Linux version 2.2.17 (root@seti) (gcc version 2.95.2 20000220 (Debian 
> GNU/Linux)) #2 Fri Oct 20
> 
> If I switch the 2 hard disks the one put on the secondary IDE channel has
> CHS=19857/16/63, no matter which one is, while the first one remains with
> 1245/255/63.
> Let me know...

This is because BIOS only provides info about how it sees the first two
drives (hda and hdb). For hdc and subsequent drives, without the help of
a command line option Linux only can use the untranslated geometry.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
