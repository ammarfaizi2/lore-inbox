Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTLOQzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTLOQzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:55:32 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:65284 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S263823AbTLOQzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:55:17 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Craig Bradney <cbradney@zip.com.au>
Subject: Re: Fwd: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Tue, 16 Dec 2003 02:54:45 +1000
User-Agent: KMail/1.5.1
Cc: recbo@nishanet.com, linux-kernel@vger.kernel.org,
       Ian Kumlien <pomac@vapor.com>
References: <200312160030.30511.ross@datscreative.com.au> <1071500545.6680.15.camel@athlonxp.bradney.info>
In-Reply-To: <1071500545.6680.15.camel@athlonxp.bradney.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312160254.45150.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 December 2003 01:02, you wrote:
> Just to give the status here ...
> Im still running the original 2.6 test 11 patches for apic and ioapic.
> Uptime is now 2d 20h with lots of idle time and hard work too.. 
> 
> /proc/interrupts as follows:
> 
>            CPU0
>   0:  245382420    IO-APIC-edge  timer
>   1:     139577    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          3    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:    1478615    IO-APIC-edge  i8042
>  14:    1055548    IO-APIC-edge  ide0
>  15:     737664    IO-APIC-edge  ide1
>  19:   18405692   IO-APIC-level  radeon@PCI:3:0:0
>  21:    5257090   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
>  22:          3   IO-APIC-level  ohci1394
> NMI:      14944
> LOC:  245087891
> ERR:          0
> MIS:          6

Uptime sounds good so far.
 
I am not convinced my v2 apic patch is a great overall improvement, I am 
thinking v1 apic, is safer for now. 

Having said that
Ian Kumlien currently has an uptime of
1 day, 15 hours +
on v2 patches but with the apic delay timeout increased from 600UL to 800UL.
He has a Barton core - see below.

> 
> Craig
> A7N8X Deluxe V2 BIOS 1007
> 
> 
<snip>

> > I am currently trying the simpler v1 (always add a delay) patch but on all apic
> > acks as per this posting
> > 
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/3291.html
> > 
> > which is a reply to an earlier posting of the same name but I accidently 
> > omitted the Re in the subject.
> > 

I don't think it is necessary to put the delay in all apic acks - I just tried it 
to see if it worked and have not yet put my code back the way it was. 
My hard lockups went away with the original v1 apic 
timer delay patch anyway.

Please note in that (above) posting I write that I stuffed up the #ifdefs
in my v1 and v2 patches and adjust code accordingly. Patches worked 
but were only testing on the first config item after #ifdef

apic code should have had
#if defined(CONFIG_MK7) && defined(CONFIG_BLK_DEV_AMD74XX)

ioapic code should have had
#if defined(CONFIG_ACPI_BOOT) && defined(CONFIG_X86_UP_IOAPIC)

Brief summary at this point

1) 2? reports are in that latest award bios with "C1 disconnect" set to "auto?"
 may remove need for apic ack delay patch and still keep cpu thermo managed

2) apic ack delay v1 patch seems safe for all cpu cores but introduces a small
 delay of about half the time of an XTPIC access on each apic timer interrupt
	
3) apic ack delay v2 patch seems safe only on barton cores and gives more debugging
 info and wastes less time than apic v1 patch

4) io-apic v2 patch gives more debugging info but functions same as io-apic v1 patch

Regards
Ross

