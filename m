Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTINFyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 01:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTINFyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 01:54:12 -0400
Received: from fmr99.intel.com ([192.55.52.32]:63152 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262315AbTINFyD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 01:54:03 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][2.6.0-test4] Fix 'pci=noacpi' with buggy ACPI BIOSes
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Sun, 14 Sep 2003 01:53:57 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD7B@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6.0-test4] Fix 'pci=noacpi' with buggy ACPI BIOSes
Thread-Index: AcNq5H7Ouun/ErexSQuJgccZCY9qjQPnu5VA
From: "Brown, Len" <len.brown@intel.com>
To: "Thomas Schlichter" <schlicht@uni-mannheim.de>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Joonas Koivunen" <rzei@mbnet.fi>,
       "Peter Lieverdink" <cafuego@cc.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 14 Sep 2003 05:53:59.0192 (UTC) FILETIME=[9776C180:01C37A84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,
Thanks for the fix.
I took the liberty of dropping your note into
http://bugzilla.kernel.org/show_bug.cgi?id=1219 and we'll use that means
to track that the right fix gets into both 2.4 and 2.6.

Thanks,
-Len


> -----Original Message-----
> From: Thomas Schlichter [mailto:schlicht@uni-mannheim.de] 
> Sent: Monday, August 25, 2003 4:32 AM
> To: Andrew Morton
> Cc: LKML; Joonas Koivunen; Peter Lieverdink; Grover, Andrew
> Subject: [PATCH][2.6.0-test4] Fix 'pci=noacpi' with buggy ACPI BIOSes
> 
> 
> Hi Andrew,
> 
> the attached patch fixes interrupt routing probems for (at 
> least 3) people 
> with broken ACPI BIOSes. If only the ACPI interrupt routing 
> part is broken, 
> 'pci=noacpi' should help as the documantation states:
> 
> pci=option[,option...]
> 	[...]
> 	noacpi	[IA-32] Do not use ACPI for IRQ routing.
> 
> The problem was that ACPI interrupt routing was not correctly 
> disabled.
> The patch applies cleanly to 2.6.0-test4...
> 
>    Thomas
> 
> On Monday 25 August 2003 03:13, Peter Lieverdink wrote:
> > Hi Thomas,
> >
> > Your patch works beautifully. 'acpi=nopci' previously 
> caused IDE to work
> > fine, but made the kernel not detect USB and network 
> devices. With your
> > patch it sees all peripherals AND acpi is available for the 
> cpu. I wonder
> > if it would be accepted into the kernel as a patch to 
> workaround buggy acpi
> > bioses.
> >
> > Thanks heaps!
> >
> > - Peter.
> > --
> >
> > At 23:44 24/08/2003 +0200, you wrote:
> > >Am Sunday 24 August 2003 22:54 schrieb David van Hoose:
> > > > Kevin P. Fleming wrote:
> > > > > Peter Lieverdink wrote:
> > > > >> When I enable ACPI on 2.6.0-test4 (also on 
> 2.6.0-test3-*), the
> > > > >> kernel no longer recognises my IDE controller and 
> drops down to PIO
> > > > >> mode for harddisk access. Additionally, USB devices don't get
> > > > >> detected.
> > > > >
> > > > > I'm running -test4 here with ACPI and have no trouble with USB
> > > > > devices.
> > > >
> > > > I'm running test4 here with ACPI and have no USB 
> following a call trace
> > > > with "IRQ 20: nobody cared". ACPI seems to make odd 
> reports. I've been
> > > > having this problem since 2.5.70'ish. Posted numerous 
> times, but nobody
> > > > seems to care about it. I also have a PS/2 mouse 
> detection when I have
> > > > no mice attached to my system.
> > > >
> > > > >> The system is an Athlon 2400+ on a Gibabyte GA-7VAXP 
> mainboard.
> > > > >> (KT400)
> > > > >
> > > > > My system is an Athlon 1000 on an MSI KT266-based board.
> > > >
> > > > I have a Pentium 4 2.53 GHz on a Asus P4S8X mainboard.
> > > >
> > > > -David
> > > >
> > > > PS. dmesg is attached with ACPI debug and USB debug enabled.
> > >
> > >I had similar problems with my Epox 8K9A (KT400) Board.
> > >
> > >If I wanted to use my USB ports I had to boot wiht 
> 'acpi=off'. But with
> > > the patch attached it is possible for me to boot with 
> 'pci=noacpi'. It
> > > has the advantage that ACPI stays enabled...
> > >
> > >You are free to give it a try...
> > >
> > >   Thomas
> 
> On Sunday 10 August 2003 01:24, Joonas Koivunen:
> > On Saturday 09 August 2003 19:02, Thomas Schlichter wrote:
> > > It's not a problem with ACPI, it's more a problem with 
> the interrupt
> > > routing based on the ACPI tables. These tables seem to be 
> not correctly
> > > implemented in the BIOS and, as the german EPOX support 
> admits, are not
> > > really tested. To change this you may contact the EPOX support and
> > > describe your problems, too....
> >
> > Thanks for letting me know.. I had a image of EPOX being 
> pretty good with
> > motherboards.. Guess not then.
> >
> > > If you want to use ACPI while this BIOS bug is not fixed 
> you may use the
> > > attached patch and boot with pci=noacpi. Without the 
> patch this doesn't
> > > work for me here...
> >
> > Why isn't this patch in the mainstream kernel? There are many other
> > chipset/bios fixes in the kernel.. This would save many
> > reboot/recompilings/worries until or if ever epox does 
> something with the
> > bios.
> >
> > The patch works nicely. Though I did apply it manually to 
> -test3 :) But it
> > works.
> >
> > > Best regards
> > >   Thomas Schlichter
> >
> > Thanks again
> > -rzei
> 
