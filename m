Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUHEFtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUHEFtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267562AbUHEFtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:49:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:15579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267555AbUHEFso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:48:44 -0400
Date: Wed, 4 Aug 2004 22:47:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tupshin Harper1 <tupshin@tupshin.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: /dev/hdl not showing up because of
 fix-ide-probe-double-detection patch
Message-Id: <20040804224709.3c9be248.akpm@osdl.org>
In-Reply-To: <4111651E.1040406@tupshin.com>
References: <411013F7.7080800@tupshin.com>
	<4111651E.1040406@tupshin.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tupshin Harper1 <tupshin@tupshin.com> wrote:
>
> Tupshin Harper1 wrote:
> 
> > I have an x86 setup with a large(9) number of ide hard drives. With 
> > 2.6.8-rc2, all of them show up (as a,b,d,e,f,g,h,i,j,k, and l), but on 
> > 2.6.8-rc2-mm1, the last one (hdl) does not show up, even though it's a 
> > slave on the same controller as hdk. Everything about the config is 
> > identical between the two. Is there some default limit or other 
> > restriction in the current mm kernels that's preventing that drive 
> > from showing up? I haven't tried any other recent mm kernels, so I 
> > don't know when this was introduced.
> >
> > -Tupshin
> 
> Well, I found the source of the problem. Dmesg gives a "ignoring 
> undecoded slave" message, which is coming from the 
> fix-ide-probe-double-detection patch.

Ah, thanks for working that out.

Did you know that Cc: stands for "copy culprit"?

> Both /dev/hdk and /dev/hdl are the same model of hard drive, and 
> unfortunately, they both report that they are Model 
> M0000000000000000000, which triggers the double detection removal.
> 
> Does anybody have a suggestion (besides maintaining my own kernel 
> without this patch)? Is the serial number settable? Is there a boot 
> param I can use?
> 
> Also, what is in /proc/ide/hd?/identity besides serial number. The two 
> drives have very similar identity files, but they are slightly 
> different. Could that additional info be used to check for duplicates?
> 
> -Tupshin
> 
> ---snippet from dmesg---
> PDC20276: IDE controller at PCI slot 0000:00:0c.0
> ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 19
> PDC20276: chipset revision 1
> PDC20276: 100% native mode on irq 19
>     ide4: BM-DMA at 0xdc00-0xdc07, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdk:pio, hdl:pio
> hdi: SAMSUNG SV8004H, ATA DISK drive
> hdj: Maxtor 6Y250P0, ATA DISK drive
> ide4 at 0xec00-0xec07,0xe802 on irq 19
> hdk: Maxtor 4R120L0, ATA DISK drive
> hdl: Maxtor 4R120L0, ATA DISK drive
> ide-probe: ignoring undecoded slave
> ide5 at 0xe400-0xe407,0xe002 on irq 19
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
