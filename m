Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261212AbREMPy5>; Sun, 13 May 2001 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbREMPyr>; Sun, 13 May 2001 11:54:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25900 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261212AbREMPyj>; Sun, 13 May 2001 11:54:39 -0400
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Edward Spidre <beamz_owl@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <Pine.GSO.3.96.1010508174820.26399A-100000@delta.ds2.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 May 2001 09:45:10 -0600
In-Reply-To: "Maciej W. Rozycki"'s message of "Tue, 8 May 2001 18:01:12 +0200 (MET DST)"
Message-ID: <m1g0eele61.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> On 4 May 2001, Eric W. Biederman wrote:
> 
> > The example that sticks out in my head is we rely on the MP table to
> > tell us if the local apic is in pic_mode or in virtual wire mode.
> > When all we really have to do is ask it.
> 
>  You can't.  IMCR is write-only and may involve chipset-specific
> side-effects.  Then even if IMCR exists, a system's firmware might have
> chosen the virtual wire mode for whatever reason (e.g. broken hardware). 

Admittedly you can't detect directly detect IMCR state.  But
triggering an interrupt on the bootstrap processor local apic, and
failing to receive it should be proof the IMCR is at work.
Alternatively if I'm wrong about the wiring disabling all interrupts
at the apic level and receiving one is a second proof that IMCR is at
work.  Further I don't think a processor with an onboard apic, works
with an IMCR register. 

What I was thinking of earlier is that you can detect an apic or
ioapic in virtual wire mode, which the current code and the intel MP
spec treats as the opposite possibility.

Eric



