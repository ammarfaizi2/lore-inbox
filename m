Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSEHLAN>; Wed, 8 May 2002 07:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSEHLAM>; Wed, 8 May 2002 07:00:12 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:61432 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313016AbSEHLAH>; Wed, 8 May 2002 07:00:07 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Wesen <bjorn.wesen@axis.com>,
        Martin Dalecki <dalecki@evision-ventures.com>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
Date: Fri, 1 Jan 1904 01:04:32 +0200
Message-Id: <19031231230432.20732@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0205081227100.30573-100000@godzilla.axis.se>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't see why all IDE-interfaces in the world have to be I/O-mapped just 
>because the first PC implementations used that. Sure it was an extended 
>ISA-bus but the ISA bus is long gone and we don't all run PC's anymore 
>either.
>
>So the simple abstraction we need to hit IDE-bus registers is a macro or 
>inline, instead of a call of an I/O-primitive. It was too much work to 
>abstract this when I inserted the CRIS-arch IDE-driver in the first place 
>so I found a workaround but now seems like a better time..

No, not a macro. There are cases where you want different access methods
on the same machine. For example, pmacs can have the "mac-io" (ide-pmac)
controller, which is MMIO based, _and_ a PCI-based legacy IDE controller
using inx/outx like IOs. (A typical example is the Blue&White G3 who has
both on the motherboard).

Ultimately, you want the hwif (or what it becomes in 2.5) provide a set
of functions for accessing taskfile registers and doing the PIO data
stream read/writes (that is replace inb/outb and insw/outsw).

>Similarily, there is no reason at all why the CPU has to do _polling_ just 
>because the IDE _bus_ is using a PIO-mode. It probably does that on legacy 
>PC's but HW designed, hrm, more optimally can use DMA. Hence the hooks for 
>the ide_func_t.
>
>So I'd figure the software side really would be _easier_ to implement with 
>those assumptions about how an IDE-interface is supposed to work gone.
>
>> This makes my  cleanup of the portability layer a bit hard
>> to finish on the software side.
>
>I understand that, so lets keep the discussion going and I'll check over 
>your current cleanup.
>
>/Bjorn
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


