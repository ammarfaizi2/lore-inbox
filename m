Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTLMDxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 22:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTLMDxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 22:53:15 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:35085 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S263463AbTLMDxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 22:53:12 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: george@mvista.com
Subject: Re: Catching NForce2 lockup with NMI watchdog
Date: Sat, 13 Dec 2003 13:56:16 +1000
User-Agent: KMail/1.5.1
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312131356.16016.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Having had cause to try and figure out all this, I vote for the following being 
> included in the source somewhere... 
>-g 

Please consider adding

2c. Alternatively the OUT0 output of the 8254 PIT (IOW the timer source) may be 
directly connected to the INTIN0 input of the first I/O APIC. 

which we have found for nforce2 boards.
ref:

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2375.html

Ross Dickson


>bill davidsen wrote: 
> > In article <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>, 
> > Maciej W. Rozycki <macro@ds2.pg.gda.pl> wrote: 
> > 
> > | The I/O APIC NMI watchdog utilizes the property of being transparent to a 
> > | single IRQ source of a specially reconfigured 8259A PIC (the master one in 
> > | the IA32 PC architecture). There are more prerequisites that have to be 
> > | met and all indeed are for a 100% compatible PC as specified by the 
> > | Intel's Multiprocessor Specification. 
> > | 
> > | 1. The INT output of the master 8259A PIC has to be connected to the LINT0 
> > | (or LINTIN0; the name varies by implementations) inputs of all local APICs 
> > | in the system. 
> > | 
> > | 2a. The OUT0 output of the 8254 PIT (IOW the timer source) has to be 
> > | directly connected to the INTIN2 input of the first I/O APIC. 
> > | 
> > | 2b. Alternatively the INT output of the master 8259A PIC has to be 
> > | connected to the INTIN0 input of the first I/O APIC. 
> > | 
> > | 3. There must be no glue logic that would change logical properties of the 
> > | signal between the INT output of the master 8259A PIC and the respective 
> > | APIC interrupt inputs. 
> > | 
> > | In practice, assuming the MP IRQ routing information provided the BIOS has 
> > | been correct (which is not always the case), prerequisites #1 and #2 have 
> > | been met so far, but #3 has proved to be occasionally problematic. 
> > 
> > In practice many system seem to take a good bit of guessing and testing. 
> > I have an old P-II which only works with acpi=force and nmi_watchdog=2, 
> > for instance. 
> > 
> > It would be nice if there were a program which could poke at the 
> > hardware and suggest options which might work, as in eliminating the 
> > ones which can be determined not to work. Absent that trial and error 
> > rule, unfortunately. 
 
