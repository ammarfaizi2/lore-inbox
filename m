Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263370AbRFAEly>; Fri, 1 Jun 2001 00:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFAElo>; Fri, 1 Jun 2001 00:41:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37528 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263370AbRFAEl0>;
	Fri, 1 Jun 2001 00:41:26 -0400
Message-ID: <3B171CF1.7F623441@mandrakesoft.com>
Date: Fri, 01 Jun 2001 00:41:21 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> >
> > I know that with MPS 1.4, the USB controller finds itself at an
> > unshared interrupt 19. I can't reboot at the moment to check.
> >
> lspci -vxxx -s 00:07.0
> 
> the APIC sits in the southbridge.
> the low 2 bits of offset 0x58 must be set [route USB IRQ to APIC], and
> 
> lspci -vx -s 00:07.2
> 
> offset 0x3C must be set to 3 [19 & 15]
> 
> There was some discussion about the same problem with the sound part of
> the southbridge.

If an IO-APIC is present, 2.4.5 automatically routes all Via IRQs to
external APIC.

See quirk_via_ioapic in drivers/pci/quirks.c.

I have received reports that MPS1.1 works on SMP Via boards, while
MPS1.4 kills it.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
