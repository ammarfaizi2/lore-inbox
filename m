Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSECBJt>; Thu, 2 May 2002 21:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315518AbSECBJs>; Thu, 2 May 2002 21:09:48 -0400
Received: from sandiego.divxnetworks.com ([207.67.92.110]:52916 "HELO
	trinity.divxnetworks.com") by vger.kernel.org with SMTP
	id <S315517AbSECBJr>; Thu, 2 May 2002 21:09:47 -0400
Date: Thu, 2 May 2002 18:09:02 -0700
From: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
X-Mailer: The Bat! (v1.53d) Personal
Reply-To: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
Organization: PM
X-Priority: 3 (Normal)
Message-ID: <197354375.20020502180902@divxnetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re[6]: Support of AMD 762?
In-Reply-To: <E173R3Y-0005GN-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Thursday, May 02, 2002, 5:36:16 PM, you wrote:

>> ENABLING IO-APIC IRQs
>> Setting 2 in the phys_id_present_map
>> ...changing IO-APIC physical APIC ID to 2 ... ok.

AC> You are using APIC mode - the $PIR router isnt even involved. The AMD 762
AC> BIOS and Software writers guide discusses the MP mode behaviour if you want
AC> to look into it further but it looks as if your BIOS is simply horked

Aha! I added noapic to kernel command line and it started to work:

PCI: PCI BIOS revision 2.10 entry at 0xf0df0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
AMD756: dev 1102:0002, router pirq : 1 get irq :  3
PCI: Found IRQ 3 for device 00:09.0
PCI: Sharing IRQ 3 with 02:06.0
AMD756: dev 1033:0035, router pirq : 2 get irq :  7
PCI: Found IRQ 7 for device 02:06.1
IRQ routing conflict for 02:05.0, have irq 9, want irq 7
AMD756: dev 1033:00e0, router pirq : 3 get irq :  9
PCI: Found IRQ 9 for device 02:06.2
<...>
Creative EMU10K1 PCI Audio Driver, version 0.18, 09:18:48 Apr 16 2002
emu10k1_probe
PCI: Enabling device 00:09.0 (0004 -> 0005)
AMD756: dev 1102:0002, router pirq : 1 get irq :  3
PCI: Found IRQ 3 for device 00:09.0
PCI: Sharing IRQ 3 with 02:06.0
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xb400-0xb41f, IRQ 3
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected

AC> PCI cards are mapped to IRQ 16->19 in APIC mode with the ISA lines on
AC> 0-15. The only question there is which of INTA/INTB/INTC/INTD is ultimately
AC> wired to the INTA on that slot. That is what the MP table should say but
AC> is not

AC> Do you see this with both MP 1.1 and MP 1.4 ?

Without noapic, the output from previous email was with MP 1.1. With
MP 1.4 kernel hangs somewhere near "calibrating APIC timer". With
noapic it seems to work with both 1.1 and 1.4.

I'll take a look at the doc you mentioned. Thank you.

-- 
Best regards,
 Eugene                            mailto:ekuznetsov@divxnetworks.com

