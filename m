Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbRGYL6n>; Wed, 25 Jul 2001 07:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRGYL6X>; Wed, 25 Jul 2001 07:58:23 -0400
Received: from ext.lri.fr ([129.175.15.4]:38395 "EHLO ext.lri.fr")
	by vger.kernel.org with ESMTP id <S266251AbRGYL6V>;
	Wed, 25 Jul 2001 07:58:21 -0400
Date: Wed, 25 Jul 2001 13:58:08 +0200
From: Thomas HERAULT <Thomas.Herault@lri.fr>
To: Kannan Soundarapandian <wskannan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NMI error
Message-Id: <20010725135808.133a1608.Thomas.Herault@lri.fr>
In-Reply-To: <20010725113851.76110.qmail@web10801.mail.yahoo.com>
In-Reply-To: <20010725113851.76110.qmail@web10801.mail.yahoo.com>
Organization: Laboratoire de Recherche en Informatique (parallelisme)
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001 04:38:51 -0700 (PDT)
Kannan Soundarapandian <wskannan@yahoo.com> wrote:

> Hello,
> 
> I am a grad student at the Oregon State univ. I have
> the same problem as you. I have a dual p3 1gig
> processor system with the Asus CUR-DLS motherboard
> (which uses the serverworks LE chipset), and 512 mb 
> Registered samsung RAm as one module. I am also using
> a quantum atlas10k2scsi hdd with an on motherboard
> symbios controller.
> 
> I get the following error continuously.. after which
> the system dies! I'm using redhat7.1.
> 
> Can u please help me fix the problem??
> 
> Uhhuh. NMI received. Dazed and confused, but trying to
> continue 
> Do you have a strange power saving mode enabled?
> 
> Please help. Thank you very much
> 
> Kannan
> 
> 
> =====
> --
> Kannan Soundarapandian,
> OSU, Corvallis.
> 
>

Hi.
I *almost* "solved" this problem :
Since linux-2.4.2-ac18, by default nmi_watchdog is disabled.
If you re-enable it with nmi_watchdog=1 as kernel boot parameter,
the symptom disapear.
But it is only a work around which works : the fact is that in
arch/i386/kernel/traps.c, there is a test,
  if (nmi_watchdog)
    {
        nmi_watchdog_tick(regs);
        return;
    }
Thus, our NMIs are catched an treated like watchdog NMIs,
but even if you disable nmi_watchdog (like it is by default),
these NMIs occure on my (our ?) CPUs (approximatively 300 interruption / second)
and produces these annoying error messages.

On other multi-processors motherboards I know, when you set
nmi_watchdog=0, the cat /proc/interrupts says that there is
0 NMI on every CPU ; on mine, I still have 300 NMI / sec.

For those of the lkm which are interested in this problem,
my motherboard is a 694D Pro (MS-6321) from MSI, with
a VIA VT82C694X chipset and an Apollo Pro133A north bridge,
featuring 2 Pentium III at 800 Mhz. Every kernel I tested
(2.2.x included) had the same problem.
The reasons of the interruptions are (2d then 3d)*

Hope that help and that someone could help us find what
produces these interruptions.

