Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUDIRgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUDIRgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:36:11 -0400
Received: from gizmo11bw.bigpond.com ([144.140.70.21]:7113 "HELO
	gizmo11bw.bigpond.com") by vger.kernel.org with SMTP
	id S261468AbUDIReU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:34:20 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: jgrimm2@us.ibm.com
Subject: Re: io_apic & timer_ack fix
Date: Sat, 10 Apr 2004 03:37:21 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, phil.el@wanadoo.fr
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404100337.21730.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2004 at 08:39 +0000, Jon Grimm wrote: 

> Hmmm.... 
 > 
 > I see that the following patch got pulled in by Andrew: 
 > http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/io_apic.c@1.85?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/kernel|hist/arch/i386/kernel/io_apic.c 
 > 
 > The patch had a couple bugs: 
 > http://seclists.org/lists/linux-kernel/2004/Mar/4152.html 
 > 
 > But the patch was pulled out entirely by Linus: 
 > http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/io_apic.c@1.88?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/kernel|hist/arch/i386/kernel/io_apic.c 
 > 
 > Was it determined that the fix was bogus? damaging? fixable? 
 
I thought the patch was OK with typos fixed.

> I ask as I see behavior identical for which this patch seems to have 
 > been originally carved up for (buggy SMM BIOS at fault, but this was a 
 > workaround in the OS). 
 > 
 > http://marc.theaimsgroup.com/?l=linux-kernel&m=101604672921823&w=2 
 > http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/0698.html 
 > 
 > Its a fair answer to force the BIOS vendor to fix, but in the meantime, 
 > I'm trying to figure out how safe/unsafe the workaround patch is ? 
 > I've ran on it overnight (with the semi-colon's fixed) and it hasn't 
 > exhibited the troubling behavior (where timer interrupts seem stuck or 
 > in some cases just extremely slow.... and the 8259 IMR is mucked up when 
 > Linux isn't even touching anymore). 

I read the thread you mention about the IMR muckup along the way to creating
my nforce2 patches - it was most enlightening as to how bad consumer computers
can be.

Prakash tracked his overheat to a buggy binary nvidia driver
http://marc.theaimsgroup.com/?l=linux-kernel&m=108059111721363&w=2
and not Maciej's patch.

Thomas was tracking down C1 C2 etc states but I do not know the results of
his search?
http://marc.theaimsgroup.com/?l=linux-kernel&m=107972277920929&w=2
Was it a problem only with one machine?

I do not recollect any other threads indicating problems with the patch.

I remember rediffing my nforce2 io-apic patch using the 2.6.3-mm3 kernel with
Maciej's patch and having no heat trouble. I am surprised it got pulled out but
then I only tested it on one type of chipset.

BTW I just rebooted to my modified 2.6.3-mm3 and got my normal 38C cpu.
I have to have timer_ack=0 in my io-apic timer routing patch for nforce2 to
get nmi_debug=1 to work. This was all along the way to trying to stop lockups.
In fact I have been running no timer_ack kernel mods since December on 4 
machines and all have been cool and hard lockup free.

Regards
Ross Dickson


 
