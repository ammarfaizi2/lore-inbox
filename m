Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSL0XYB>; Fri, 27 Dec 2002 18:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbSL0XYB>; Fri, 27 Dec 2002 18:24:01 -0500
Received: from m68-mp1.cvx3-a.ren.dial.ntli.net ([213.104.120.68]:56311 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265276AbSL0XYA>; Fri, 27 Dec 2002 18:24:00 -0500
Subject: RE: CPU failures ... or something else ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: "'Josh Brooks'" <user@mail.econolodgetulsa.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001b01c2aca4$7f69a840$b9293a41@joe>
References: <001b01c2aca4$7f69a840$b9293a41@joe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Dec 2002 23:30:54 +0000
Message-Id: <1041031854.1128.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-26 at 06:03, Joseph D. Wagner wrote:
> > Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> > localhost kernel: Kernel panic: CPU context corrupt
> 
> What that basically means is that given some values A, B, and C, in the
> context of those values the kernel expects X, Y, and Z to be of some other
> value, but X, Y, and Z aren't turning out to be expected.

Ermm no.

Lets correct a few comments made here

1.  On Pentium II/III we have no known cases where MCE is misreported.
(Some old pentiums dont have the external bits of the MCA/MCE stuff
wired up  right so do trigger it). Radeon IGP also triggers it but for
what appear to be valid reasons (Linux confused the chipset badly)

2.  The panic occurs because the CPU set flags saying that the CPU state
was corrupt. That is it trapped out at a point where the previous state
could not be recovered, so the trap is fatal

3.  Don't be suprised if it moves CPU. It is possible (and not uncommon)
to set up dual systems so that both CPU's boot and race to become CPU#0.
This is actually recommended since the box will then almost always boot
with one failed CPU.

Running each CPU as a single CPU test may find a faulty CPU.


