Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVFTHD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVFTHD2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFTHD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:03:28 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:45237 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261471AbVFTHDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:03:02 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Mon, 20 Jun 2005 09:01:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Message-ID: <42B685E8.9359.14B98F19@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0506181344000.3743@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=103979@20050620.065557Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2005 at 14:02, Roman Zippel wrote:

> Hi,
> 
> On Fri, 17 Jun 2005, john stultz wrote:
> 
> > o Uses nanoseconds as the kernel's base time unit
> 
> Maybe I missed it, but was there ever a conclusive discussion about the 
> perfomance impact this has?
> I see lots of new u64 variables. I'm especially interested how this code 
> scales down to small and slow machines, where such a precision is absolute 
> overkill. How do these patches change current and possibly common time 
> operations?

Hi all!

I had the impression that for slow and small machines every recent Linux 
distribution is overkill. Whenever I complained every relied "Harddisks are cheap, 
memory is cheap, get a new CPU". I do understand your doubts however. For my 
personal experience with my PPSkit patches, I found out that my ols 386/SX @16MHz 
failed to receive all serial characters when I timestamped each of them using my 
new clock routines. However a 486@33MHz would do (it had better serial UART chips, 
too). I would not thing my code was terribly efficient, because I tried to make it 
"right" first.

And even the 386 had limited support for 64 bit operations. Since the 486 a 32bit 
add is specified as using 1 CPU cycle (most likely in the optimal case). So doing 
one more would not harm that much.

Basically, either the new clock system has to be optional (a maintenance nightmare 
most likely), or you'll have to require a specific amount of performance for the 
latest software. If you cannot fulfill the requirements, you'll have to stick with 
an older release of the software.

Maybe let's try to make it as good (correct and efficient (and understandable) as 
good as we can.

Regards,
Ulrich

