Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRDBC7R>; Sun, 1 Apr 2001 22:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132611AbRDBC7I>; Sun, 1 Apr 2001 22:59:08 -0400
Received: from hyperion.expio.net.nz ([202.27.199.10]:48136 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S132608AbRDBC6w>;
	Sun, 1 Apr 2001 22:58:52 -0400
Message-ID: <018201c0bb20$ef16f2a0$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010401185932.6155D-100000@mandrakesoft.mandrakesoft.com> <014401c0bb0e$a38c6fc0$1400a8c0@expio.net.nz>
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot 
Date: Mon, 2 Apr 2001 14:57:33 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

>
> However, the machine now crashes at "Configuring Kernel Parameters" during
> rc initialisation:
>
>
>         Welcome to Red Hat Linux
>     Press 'I' for interactive startup
>
> Mounting /proc filesystem...        [   OK   ]
> Configuring Kernel Parameters...
>
>
> This is if I type "linux noapic" at the Lilo boot prompt.
>
> Also, what do I lose by running with noapic?
>
>


Just discovered the above is not quite correct - it actually says [  OK  ]
after Configuring Kernel Parameters, and crashes on the next line.

Reading through /etc/rc.d/rc.sysinit, the next line is where it sets the
system clock. If I comment out the line:

    /sbin/hwclock $CLOCKFLAGS

Then the system will boot OK with 'noapic'. So presumably the system RTC is
not accessed in a SMP-compatible way without APIC.

Anyway, I'm not too happy about having to run without APIC - seems more of a
workaround than a fix. I'm happy to test patches etc if anyone has any
ideas - this problem I presume affects all motherboards using the VIA 694XDP
chipset.


Thanks in advance,

Simon Garner

