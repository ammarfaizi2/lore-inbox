Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbRIOR5U>; Sat, 15 Sep 2001 13:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272448AbRIOR5B>; Sat, 15 Sep 2001 13:57:01 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:11291 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S272446AbRIOR4t>; Sat, 15 Sep 2001 13:56:49 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109151131320.32167-100000@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.33.0109151131320.32167-100000@sjoerd.sjoerdnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 13:57:44 -0400
Message-Id: <1000576671.32708.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-15 at 05:44, Arjan Filius wrote:
> Hi Robert,

Hi Arjan,

> Didn't discover yet, the only "strange" thing is when using <TAB>
> autocompleteion in a kterm in kde i get every time a kde crash-bug-report
> popup message. however, no kernel messages or whatsoever.

Odd. This does not occur without preemption enabled?

> Well it's a fpu patch, and as far as i know i don't use the fpu that much
> at the moment but i'll try that.

Its a patch for when the kernel uses the FPU, specifically during MMX or
3DNow instructions.  That is why iys for Athlon-optimized kernels,
because the Athlon uses 3DNow instructions for some fast page copies.

When the kernel uses FPU, it does not use SMP locks, since that is a per
CPU condition.  However, preemption can occur in the middle of a CPU
doing that stuff, and that messes stuff up very much.  The Athlon patch
fixes it, it is much needed if your kernel is Athlon-optimized.

Userspace FPU is controlled by the kernel already, so we don't need to
worry about that.  In userspace, the kernel handles everything ... in
kernel land, if we want to go play with something (like 3DNow), we need
to take care to set it up and restore ourselves properly.

> in the hope finding the usage of fpu-irq:
> sjoerd:/usr/src/linux # cat /proc/interrupts
>            CPU0
>   0:   13374740          XT-PIC  timer
>   1:      14581          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   9:     238018          XT-PIC  usb-uhci, usb-uhci, EMU10K1
>  10:     601500          XT-PIC  ide2, sym53c8xx
>  11:      87300          XT-PIC  eth0
>  12:     230338          XT-PIC  PS/2 Mouse
>  14:     331764          XT-PIC  ide0
>  15:      39468          XT-PIC  ide1
> NMI:          0
> ERR:          0
> 
> But /proc/interrupts shows only those irq's which are currently in use, is
> there any way to show usage of currenlty unused interrupts?

cat /proc/stat, see the `intr' line, each field is an increasing
interrupt value.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

