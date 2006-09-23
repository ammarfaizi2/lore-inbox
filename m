Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWIWNIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWIWNIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 09:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWIWNIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 09:08:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:51157 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751047AbWIWNIA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 09:08:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Sat, 23 Sep 2006 15:07:54 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609231303.35481.arnd@arndb.de> <8bd0f97a0609230415v6a31a784kf6a381f274cf7ef6@mail.gmail.com>
In-Reply-To: <8bd0f97a0609230415v6a31a784kf6a381f274cf7ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609231507.55198.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 13:15, Mike Frysinger wrote:
> On 9/23/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday 23 September 2006 08:50, Mike Frysinger wrote:
> > > On 9/22/06, Arnd Bergmann <arnd@arndb.de> wrote:

> > > > What's the point, are you getting paid by lines of code? Just use
> > > > the registers directly!
> > >
> > > in our last submission we were doing exactly that ... and we were told
> > > to switch to a function style method of reading/writing memory mapped
> > > registers
> >
> > It's hard to imagine that what you have here was intended by the comment
> > then. Do you have an archive link about that discussion?
> 
> no as i was not around for said discussion.  but it should be in the
> threads covering the submission of blackfin for 2.6.13 ...

Ok, I found http://marc.theaimsgroup.com/?l=linux-kernel&m=114298753207549&w=2
from akpm, and I fear you heavily misunderstood him.

Your original patch had code like

/* System Reset and Interrupt Controller registers for core A (0xFFC0 0100-0xFFC0 01FF) */
#define SICA_SWRST              0xFFC00100­·····/* Software Reset register */
#define SICA_SYSCR              0xFFC00104­·····/* System Reset Configuration register */
#define SICA_RVECT              0xFFC00108­·····/* SIC Reset Vector Address Register */
#define SICA_IMASK              0xFFC0010C­·····/* SIC Interrupt Mask register 0 - hack to fix old tests */
#define SICA_IMASK0             0xFFC0010C­·····/* SIC Interrupt Mask register 0 */
#define SICA_IMASK1             0xFFC00110­·····/* SIC Interrupt Mask register 1 */
#define SICA_IAR0               0xFFC00124­·····/* SIC Interrupt Assignment Register 0 */
#define SICA_IAR1               0xFFC00128­·····/* SIC Interrupt Assignment Register 1 */
#define SICA_IAR2               0xFFC0012C­·····/* SIC Interrupt Assignment Register 2 */
#define SICA_IAR3               0xFFC00130­·····/* SIC Interrupt Assignment Register 3 */
#define SICA_IAR4               0xFFC00134­·····/* SIC Interrupt Assignment Register 4 */
#define SICA_IAR5               0xFFC00138­·····/* SIC Interrupt Assignment Register 5 */
#define SICA_IAR6               0xFFC0013C­·····/* SIC Interrupt Assignment Register 6 */
#define SICA_IAR7               0xFFC00140­·····/* SIC Interrupt Assignment Register 7 */
#define SICA_ISR0               0xFFC00114­·····/* SIC Interrupt Status register 0 */
#define SICA_ISR1               0xFFC00118­·····/* SIC Interrupt Status register 1 */
#define SICA_IWR0               0xFFC0011C­·····/* SIC Interrupt Wakeup-Enable register 0 */
#define SICA_IWR1               0xFFC00120­·····/* SIC Interrupt Wakeup-Enable register 1 */

...

#define pSICA_SWRST (volatile unsigned short *)SICA_SWRST
#define pSICA_SYSCR (volatile unsigned short *)SICA_SYSCR
#define pSICA_RVECT (volatile unsigned short *)SICA_RVECT
#define pSICA_IMASK (volatile unsigned long *)SICA_IMASK
#define pSICA_IMASK0 (volatile unsigned long *)SICA_IMASK0
#define pSICA_IMASK1 (volatile unsigned long *)SICA_IMASK1
#define pSICA_IAR0 ((volatile unsigned long *)SICA_IAR0)
#define pSICA_IAR1 (volatile unsigned long *)SICA_IAR1
#define pSICA_IAR2 (volatile unsigned long *)SICA_IAR2
#define pSICA_IAR3 (volatile unsigned long *)SICA_IAR3
#define pSICA_IAR4 (volatile unsigned long *)SICA_IAR4
#define pSICA_IAR5 (volatile unsigned long *)SICA_IAR5
#define pSICA_IAR6 (volatile unsigned long *)SICA_IAR6
#define pSICA_IAR7 (volatile unsigned long *)SICA_IAR7
#define pSICA_ISR0 (volatile unsigned long *)SICA_ISR0
#define pSICA_ISR1 (volatile unsigned long *)SICA_ISR1
#define pSICA_IWR0 (volatile unsigned long *)SICA_IWR0
#define pSICA_IWR1 (volatile unsigned long *)SICA_IWR1

static void bf561_internal_mask_irq(unsigned int irq)
{
	unsigned long irq_mask;
	if ((irq - (IRQ_CORETMR + 1)) < 32) {
		irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
		*pSICA_IMASK0 &= ~irq_mask;
	} else {
		irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
		*pSICA_IMASK1 &= ~irq_mask;
	}
}

