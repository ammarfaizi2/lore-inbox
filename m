Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbTLSEGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 23:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbTLSEGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 23:06:46 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:22800 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265443AbTLSEGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 23:06:43 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Catching NForce2 lockup with NMI watchdog
Date: Fri, 19 Dec 2003 14:06:03 +1000
User-Agent: KMail/1.5.1
Cc: george@mvista.com, linux-kernel@vger.kernel.org
References: <200312180414.17925.ross@datscreative.com.au> <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312191406.03383.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 00:04, Maciej W. Rozycki wrote:
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

Yes please if it is forwardable or downloadable.

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

I believe what you have written because you say it is how the code works.

I take it you mean that the INT is either never latched? or only latched with IS bit
after receipt of first INTA?

It is not obvious in 8259A Datasheet published in Intel Microsystem Components
Handbook Volume 1 1983 nor in datasheet December 1988.

I note the data sheet is almost silent on the topic of INT behaviour without
INTA cycle.

Almost, as the WAVEFORMS diagrams which have INT displayed only
show it in conjunction with the INTA and under said diagram I read

NOTES: Interrupt output must remain HIGH at least until leading edge of first 
INTA.
implying it can go low for some reason?

And the,
1. Cycle 1 in iAPX 86 , ....
Only indicates its trailing edge is synchrouous with the machine cycle.

Figure 10 in the data sheet does not help either as when the IR goes low it has
a LATCH* ARMED notation which I took to mean the INT output was then 
latched.
 
I now think it was referring to the transparent D type latch "REQUEST LATCH"
in the priority cell diagram but I cannot see a footnote to the *.

Could you please point me to the document where it is made clear? It may be
in the i82489DX docs as I do not have them or in a later 8259A data sheet
revision?

Thanks,
Ross.

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

Clarified thanks.

> 
>   Maciej
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> 
> 

