Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284831AbSADUUm>; Fri, 4 Jan 2002 15:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284755AbSADUUd>; Fri, 4 Jan 2002 15:20:33 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:30217 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S284728AbSADUUY>; Fri, 4 Jan 2002 15:20:24 -0500
Date: Fri, 4 Jan 2002 21:20:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104212017.B22908@suse.cz>
In-Reply-To: <20020103133454.A17280@suse.cz> <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl> <20020104200410.E21887@suse.cz> <20020104140538.A19746@thyrsus.com> <20020104202151.A22445@suse.cz> <20020104144146.A20097@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104144146.A20097@thyrsus.com>; from esr@thyrsus.com on Fri, Jan 04, 2002 at 02:41:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 02:41:46PM -0500, Eric S. Raymond wrote:

> Vojtech Pavlik <vojtech@suse.cz>:
> > You'll have to add motherboards that have no ISA slots, but onboard ISA
> > devices to the list.
> >
> > I'd suggest looking at the output of /proc/bus/isapnp as well, because
> > if it lists any devices, you certainly need ISA support. 
> 
> OK, apparently some people are still confused about what I'm trying to do.
> That's no surprise.  It confuses *me* sometimes!

I think I understand you. The problem is that many ISA chips (sound,
others) that are normally used on ISA cards, and thus handled by drivers
most likely labeled by the ISA_CARDS flag, can be, and were often
integrated onto mainboards, even if those didn't have any ISA slots.

Think (possibly older generation, like P-MMX based) notebooks ... there
you can have

X86 ... true
PCI ... true
DMI ... true
DMI_ISA ... false
BLACKLISTED ... possibly true, if you blacklist most notebooks

and yet have many ISA drivers needed for proper operation of the
machine.

> 
> The issue is not ISA support, it is ISA *card* support.  At the moment,
> and for the foreseeable future, X86 implies ISA.  Someday there may be
> X86 motherboards without on-board ISA devices, but that's a few years off.
> When that does happen, my logic will be something like this, where 
> PCI_BRIDGE is the test for whether PC reports an ISA bridge.
> 
> X86 and ((PCI and ISA_BRIDGE) or not PCI) => ISA
> 
> The "not PCI" case represents old ISA-only machines.  
> 
> What I'm actually trying to do is determine whether the machine can 
> take ISA *cards*, and use that computation to suppress questions about
> ISA cards (probed ones would still be found).  For this, the logic
> should look as follows, where:
> 
> * DMI means "reports DMI"
> * DMI_ISA means "DMI reports ISA slots"
> * BLACKLISTED means the motherboard is in an exception list of PCI-supporting,
>        DMI-supporting motherboards that falsely claim not to have ISA slots.
> 
> X86 and ((not PCI) or (not DMI) or DMI_ISA or BLACKLISTED => ISA_CARDS
> 
> This is one reason I want /sys/dmi -- because if I *don't* see it, that
> means I should assume the machine is old enough to take ISA cards.  This
> filter should make the blacklist relatively small -- we wouldn't have to
> track even PCI motherboards older than the DMI standard.
> 
> A key point is that as ISA phases out (near future now), the blacklist 
> will stop growing.  Ballpark guess is it will top out below 150 entries.
> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> 
> If I were to select a jack-booted group of fascists who are 
> perhaps as large a danger to American society as I could pick today,
> I would pick BATF [the Bureau of Alcohol, Tobacco, and Firearms].
>         -- U.S. Representative John Dingell, 1980

-- 
Vojtech Pavlik
SuSE Labs
