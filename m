Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRDMWjl>; Fri, 13 Apr 2001 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDMWj3>; Fri, 13 Apr 2001 18:39:29 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15035 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132147AbRDMWjK>;
	Fri, 13 Apr 2001 18:39:10 -0400
Message-ID: <3AD78005.B8C5F094@mandrakesoft.com>
Date: Fri, 13 Apr 2001 18:39:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-17mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
Cc: f1j@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: 8139too.c and 2.4.4-pre1 kernel burp
In-Reply-To: <3AD6C572.7A9FA060@folkwang-hochschule.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Nettingsmeier wrote:
> 
> jeff garzik wrote:
> >
> >       Frank Jacobberger wrote:
> >       >
> >       > Jeff,
> >       >
> >       > I noticed the following on boot with 2.4.4-pre1:
> >       >
> >       > kernel: eth0: Too much work at interrupt, IntrStatus=0x0001.
> >       >
> >       > What is this saying to me :)
> >
> >       How often does this occur?  A lot, or just once or twice?
> 
> i'm seeing this, too. it occurs *very* often during access of the
> card:
> 
> Apr 13 11:08:11 kleineronkel kernel: eth0: Too much work at
> interrupt, IntrStatus=0x0001.
> Apr 13 11:08:44 kleineronkel last message repeated 869 times
> Apr 13 11:09:29 kleineronkel last message repeated 59 times
> Apr 13 11:10:04 kleineronkel last message repeated 2 times
> Apr 13 11:11:43 kleineronkel last message repeated 149 times
> Apr 13 11:11:59 kleineronkel last message repeated 4 times
> Apr 13 11:13:01 kleineronkel last message repeated 7 times
> Apr 13 11:15:01 kleineronkel kernel: eth0: Too much work at
> interrupt, IntrStatus=0x0001.
> Apr 13 11:16:15 kleineronkel last message repeated 6 times
> Apr 13 11:16:15 kleineronkel kernel: eth0: Too much work at
> interrupt, IntrStatus=0x0001.
> Apr 13 11:18:01 kleineronkel last message repeated 5 times
> Apr 13 11:18:06 kleineronkel modprobe: modprobe: Can't locate module
> net-pf-10
> Apr 13 11:18:08 kleineronkel sshd[1631]: Accepted password for ROOT
> from 127.0.0.1 port 32948
> Apr 13 11:18:08 kleineronkel modprobe: modprobe: Can't locate module
> net-pf-10
> Apr 13 11:18:09 kleineronkel kernel: eth0: Too much work at
> interrupt, IntrStatus=0x0001.
> 
> and so on.
> 
> it might be important that i'm sharing the IRQ:
> 
> kleineronkel:~ # cat /proc/interrupts
>            CPU0       CPU1
>   0:     294470     246477    IO-APIC-edge  timer
>   1:       4552       5266    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          2          0    IO-APIC-edge  rtc
>  12:      29084      29205    IO-APIC-edge  PS/2 Mouse
>  14:          4          4    IO-APIC-edge  ide0
>  15:       4924       5704    IO-APIC-edge  ide1
>  16:       1256       1373   IO-APIC-level  EMU10K1
>  17:          0          0   IO-APIC-level  Ensoniq AudioPCI
>  19:      76145      76111   IO-APIC-level  aic7xxx, eth0
> NMI:          0          0
> LOC:     540865     540843
> ERR:          0
> 
> and yes, this is an SMP box (dual p3/600) with a bx chipset.
> 
> please keep me on cc:, as i have only archive access to LKML.
> thanks.
> btw, jeff, the old  "kernel: eth0: Abnormal interrupt, status
> 0000000[2,6]" messages have disappeared since 2.4.3 or so.

I've fixed this locally.  I just need to test all the RTL chips (five or
six variants) before I send the next patch to Linus/Alan...

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
