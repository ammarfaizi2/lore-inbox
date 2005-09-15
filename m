Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVIOWH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVIOWH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVIOWH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:07:57 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:11116 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbVIOWH5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:07:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g5Bb7kiLFsFxURn+FCuBZ3lO1r+YlxrCaKRQZdJMZMfSLnDqvZPK3h6WsQOZiZY9/vfOCo8/x8GHuUW3oACHDWMeYsUe+pomEXF5MRwgAwXunaVqDlQ8mzlHSraJZt0fcN2ldyVVVGrUDJ7pRu5UNzmCXwbCrS6SSebXJwV7ji0=
Message-ID: <9a87484905091515072c7dd4a8@mail.gmail.com>
Date: Fri, 16 Sep 2005 00:07:56 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: early printk timings way off
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509151458330.1800@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509152342.24922.jesper.juhl@gmail.com>
	 <Pine.LNX.4.58.0509151458330.1800@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Thu, 15 Sep 2005, Jesper Juhl wrote:
> 
> > Early during boot the printk timings are way off :
> >
> > [4294667.296000] Linux version 2.6.14-rc1-git1 (juhl@dragon) (gcc version 3.3.6) #1 PREEMPT Thu Sep 15 22:25:37 CEST 2005
> > [4294667.296000] BIOS-provided physical RAM map:
> > [4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> > [4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> > [4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> > [4294667.296000]  BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
> > [4294667.296000]  BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
> > [4294667.296000]  BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
> > [4294667.296000]  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
> > [4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> > [4294667.296000] 511MB LOWMEM available.
> > [4294667.296000] On node 0 totalpages: 131052
> > [4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
> > [4294667.296000]   Normal zone: 126956 pages, LIFO batch:31
> > [4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
> > [4294667.296000] DMI 2.3 present.
> > [4294667.296000] ACPI: RSDP (v000 ASUS                                  ) @ 0x000f69e0
> > [4294667.296000] ACPI: RSDT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec000
> > [4294667.296000] ACPI: FADT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec080
> > [4294667.296000] ACPI: BOOT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec040
> > [4294667.296000] ACPI: DSDT (v001   ASUS A7M266   0x00001000 MSFT 0x0100000b) @ 0x00000000
> > [4294667.296000] Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
> > [4294667.296000] Built 1 zonelists
> > [4294667.296000] Kernel command line: auto BOOT_IMAGE=2.6.14-rc1-git1 ro root=801 pci=usepirqmask
> > [4294667.296000] Initializing CPU#0
> > [4294667.296000] CPU 0 irqstacks, hard=c03d2000 soft=c03d1000
> > [4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
> >
> > ^^^^^ These I can buy as the result of an uninitialized variable. Why are
> >       we not initializing this counter to zero?
> >
> > [    0.000000] Detected 1400.279 MHz processor.
> >
> > ^^^^^ Ok, we finally seem to have initialized the counter...
> >
> > [   27.121583] Using tsc for high-res timesource
> >
> > ^^^^^ 27 seconds??? Something is off here. It certainly doesn't take 27 sec
> >       to get from the previous message to this one during the actual boot.
> >       What's up with that?
> >
> > [   27.121620] Console: colour dummy device 80x25
> > [   27.122909] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > ...
> >
> > No big deal, but it sure would look better (and be actually useful for the
> > first few messages) if things started out at zero and then actually
> > increased sanely from the very beginning.  :-)
> 
> For purposes of testing rollover and/or finding broken drivers etc.,
> jiffies is init to something like -5 seconds (or max_jiffies - 5)
> and then it rolls over soon.
> 

I'm aware of that fact, but I thought the printk timings were supposed
to be releative to the kernel starting - surely the known initial
value of jiffies could be accounted/corrected for when printing the
timing values.  Also, that still doesn't explain why the first many
lines seem to be just printing some fixed value (my guess is an
uninitialized var, but I haven't actually looked). It also doesn't
explain why two lines, the first with timing value 0.000, and the next
with 27.121 don't seem to match reality - the *actual* delta between
printing those two lines is far lower than 27 seconds.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
