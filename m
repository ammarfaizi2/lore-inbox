Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266691AbRGQQWT>; Tue, 17 Jul 2001 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266725AbRGQQWJ>; Tue, 17 Jul 2001 12:22:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11239 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266691AbRGQQUy>;
	Tue, 17 Jul 2001 12:20:54 -0400
Message-ID: <3B546603.7ABCB96D@mandrakesoft.com>
Date: Tue, 17 Jul 2001 12:21:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: daniel sheltraw <l5gibson@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI and ioports question
In-Reply-To: <F1137cu85K9kINc0VUy00019f37@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daniel sheltraw wrote:
> I have a question about ioports on PCI devices but first: If
> there is a better mailing list for asking these types of questions
> would you kindly direct me there.
> 
> The question is this. When do I need to use ioremap for ioports
> on a PCI device (PC architecture)? Is the answer: always except
> when the physical address is within the 64K - 1M ISA region (legacy
> ports).

For I/O ports, which have values between 0x0000 and 0xFFFF, you use
inb/inw/inl and outb/outw/outl, and do not use ioremap.

For ISA and PCI memory regions (which are completely different from I/O
ports), you always use ioremap, and talk to the regions use
readb/readw/readl and writeb/writew/writel.

There exist isa_xxx functions but do not use these:  these are only for
outdated drivers which have not yet been converted to use ioremap.

-- 
Jeff Garzik      | "I wouldn't be so judgemental
Building 1024    |  if you weren't such a sick freak."
MandrakeSoft     |             -- goats.com
