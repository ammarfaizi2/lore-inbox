Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUC3AzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUC3AzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:55:15 -0500
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:24029 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S263338AbUC3AzF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:55:05 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Tue, 30 Mar 2004 10:57:37 +1000
User-Agent: KMail/1.5.1
Cc: Len Brown <len.brown@intel.com>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       linux-kernel@vger.kernel.org
References: <200403181019.02636.ross@datscreative.com.au> <405C1C0D.9050108@gmx.de> <4068803B.5010208@gmx.de>
In-Reply-To: <4068803B.5010208@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403301057.37177.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 05:59, Prakash K. Cheemplavam wrote:
> Prakash K. Cheemplavam wrote:
> > Ross Dickson wrote:
> > 
> >> On Saturday 20 March 2004 19:29, Prakash K. Cheemplavam wrote:
> >>
> >>> Len Brown wrote:
> >>>
> >>>> On Fri, 2004-03-19 at 14:22, Prakash K. Cheemplavam wrote:
> >>>>
> >>>>
> >>>>
> >>>>> Hmm, I just did a cat /proc/acpi/processor/CPU0/power:
> >>>>> active state:            C1
> >>>>> default state:           C1
> >>>>> bus master activity:     00000000
> >>>>> states:
> >>>>>   *C1:                  promotion[--] demotion[--] latency[000] 
> >>>>> usage[00000000]
> >>>>>    C2:                  <not supported>
> >>>>>    C3:                  <not supported>
> >>>>>
> >>>>> I am currently NOT using APIC mode (nforce2, as well) and using 
> >>>>> vanilla 2.6.4. It seems C1 halt state isn't used, which exlains why 
> >>>>> I am having 
> >>>
> >>>
> >>> [snip]
> >>>
> >>>>
> >>>> Actually I think it is that we don't _count_ C1 usage.
> >>>
> >>>
> >>> Hmm, OK, then I am really puzzled what specifically about mm sources 
> >>> make my idle temps hotter, as I still couldn't properly resolve it 
> >>> what is causing it. I thought ACPI, but no, using APM only does the 
> >>> same (apm only with vanilla is low temp though.)
> >>
> >>
> >>
> >> Have you seen this thread, it may be relevant?
> >> Re: [2.6.4-rc2] bogus semicolon behind if()
> >> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4170.html
> > 
> > 
> 
> So, I seem to have found the bugger causing higher temps: It is NVidia 
> binary driver, or rather its AGP part of the 53.36 driver. Using AGPGART 
> and Nvidia driver leaves my system cool. Using NVAGP it seems as though 
> C1 state isn't actually used anymore thus making the CPU hotter.

Hmmm.
Would you happen to have a copy of athcool handy - it would be interesting to
see the northbridge disconnect bit status - if its been turned off by their driver?

> 
> Tested with (and without) ACPI and APIC (and Ross' tack patch). 
> Currently running in PIC mode (with ACPI) and idle temp of 44°C (instead 
> of about 50°C...). But it was as cool in APIC mode.
> 
> Of course I have to test few more days, but at least currently I am 
> happy again. :-)
> 
> Prakash
> 
> 
> 

