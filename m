Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293277AbSCOVVx>; Fri, 15 Mar 2002 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293283AbSCOVVm>; Fri, 15 Mar 2002 16:21:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48400 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293277AbSCOVVh>; Fri, 15 Mar 2002 16:21:37 -0500
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 15 Mar 2002 21:37:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a6tm95$c55$1@cesium.transmeta.com> from "H. Peter Anvin" at Mar 15, 2002 12:41:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lzO6-0004iZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > documentation on the ISA bus which covers the timeout for acknowledging an
> > address cycle. Otherwise for tsc capable boxes I agree entirely.
> > 
> The ISA bus doesn't time out; a cycle on the ISA bus just happens, and
> the fact that noone is there to listen doesn't seem to matter.

Not so simple. I found my IEEE draft 8)

The address out comes from the chipset (southbridge now days). The
sequence is

	BALE high
	Output address
	BALE low
	Set IORC/IOWC etc

	Wait for NOWS while watching IOCHRDY

	NOWS low says - card now ready
	IOCHRDY high suppresses the wait state timer count

The default timeout is 4 wait states, which is 6 bus clocks for a failure
Maybe 7 - Im not clear if the final cycle to recover and start again is
always there. 
	
> The delay is something like 8 cycles @ 8.3 MHz or around 1 ms.

1uS ?

Alan
