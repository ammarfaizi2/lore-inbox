Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293409AbSBYNUG>; Mon, 25 Feb 2002 08:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293412AbSBYNT5>; Mon, 25 Feb 2002 08:19:57 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:6638 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S293409AbSBYNTu>; Mon, 25 Feb 2002 08:19:50 -0500
Date: Mon, 25 Feb 2002 14:19:23 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, fernando@quatro.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <20020225131923.GY13774@os.inf.tu-dresden.de>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, fernando@quatro.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020223231850.4ea9d3ca.skraw@ithnet.com> <58726664.1014540170@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <58726664.1014540170@[10.10.2.3]>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Feb 24, 2002 at 08:42:52 -0800, Martin J. Bligh wrote:
> If you are crashing near the wait_init_idle fix, you might
> try Ingo's scheduler patch - it has a different way of
> fixing this race condition.

I tried sched-O1-2.4.18-pre8-K3 and it didn't work with a SMP kernel
either.

Furthermore it also doesn't work with a UP kernel with Local IO APIC support
(CONFIG_X86_UP_IOAPIC). Without it does work. It reliably hangs in
arch/i386/kernel/io_apic.c:check_timer (in 2.4.18-pre8-K3 about line 1510)

        printk(KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);

        if (pin1 != -1) {
                /*
                 * Ok, does IRQ0 through the IOAPIC work?
                 */
          printk(KERN_ERR "1\n");
                unmask_IO_APIC_irq(0);
          printk(KERN_ERR "2\n");
                if (timer_irq_works()) {

The "1" still occurs, then it hangs...


Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
1




Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
