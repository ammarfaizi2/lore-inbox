Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRETKpn>; Sun, 20 May 2001 06:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbRETKpe>; Sun, 20 May 2001 06:45:34 -0400
Received: from p3EE3C8C4.dip.t-dialin.net ([62.227.200.196]:3588 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S261747AbRETKpQ>; Sun, 20 May 2001 06:45:16 -0400
Date: Sun, 20 May 2001 12:27:59 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Donald Becker <becker@scyld.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: RTL8139 difficulties in 2.2, not in 2.4
Message-ID: <20010520122759.B2910@emma1.emma.line.org>
Mail-Followup-To: Donald Becker <becker@scyld.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, jgarzik@mandrakesoft.com
In-Reply-To: <20010519140413.B1795@emma1.emma.line.org> <Pine.LNX.4.10.10105191107450.956-100000@vaio.greennet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10105191107450.956-100000@vaio.greennet>; from becker@scyld.com on Sat, May 19, 2001 at 11:15:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Donald Becker wrote:

> > eth1: Transmit timeout, status 0c 0005 media 18.
> > eth1: Tx queue start entry 4  dirty entry 0.
> > eth1: RTL8139 Interrupt line blocked, status 5.
> > eth1: RTL8139 Interrupt line blocked, status 5.
> > eth1: RTL8139 Interrupt line blocked, status 4.
> > eth1: RTL8139 Interrupt line blocked, status 4.
> > (continues every minute with status 4 if no traffic on interface)
> 
> The card is reporting that the interrupt line has been asserted (Tx
> done), but the interrupt handler hasn't been called.
> 
> You can verify this by watching the interrupt count in /proc/interrupts.
> 
> Try booting the kernel with "noapic", which we recommend as the safe
> default setting.

Sorry, this didn't work out. I still get Tx descriptor dumps, and these:

eth1: RTL8139 Interrupt line blocked, status 5.
eth1: Transmit timeout, status 0c 0005 media 18.
eth1: Tx queue start entry 8  dirty entry 4, full.
eth1:  Tx descriptor 0 is 9008a03c. (queue head)
eth1:  Tx descriptor 1 is 9008a03c.
eth1:  Tx descriptor 2 is 9008a03c.
eth1:  Tx descriptor 3 is 9008a03c.
eth1: MII #32 registers are: 1000 782d 0000 0000 01e1 0000 0000 0000.
eth1: RTL8139 Interrupt line blocked, status 5.

/proc/interrupt looks like this:
           CPU0       
  0:      37029          XT-PIC  timer
  1:       1049          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:       1955          XT-PIC  serial
  5:        173          XT-PIC  ide2, eth0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  eth1
 10:       1323          XT-PIC  serial
 11:         41          XT-PIC  sym53c8xx, es1371
 13:          1          XT-PIC  fpu
 14:      14947          XT-PIC  ide0
NMI:          0

So, yes, it looks as if there had not been a single eth1 IRQ. But why
does 2.4 get it right, then, even without special boot options?

-- 
Matthias Andree
