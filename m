Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSCWB5a>; Fri, 22 Mar 2002 20:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSCWB5L>; Fri, 22 Mar 2002 20:57:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:46465 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287204AbSCWB5E>;
	Fri, 22 Mar 2002 20:57:04 -0500
Message-ID: <3C9BE024.B2A5ED0F@zip.com.au>
Date: Fri, 22 Mar 2002 17:53:40 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shane Nay <shane@minirl.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tyan S2466 MPX integrated ethernet interrupt happy
In-Reply-To: <200203222229.g2MMT4t30679@zeus.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Nay wrote:
> 
> I have an S2466 with an integrated 3COM 3C905C ethernet controller.
> What I've noticed when streaming tons of data accross my internal LAN
> is that the ethernet driver appears to be sucking up tons of cycles.
> 
> A quick investigation of /proc/interrupts shows-
>   0:     195949     192414    IO-APIC-edge  timer
>   1:       5126       5129    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   5:          0          0   IO-APIC-level  usb-ohci
>   8:          1          0    IO-APIC-edge  rtc
>   9:    4248819    4245969   IO-APIC-level  eth0
>  10:     144865     145243   IO-APIC-level  usb-ohci, nvidia, EMU10K1
>  12:      48546      48865    IO-APIC-edge  PS/2 Mouse
>  14:     122395     121652    IO-APIC-edge  ide0
>  15:      26286      26498    IO-APIC-edge  ide1
> NMI:          0          0
> LOC:     388204     388212
> ERR:          0
> MIS:          4
> 
> So, approximately 8.5 million ethernet interrupts.  The system is
> noticably slower when streaming ethernet data, and it's sucking up a
> lot more processing time than on my other much slower other box.
> This box is running a stock 2.4.18 kernel from kernel.org (i.e. no
> custom hacks).  It's running 2 1800+ XPs.

That all looks normal.  Could you be more specific about
the performance problems?  How much slower? Output from
`top' and `ps'?  Any nasty messages in the system log?

Looking at the ethernet driver won't help, I expect - it's
as efficient as most any other driver.  If there is a problem,
it lies elsewhere...

A kernel profile would be illuminating.  Build the kernel with as few
modules as possible, boot the machine with `profile=1' and play
with readprofile.

-
