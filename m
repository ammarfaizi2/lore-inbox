Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130807AbQKQMju>; Fri, 17 Nov 2000 07:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131659AbQKQMjk>; Fri, 17 Nov 2000 07:39:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130807AbQKQMjg>; Fri, 17 Nov 2000 07:39:36 -0500
Subject: Re: Error in x86 CPU capabilities starting with test5/6
To: tigran@veritas.com (Tigran Aivazian)
Date: Fri, 17 Nov 2000 12:10:07 +0000 (GMT)
Cc: mikpe@csd.uu.se (Mikael Pettersson), ledzep37@home.com (Jordan),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.21.0011171154250.8176-100000@saturn.homenet> from "Tigran Aivazian" at Nov 17, 2000 11:58:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wkLK-0000bP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You have a user-space program which parses /proc/cpuinfo instead of
> > executing CPUID itself, so it breaks.
> 
> Arguably, it is always better to parse /proc/cpuinfo instead of executing

Actually this is definitively the case. 

It is not safe to use cpuid to check the availability of RDTSC in Linux because
the CPU itself does not know if the TSC is buggy (Some MediaGX, some WinChip,..)
or if the TSC on an SMP box is constant across all processors.

Even checking the cpuinfo for the TSC should be done with care, and its far
far better to use gettimeofday unless doing very tiny timings (eg for 
optimising code paths)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
