Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUCLG2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 01:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUCLG2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 01:28:12 -0500
Received: from fmr10.intel.com ([192.55.52.30]:16267 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S261955AbUCLG2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 01:28:06 -0500
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x /
	Crash/Freeze
From: Len Brown <len.brown@intel.com>
To: Richard Browning <richard@redline.org.uk>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
In-Reply-To: <200403120042.32166.richard@redline.org.uk>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com>
	 <200403120022.13534.richard@redline.org.uk>
	 <Pine.LNX.4.58.0403111932400.29087@montezuma.fsmlabs.com>
	 <200403120042.32166.richard@redline.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1079072878.3885.33.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Mar 2004 01:27:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 19:42, Richard Browning wrote:
> On Friday 12 March 2004 00:36, Zwane Mwaikambo wrote:
> > On Fri, 12 Mar 2004, Richard Browning wrote:
> > > > For my own curiosity, does switching the processors around do anything?
> > > > Those MCEs look confined to the non bootstrap processor package.
> > >
> > > Switched CPUs. This time I get the following:
> > >
> > > CPU3: Machine Check Exception: 000.0004
> > > CPU2: Machine Check Exception: 000.0004
> > > Bank 0: a20000008c010400
> > > Kernel Panic: CPU context corrupt
> > > In idle task - not syncing
> > >
> > > Note that the CPU# designations are swapped and that there's only one
> > > Bank 0: message. Is this significant?
> >
> > Ok, but that's still on the same package so it's not moving with the
> > processor, thanks. Could you also supply processor info from
> > /proc/cpuinfo.
> 
> I suppose that's good (for me); indicates no hardware error?

MCE == hardware error.
In this case un-recoverable.

I'll take a swing at decoding this, call the Coast Guard if I don't
return in 30 minutes;-)

http://developer.intel.com/design/pentium4/manuals/25366813.pdf

> Machine Check Exception: 000.0004

fig 14-4 says this means that indeed, you have a valid MCE.

> Bank 0: a20000008c010400

fig 14-6 says:
63: valid register contents
61: UC -- processor did not correct the error
57: PCC -- Processor context corrupt (you're dead)

0400 is the MCA error code

fig E2 says
10 - internal watchdog timeout.
26,27 -- TT -- Thread timeout indicator -- both threads timed out

> /proc/cpuinfo of course:
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2

I have no idea what causes this error, but it sure sounds specific to
the processor, and specific to HT -- which matches your experiments. 
I'd imagine that after you verify that you've got the latest BIOS for
the board and the error persists that you should look into getting that
specific processor replaced.

cheers,
-Len



