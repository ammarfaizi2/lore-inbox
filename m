Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265221AbSJWVfr>; Wed, 23 Oct 2002 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbSJWVfr>; Wed, 23 Oct 2002 17:35:47 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:34800 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S265221AbSJWVfp>; Wed, 23 Oct 2002 17:35:45 -0400
Message-ID: <7886757.1035409088586.JavaMail.nobody@web155>
Date: Wed, 23 Oct 2002 13:38:08 -0800 (GMT-08:00)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: jt@hpl.hp.com, alessandro.suardi@oracle.com
Subject: Re: 2.5.42: IrDA issues
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 21, 2002 at 11:19:35AM +0200, Alessandro Suardi wrote:
> > Jean Tourrilhes wrote:

[snip]

> > Will provide irdadump stuff soon[-ish], I'm wading through a backlog
> >  of, uhm, too much email. The short-form report really meant "is this
> >  a known issue ?"...
>      irtty is busted, that's why I asked for the driver you are
> using (its clearly a driver issue). I believe smc-ircc and irport are
> sick as well.
> > Anyway - the box is a Dell Latitude CPx750J with this:
> > 
> > [root@dolphin root]# findchip -v
> > Found SMC FDC37N958FR Controller at 0x3f0, DevID=0x01, Rev. 1
> >     SIR Base 0x3e8, FIR Base 0x290
> >     IRQ = 4, DMA = 3
> >     Enabled: yes, Suspended: no
> >     UART compatible: yes
> >     Half duplex delay = 3 us
> > 
> > So clearly I'm using smc-ircc.o.
> > 
> > (Of course I'll try and reproduce in 2.5.44 tonight or tomorrow).
>      Stop ! Daniele Peri has just released a new version of the SMC
> driver (smc-ircc2, link on my web page). I would like you to try this
> new driver and report to me. I plan to push this new driver in the
> kernel soon. So, don't waste too much time on the old driver.

Unfortunately I can't compile the new driver. I modified the Makefile to
 comment out versioning (which i don't use) and change kernelversion
 to an appropriate 2.5.44, but it fails like this:

In file included from /usr/src/linux-2.5.44/include/linux/irq.h:19,
                 from /usr/src/linux-2.5.44/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.5.44/include/linux/interrupt.h:25,
                 from /usr/src/linux-2.5.44/include/linux/netdevice.h:454,
                 from smsc-ircc2.c:47:
/usr/src/linux-2.5.44/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory
In file included from /usr/src/linux-2.5.44/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.5.44/include/linux/interrupt.h:25,
                 from /usr/src/linux-2.5.44/include/linux/netdevice.h:454,
                 from smsc-ircc2.c:47:
/usr/src/linux-2.5.44/include/linux/irq.h:67: `NR_IRQS' undeclared here (not in a function)
In file included from /usr/src/linux-2.5.44/include/linux/irq.h:69,
                 from /usr/src/linux-2.5.44/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.5.44/include/linux/interrupt.h:25,
                 from /usr/src/linux-2.5.44/include/linux/netdevice.h:454,
                 from smsc-ircc2.c:47:
/usr/src/linux-2.5.44/include/asm/hw_irq.h:27: `NR_IRQS' undeclared here (not in a function)
/usr/src/linux-2.5.44/include/asm/hw_irq.h:30: `NR_IRQS' undeclared here (not in a function)
smsc-ircc2.c: In function `smsc_ircc_setup_io':
smsc-ircc2.c:508: called object is not a function
smsc-ircc2.c:508: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_setup_netdev':
smsc-ircc2.c:637: called object is not a function
smsc-ircc2.c:637: parse error before string constant
smsc-ircc2.c:666: called object is not a function
smsc-ircc2.c:666: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_net_ioctl':
smsc-ircc2.c:707: called object is not a function
smsc-ircc2.c:707: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_hard_xmit_sir':
smsc-ircc2.c:798: called object is not a function
smsc-ircc2.c:798: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_set_fir_speed':
smsc-ircc2.c:840: called object is not a function
smsc-ircc2.c:840: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_fir_start':
smsc-ircc2.c:893: called object is not a function
smsc-ircc2.c:893: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_fir_stop':
smsc-ircc2.c:941: called object is not a function
smsc-ircc2.c:941: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_change_speed':
smsc-ircc2.c:967: called object is not a function
smsc-ircc2.c:967: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_dma_receive_complete':
smsc-ircc2.c:1350: called object is not a function
smsc-ircc2.c:1350: parse error before string constant
smsc-ircc2.c:1357: called object is not a function
smsc-ircc2.c:1357: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_interrupt_sir':
smsc-ircc2.c:1485: called object is not a function
smsc-ircc2.c:1485: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_net_open':
smsc-ircc2.c:1613: called object is not a function
smsc-ircc2.c:1613: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_sir_start':
smsc-ircc2.c:1785: called object is not a function
smsc-ircc2.c:1785: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_sir_stop':
smsc-ircc2.c:1824: called object is not a function
smsc-ircc2.c:1824: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_sir_write_wakeup':
smsc-ircc2.c:1875: called object is not a function
smsc-ircc2.c:1875: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_look_for_chips':
smsc-ircc2.c:2014: called object is not a function
smsc-ircc2.c:2014: parse error before string constant
smsc-ircc2.c: In function `smc_superio_flat':
smsc-ircc2.c:2057: called object is not a function
smsc-ircc2.c:2057: parse error before string constant
smsc-ircc2.c:2058: called object is not a function
smsc-ircc2.c:2058: parse error before string constant
smsc-ircc2.c:2075: called object is not a function
smsc-ircc2.c:2075: parse error before string constant
smsc-ircc2.c: In function `smc_superio_paged':
smsc-ircc2.c:2096: warning: unused variable `dma'
smsc-ircc2.c:2096: warning: unused variable `irq'
smsc-ircc2.c: In function `smsc_ircc_probe':
smsc-ircc2.c:2149: called object is not a function
smsc-ircc2.c:2149: parse error before string constant
smsc-ircc2.c: In function `smsc_ircc_set_transceiver_smsc_ircc_atc':
smsc-ircc2.c:2277: called object is not a function
smsc-ircc2.c:2277: parse error before string constant
smsc-ircc2.c:2277: warning: left-hand operand of comma expression has no effect
smsc-ircc2.c:2277: parse error before ')' token
smsc-ircc2.c: At top level:
smsc-ircc2.c:1819: warning: `smsc_ircc_sir_stop' defined but not used
smsc-ircc2.c:755: warning: `smsc_ircc_timeout' defined but not used
make: *** [smsc-ircc2.o] Error 1

This happens with both drivers pointed by your page.
Perhaps 2.5.44 is too new for this driver ?

--alessandro
