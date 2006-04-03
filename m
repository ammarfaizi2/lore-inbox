Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWDCG4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWDCG4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 02:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWDCG4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 02:56:12 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:38089 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751558AbWDCG4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 02:56:11 -0400
Message-ID: <4430C6E5.20101@aitel.hist.no>
Date: Mon, 03 Apr 2006 08:55:33 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, beware <wimille@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr> <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com> <442C1415.6080906@cfl.rr.com>
In-Reply-To: <442C1415.6080906@cfl.rr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:

> linux-os (Dick Johnson) wrote:
>
>> No. Any file I/O, or anything that takes time sleeps and gives up
>> the CPU, ultimately calling schedule(). That means that anybody
>> can have its coprocessor state dorked. This has been discussed many
>
>
> The FPU state is saved across normal thread switches if either the new 
> or old thread uses the fpu, so this should be safe.  Unless this does 
> not apply to kernel threads?

Wrong.  The FPU state is saved if context is switched from one
userspace thread to another.  I don't know about kernel threads, but
be aware that lots of the kernel code is not executed in a kernel thread
context, so thread switching details doesn't matter at all.

Driver code is often executed in interrupt context.  Any thread can
be interrupted while doing floating-point work, and the floating
point registers are _not_ saved when an interrupt comes in. This
goes for all drivers - disk drivers, usb, serial, audio, video, ...
Drivers may then call all sorts of kernel functions, so the
cpu may have "hot" FPU registers when executing filesystem and VM
code and almost anything else too.

To further complicate this:  Your driver can save the FPU registers,
but it too may get interrupted. Possibly even by another instance of
itself, if the user have several devices.

>> If you divulge the mathematics you need calculated, I'll bet you
>> will get many answers from responders to the linux-kernel list.
>
Excellent advice.  This problem has been solved so many times already .

Helge Hafting
