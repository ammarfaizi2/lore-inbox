Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTKRWls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTKRWls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 17:41:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31107 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263808AbTKRWlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 17:41:45 -0500
Date: Tue, 18 Nov 2003 17:44:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: kernwek jalsl <edityacomm@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: softirqd
In-Reply-To: <16314.39961.545212.446223@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.53.0311181736170.17786@chaos>
References: <Pine.LNX.4.53.0311170914580.22131@chaos>
 <20031118063551.25057.qmail@web20710.mail.yahoo.com>
 <16314.39961.545212.446223@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003, Peter Chubb wrote:

>
>
>
> Kernwek Jalsl said:
>
> Kernwek> Sorry in case I was not very clear with my
> Kernwek> requirements.   With real time interrupt I meant a
> Kernwek> real time task waiting for IO from this interrupt.
> Kernwek> Assume that I have a high priority interrupt and a
> Kernwek> real time task waiting for it. Well followimg are the
> Kernwek> various latencies involved:
> Kernwek> L1- interrupt latency
> Kernwek> L2- hard and soft IRQ completion
> Kernwek> L3 - scheduler latency
> Kernwek> L4 - scheduler completion
>
> Kernwek> L1 is pretty acceptable on Linux.
>
> I've been trying to measure this.  On IA64 I'm measuring around
> 2.5microseconds (on a 900MHz machine).  I personally think that this
> is too big, and could be reduced.


I have a driver which, upon getting an IRQ7 (printer-port interrupt),
just reads the 'paper-out' bit and writes the result to the data-port.
This allows me to toggle the bit and measure the time using a 'scope
and a function generator. The complete time for everything is about
900 nanoseconds on this machine:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.568
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 399.568
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 797.90


I have to disconnect the network before making the test because
the network driver will hog too much CPU time handling broadcast
messages to make any useful measurments.

Considering that it takes 150 to 200 ns to read/write the printer-
port, I don't think that's too bad.


[SNIPPED...]



Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


