Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289074AbSA1AvH>; Sun, 27 Jan 2002 19:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289075AbSA1Au4>; Sun, 27 Jan 2002 19:50:56 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:43947 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S289074AbSA1Auo>; Sun, 27 Jan 2002 19:50:44 -0500
Message-ID: <3C54A091.DBC545EF@didntduck.org>
Date: Sun, 27 Jan 2002 19:51:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix NR_IRQS when no IO apic
In-Reply-To: <3C549AEC.D79A95FC@didntduck.org> <3C549E5E.4ACA093D@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Brian Gerst wrote:
> >
> > NR_IRQS should be 16 when the IO apic is not configured, as the 8259 PIC
> > cannot generate any more interrupts.  It also fixes a bug where the IDT
> > gets populated with random addresses, since only 16 entry stubs are
> > created.
> 
> > +#ifdef CONFIG_X86_IO_APIC
> >  #define NR_IRQS 224
> > +#else
> > +#define NR_IRQS 16
> > +#endif
> 
> What about when ioapic is configured but not present?

No problem, just wasted memory.  With CONFIG_X86_IO_APIC, all 224 entry
stubs are created.  See arch/i386/kernel/i8259.c

-- 

						Brian Gerst
