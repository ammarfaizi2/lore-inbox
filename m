Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288083AbSAQCAj>; Wed, 16 Jan 2002 21:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288086AbSAQCAU>; Wed, 16 Jan 2002 21:00:20 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:54402
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288083AbSAQCAS>; Wed, 16 Jan 2002 21:00:18 -0500
Date: Wed, 16 Jan 2002 20:43:45 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020116204345.A22055@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020116164758.F12306@thyrsus.com> <esr@thyrsus.com> <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de> <20020116164758.F12306@thyrsus.com> <26592.1011230762@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <26592.1011230762@redhat.com>; from dwmw2@infradead.org on Thu, Jan 17, 2002 at 01:26:02AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> I'm concerned by the 'platform- and bus-type guards' to which you refer. 
> Could you give some examples where the behaviour has changed? Lots of 
> embedded non-x86, non-ISA boxen have ISA network chips glued in somehow, 
> for example. I hope you haven't helpfully stopped that from working.

No, I haven't.

Wha's happened is that I, and others, have merged in a lot of information 
about what cards can be plugged into which platforms.  That information
has been turned into dependency/visibility rules.

The generic hardware that can be used on several platforms has bus guards.
The on-board hardware has platform guards.  Some cards that can only be used
in single-platform buses have platform guards as well.

Here are some examples from the network cards...

Bus guards:

unless MCA suppress dependent ELMC ELMC_II ULTRAMCA SKMC NE2_MCA IBMLANA
unless ISA_CLASSIC suppress EL1 EL2 ELPLUS EL16 WD80x3 APOLLO_ELPLUS unless ISA_PNP suppress CONFIG_3C515 
unless EISA suppress dependent LNE390 NE3210
unless ISA_CLASSIC or EISA suppress AC3200
unless ISA_CLASSIC or ISA_PNP!=n or EISA or MCA suppress EL3	# 3c509 source
unless EISA or PCI or CARDBUS!=n suppress VORTEX	# Vortex help screen
unless ISA_CLASSIC or ISA_PNP!=n or PCI suppress LANCE		# Lance source
unless SPARC or SPARC64 suppress SUNLANCE
unless EISA suppress dependent ULTRA32                      	# SMC-ULTRA32
unless PCI suppress dependent 
	PCNET32 DE2104X TULIP EEPRO100 NE2K_PCI CONFIG_8139TOO CONFIG_8139TOO_8129 
	WINBOND_840 HAPPYMEAL ADAPTEC_STARFIRE FEALNX NATSEMI VIA_RHINE EPIC100
	SUNDANCE
unless ISA_CLASSIC suppress dependent NI52 NI65
unless EISA or PCI suppress DE4X5 DGRS DM9102 TLAN
unless ISA_CLASSIC or EISA or MCA suppress DEPCA	#depca.c
unless ISA_CLASSIC or EISA or MCA suppress HP100
unless ISA_CLASSIC or MCA suppress AT1700               #at1700.c
unless ISA_CLASSIC suppress dependent NI5010			#ni5010.c
unless ISA_CLASSIC suppress dependent E2100 EWRK3 EEXPRESS EEXPRESS_PRO FMV18X 
	HPLAN HPLAN_PLUS ETH16I SEEQ8005 SK_G16 ES3210 APRICOT
unless ISA_CLASSIC or ISA_PNP suppress NE2000 
unless ISA_PNP suppress ULTRA
unless ISA_PNP or CARDBUS suppress I82365

Platform guards:

unless SGI_IP27 or IA64_SGI_SN1 suppress SGI_IOC3_ETH
unless X86 suppress dependent ATP
unless X86 or ALPHA or PPC suppress NET_VENDOR_3COM 
unless X86 or ALPHA suppress LANCE NET_VENDOR_SMC NET_VENDOR_RACAL 
unless SPARC suppress dependent HAPPYMEAL SUNBMAC SUNQE
unless DECSTATION suppress dependent DECLANCE
unless BAGET_MIPS suppress dependent BAGETLANCE
unless (CONFIG_8xx or CONFIG_8260) suppress SCC_ENET FEC_ENET ENET_BIG_BUFFERS
unless AMIGA and PCMCIA!=n suppress dependent APNE
unless APOLLO suppress dependent APOLLO_ELPLUS
unless MAC suppress dependent MAC8390 MACSONIC SMC9194 MAC89x0 MACMACE CS89x0 
unless ATARI suppress dependent ATARILANCE
unless SUN3X or SPARC suppress SUN3LANCE
unless SUN3 suppress dependent SUN3_82586
unless HP300 suppress dependent HPLANCE
unless SUPERH suppress dependent STNIC

Compound bus *and* platform guard:

unless (X86 or ALPHA) and PARPORT!=n suppress dependent NET_POCKET

In a typical situation, you're going to enable platform and bus
symbols early.  All these guards will drastically filter the questions
you have to answer later.  The overall objective is to reduce the
questions a human user asks to those strictly relevant to his or her
configuration.

Now we're closing in on the second-stage objective, which is to automatically
discover (via an *optional* program...kids, remember that word *optional*)
so much about the configuration that the user need only answer questions 
that are genuinely about policy and capabilities.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The conclusion is thus inescapable that the history, concept, and 
wording of the second amendment to the Constitution of the United 
States, as well as its interpretation by every major commentator and 
court in the first half-century after its ratification, indicates 
that what is protected is an individual right of a private citizen 
to own and carry firearms in a peaceful manner.
         -- Report of the Subcommittee On The Constitution of the Committee On 
            The Judiciary, United States Senate, 97th Congress, second session 
            (February, 1982), SuDoc# Y4.J 89/2: Ar 5/5
