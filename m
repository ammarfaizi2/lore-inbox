Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTLROXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTLROXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:23:18 -0500
Received: from legolas.restena.lu ([158.64.1.34]:63618 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265176AbTLROWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:22:49 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Craig Bradney <cbradney@zip.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ross Dickson <ross@datscreative.com.au>, george@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl>
References: <200312180414.17925.ross@datscreative.com.au>
	 <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Message-Id: <1071757363.18749.42.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Dec 2003 15:22:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as an FYI, still going strong here with the old api and ioapic
patches. 5d 20h now.

When the official 2.6.0 comes to Gentoo Linux I can try that with
whatever patches people are finding stable for these nforce fixes.

Anyone had any luck in talking to ASUS re a BIOS update?

Craig

On Thu, 2003-12-18 at 15:04, Maciej W. Rozycki wrote:
> On Thu, 18 Dec 2003, Ross Dickson wrote:
> 
> > Here is where to find Intel's MP arch spec Maceij mentions.
> > I had to find it recently wrt nforce2 issues
> > 
> > http://www.intel.com/design/pentium/datashts/24201606.pdf
> > 
> > Section 3.6.1 Apic Architecture is relevant
> > particularly
> > Section 3.6.2.2 Virtual Wire Mode
> 
>  BTW, I have revision 1.1 as well in case anyone was interested in the 
> differences.
> 
> > I would like to add a footnote to highlight a potential gotcha as I
> > understand it.
> > 
> > To clarify, the xt pic 8259A does not in itself have a transparent mode
> > as would a logic buffer or inverter. It always needs inta cycles to
> > function. In PIC mode it is wired to processor pins as per old 8086 and
> > original cpu architecture provides the inta cycles to it (bypasses apic,
> > apic seems off).
> 
>  It does have such a mode. ;-)  You just have not to ack a pending
> interrupt -- if a request goes away, the INT output gets deasserted as
> well.  We are super cautious though and we reprogram the 8259A into the
> AEOI mode to prevent a lockup in case INTA cycles escape to the 8259A
> (which is theoretically possible for a broken design of an i82489DX-based
> system).  See the 8259A datasheet for details.
> 
> > I certainly agree with Marceij's comments that mixed mode of having 8254 PIT
> > routed via the 8259A was never meant to occur alongside ioapic handling of
> > the other interrupts. It is very problematic not to mention confusing. 
> 
>  Well, the true "mixed mode", i.e. where certain interrupts are delivered
> as I/O APIC (either LoPri or Fixed) interrupts and others are routed
> through an 8259A controller and delivered as ExtINTA interrupts was
> specifically designed to work since the i8248DX APIC.  What wasn't 
> designed but works by the properties of the 8259A PIC is the transparent
> "through-8259A" mode.
> 
>   Maciej