which Andrew objected to, on multiple grounds. You now converted this to

/* System Reset and Interrupt Controller registers for core A (0xFFC0 0100-0xFFC0 01FF) */
#define SICA_SWRST              0xFFC00100­·····/* Software Reset register */
#define SICA_SYSCR              0xFFC00104­·····/* System Reset Configuration register */
#define SICA_RVECT              0xFFC00108­·····/* SIC Reset Vector Address Register */
#define SICA_IMASK              0xFFC0010C­·····/* SIC Interrupt Mask register 0 - hack to fix old tests */
#define SICA_IMASK0             0xFFC0010C­·····/* SIC Interrupt Mask register 0 */
#define SICA_IMASK1             0xFFC00110­·····/* SIC Interrupt Mask register 1 */
#define SICA_IAR0               0xFFC00124­·····/* SIC Interrupt Assignment Register 0 */
#define SICA_IAR1               0xFFC00128­·····/* SIC Interrupt Assignment Register 1 */
#define SICA_IAR2               0xFFC0012C­·····/* SIC Interrupt Assignment Register 2 */
#define SICA_IAR3               0xFFC00130­·····/* SIC Interrupt Assignment Register 3 */
#define SICA_IAR4               0xFFC00134­·····/* SIC Interrupt Assignment Register 4 */
#define SICA_IAR5               0xFFC00138­·····/* SIC Interrupt Assignment Register 5 */
#define SICA_IAR6               0xFFC0013C­·····/* SIC Interrupt Assignment Register 6 */
#define SICA_IAR7               0xFFC00140­·····/* SIC Interrupt Assignment Register 7 */
#define SICA_ISR0               0xFFC00114­·····/* SIC Interrupt Status register 0 */
#define SICA_ISR1               0xFFC00118­·····/* SIC Interrupt Status register 1 */
#define SICA_IWR0               0xFFC0011C­·····/* SIC Interrupt Wakeup-Enable register 0 */
#define SICA_IWR1               0xFFC00120­·····/* SIC Interrupt Wakeup-Enable register 1 */

/* System Reset and Interrupt Controller registers for core A (0xFFC0 0100-0xFFC0 01FF) */
#define bfin_read_SICA_SWRST()               bfin_read16(SICA_SWRST)
#define bfin_write_SICA_SWRST(val)           bfin_write16(SICA_SWRST,val)
#define bfin_read_SICA_SYSCR()               bfin_read16(SICA_SYSCR)
#define bfin_write_SICA_SYSCR(val)           bfin_write16(SICA_SYSCR,val)
#define bfin_read_SICA_RVECT()               bfin_read16(SICA_RVECT)
#define bfin_write_SICA_RVECT(val)           bfin_write16(SICA_RVECT,val)
#define bfin_read_SICA_IMASK()               bfin_read32(SICA_IMASK)
#define bfin_write_SICA_IMASK(val)           bfin_write32(SICA_IMASK,val)
#define bfin_read_SICA_IMASK0()              bfin_read32(SICA_IMASK0)
#define bfin_write_SICA_IMASK0(val)          bfin_write32(SICA_IMASK0,val)
#define bfin_read_SICA_IMASK1()              bfin_read32(SICA_IMASK1)
#define bfin_write_SICA_IMASK1(val)          bfin_write32(SICA_IMASK1,val)
#define bfin_read_SICA_IAR0()                bfin_read32(SICA_IAR0)
#define bfin_write_SICA_IAR0(val)            bfin_write32(SICA_IAR0,val)
#define bfin_read_SICA_IAR1()                bfin_read32(SICA_IAR1)
#define bfin_write_SICA_IAR1(val)            bfin_write32(SICA_IAR1,val)
#define bfin_read_SICA_IAR2()                bfin_read32(SICA_IAR2)
#define bfin_write_SICA_IAR2(val)            bfin_write32(SICA_IAR2,val)
#define bfin_read_SICA_IAR3()                bfin_read32(SICA_IAR3)
#define bfin_write_SICA_IAR3(val)            bfin_write32(SICA_IAR3,val)
#define bfin_read_SICA_IAR4()                bfin_read32(SICA_IAR4)
#define bfin_write_SICA_IAR4(val)            bfin_write32(SICA_IAR4,val)
#define bfin_read_SICA_IAR5()                bfin_read32(SICA_IAR5)
#define bfin_write_SICA_IAR5(val)            bfin_write32(SICA_IAR5,val)
#define bfin_read_SICA_IAR6()                bfin_read32(SICA_IAR6)
#define bfin_write_SICA_IAR6(val)            bfin_write32(SICA_IAR6,val)
#define bfin_read_SICA_IAR7()                bfin_read32(SICA_IAR7)
#define bfin_write_SICA_IAR7(val)            bfin_write32(SICA_IAR7,val)
#define bfin_read_SICA_ISR0()                bfin_read32(SICA_ISR0)
#define bfin_write_SICA_ISR0(val)            bfin_write32(SICA_ISR0,val)
#define bfin_read_SICA_ISR1()                bfin_read32(SICA_ISR1)
#define bfin_write_SICA_ISR1(val)            bfin_write32(SICA_ISR1,val)
#define bfin_read_SICA_IWR0()                bfin_read32(SICA_IWR0)
#define bfin_write_SICA_IWR0(val)            bfin_write32(SICA_IWR0,val)
#define bfin_read_SICA_IWR1()                bfin_read32(SICA_IWR1)
#define bfin_write_SICA_IWR1(val)            bfin_write32(SICA_IWR1,val)

