Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129772AbQLEUMW>; Tue, 5 Dec 2000 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQLEUMM>; Tue, 5 Dec 2000 15:12:12 -0500
Received: from SMTP.SLAC.Stanford.EDU ([134.79.18.80]:455 "EHLO
	smtp.SLAC.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S129678AbQLEUL7>; Tue, 5 Dec 2000 15:11:59 -0500
Date: Tue, 05 Dec 2000 11:41:18 -0800
From: Till Straumann <strauman@SLAC.Stanford.EDU>
Subject: Re: Motorola DigitalDNA Help,
 Service Request # 1-1H8Q6 Follow - MPC8xx not setting DAR when DCBZ faults
To: DigitalDNA Help <DigitalDNA.Help@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org, linux-kernel@vger.kernel.org
Message-id: <3A2D44DE.3EA01C6B@slac.stanford.edu>
Organization: SSRL (Stanford Synchrotron Radiation Laboratory)
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <39F56211.A2470D18@tcfc.tornado.nsk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Motorola DigitalDNA Help wrote:

> Dear Till Strauamnn,
>
> in reply to your Service Request SR 1-1H8Q6 (see details below):
>
> You are right. We've tested your code. It behaves the same way with
> other 860 parts.
> Let us know if this feature creates a problem for you and we'll try to
> find a solution (if it's possible).

Sorry for coming back to this late. I am working on different projects and
some high priority tasks eat up my time...

First of all, it seems that we disagree a little bit on the impact this problem
has. I discovered it running RT-Linux.

Not setting DAR when an address is not found in the TLB as it happens
on the MPC860 with the dcbz (& similar) instructions means that
you must not use these instructions on any system that does not keep all
of its address mappings in the TLBs permanently, because there is no way
for the TLB replacement algorithm to figure out the fault address.

Most of the PowerPC cache manipulation instructions are executable in
user mode, i.e. they may be present in any program / library that is ported
to MPC860. On linux, executing such a program may occasionally cause it to
mysteriously "segfault". Portions of the LINUX kernel are also affected.

If need more pages of memory than there are TLBs in the 860, I have to
scan all the software I intend to use on this machine for the cache instructions
and eliminate them (with some impact on performance, of course).

Me (and I'm sure there are many others affected by this problem although
they might not know it - after all, it was pretty hard to track down, for me too)
would certainly apreciate you to try to figure out a solution.

Regards, Till Straumann.

PS: cc questions/replies to me, as I am not on the mailing lists.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
