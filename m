Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbSLPDof>; Sun, 15 Dec 2002 22:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSLPDof>; Sun, 15 Dec 2002 22:44:35 -0500
Received: from mrmorr.lnk.telstra.net ([139.130.12.153]:48901 "EHLO
	cheesypoof.guarana.org") by vger.kernel.org with ESMTP
	id <S264910AbSLPDoe>; Sun, 15 Dec 2002 22:44:34 -0500
Date: Mon, 16 Dec 2002 14:52:26 +1100
To: Keith Owens <kaos@ocs.com.au>
Cc: Kevin Easton <kevin@sylandro.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 st + aic7xxx (Adaptec 19160B) + VIA KT333 repeatable freeze
Message-ID: <20021216035226.GA30613@guarana.org>
References: <20021213115127.A12153@beernut.flames.org.au> <1047.1039952560@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047.1039952560@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
From: caf@guarana.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 10:42:40PM +1100, Keith Owens wrote:
> On Fri, 13 Dec 2002 11:51:27 +1100, 
> Kevin Easton <kevin@sylandro.com> wrote:
> >I'm not sure exactly where this problem fits in, but I'm getting a 
> >completely repeatable freeze (100% lockup, no response to keyboard)
> >triggered by writing to /dev/st0 (dd if=/dev/urandom of=/dev/st0 bs=512
> >count=163840 will reproduce it).
> >So... does anyone have any ideas how I should start trying to track this
> >down?
> 
> Boot with nmi_watchdog=1 (smp) or nmi_watchdog=2 (smp or up), cat
> /proc/interrupts to verify that NMI is being used.  If the problem is a
> disabled spinloop then the watchdog will trip after 5 seconds and give
> you a trace which can be run through ksymoops.  If that trace does not
> give enough data to debug the problem, apply the kdb patch[*], read
> Documentation/kdb and start digging, bt first and debug from there.

Running with nmi_watchdog=2 has made the problem a bit harder to
reproduce[1], but when it does hang it doesn't produce a trace (I left it
for several minutes just in case..).  Checking /proc/interrupts after 
boot shows around 16 NMIs, which I presume means that it's being used? -
although it didn't seem to be going up at anything like once every 5
seconds.

Is it possible that I'm not seeing the trace because I'm using a VGA
virtual console rather than a real serial console?

	- Kevin.

[1] actually, on second thoughts I think this is due to the fact that
when I was previously producing the problem, there was an md resync
operation happening (from a previous crash :).  After leaving it over
the weekend the disks were idle - I couldn't get the problem back until
I attempted a backup of a particular file which seems to frequently
cause this problem.