...
static void bf561_internal_mask_irq(unsigned int irq)
{
	unsigned long irq_mask;
	if ((irq - (IRQ_CORETMR + 1)) < 32) {
		irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
		bfin_write_SICA_IMASK0(bfin_read_SICA_IMASK0() & ~irq_mask);
	} else {
		irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
		bfin_write_SICA_IMASK1(bfin_read_SICA_IMASK1() & ~irq_mask);
	}
}

which is about just as bad, but for different reasons. Now, there are
at least two common methods for how to do this better, both involving
the readl/writel low-level accessors (or something similar).

The first one uses enumerated register numers:

/* System Reset and Interrupt Controller registers for core A (0xFFC0 0100-0xFFC0 01FF) */

enum bfin_sica_regs {
	SICA_SWRST   = 100,­·····/* Software Reset register */
	SICA_SYSCR   = 104,­·····/* System Reset Configuration register */
	SICA_RVECT   = 108,­·····/* SIC Reset Vector Address Register */
	SICA_IMASK   = 10C,­·····/* SIC Interrupt Mask register 0 - hack to fix old tests */
	SICA_IMASK0  = 10C,­·····/* SIC Interrupt Mask register 0 */
	SICA_IMASK1  = 110,­·····/* SIC Interrupt Mask register 1 */
	SICA_IAR0    = 124,­·····/* SIC Interrupt Assignment Register 0 */
	SICA_IAR1    = 128,­·····/* SIC Interrupt Assignment Register 1 */
	SICA_IAR2    = 12C,­·····/* SIC Interrupt Assignment Register 2 */
	SICA_IAR3    = 130,­·····/* SIC Interrupt Assignment Register 3 */
	SICA_IAR4    = 134,­·····/* SIC Interrupt Assignment Register 4 */
	SICA_IAR5    = 138,­·····/* SIC Interrupt Assignment Register 5 */
	SICA_IAR6    = 13C,­·····/* SIC Interrupt Assignment Register 6 */
	SICA_IAR7    = 140,­·····/* SIC Interrupt Assignment Register 7 */
	SICA_ISR0    = 114,­·····/* SIC Interrupt Status register 0 */
	SICA_ISR1    = 118,­·····/* SIC Interrupt Status register 1 */
	SICA_IWR0    = 11C,­·····/* SIC Interrupt Wakeup-Enable register 0 */
	SICA_IWR1    = 120,­·····/* SIC Interrupt Wakeup-Enable register 1 */
};

...

static void __iomem *bfin_sica = (void __iomem *)0xffc00100ul;
static inline __le32 bfin_sica_read(int reg)
{
	return (__le32)readl(bfin_sica + reg);
}

static inline void bfin_sica_write(int reg, __le32 val)
{
	writel((uint32_t)val, bfin_sica + reg);
}

static void bf561_internal_mask_irq(unsigned int irq)
{
	unsigned long irq_mask;
	if ((irq - (IRQ_CORETMR + 1)) < 32) {
		irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
		bfin_sica_write(SICA_IMASK0,
			bfin_sica_read(SICA_IMASK0) & ~irq_mask);
	} else {
		irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
		bfin_sica_write(SICA_IMASK0,
			bfin_sica_read(SICA_IMASK0) & ~irq_mask);
	}
}

The alternative approach uses a structure:

/* System Reset and Interrupt Controller registers for core A (0xFFC0 0100-0xFFC0 01FF) */

struct bfin_sica_regs {
	__le32 swrst;	/* Software Reset register */
	__le32 syscr;	/* System Reset Configuration register */
	__le32 rvect;	/* SIC Reset Vector Address Register */
	__le32 imask[2]; /* SIC Interrupt Mask register 0-1 */
	__le32 iar[8];	/* SIC Interrupt Assignment Register 0-7 */
	__le32 isr[2];	/* SIC Interrupt Status register 0-1 */
	__le32 iwr[2];	/* SIC Interrupt Wakeup-Enable register 0-2 */
};

...

static struct bfin_sica_regs __iomem *bfin_sica = (void __iomem *)0xffc00100ul;

static void bf561_internal_mask_irq(unsigned int irq)
{
	int irqnr = irq - (IRQ_CORETMR + 1);
	__le32 __iomem *reg = &bfin_sica->imask[irqnr >> 5];
	unsigned long irq_mask = 1 << (irqnr & 0x1f);

	writel(reg, readl(reg) & ~irq_mask);
}

I'd personally prefer the last approach because of its compactness.

	Arnd <><
