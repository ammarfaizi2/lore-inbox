Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284195AbRL1Wr2>; Fri, 28 Dec 2001 17:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284191AbRL1WrU>; Fri, 28 Dec 2001 17:47:20 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:48091
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284220AbRL1WrB>; Fri, 28 Dec 2001 17:47:01 -0500
Date: Fri, 28 Dec 2001 17:31:51 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228173151.B20254@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 28, 2001 at 02:11:37PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com>: 
> On Fri, 28 Dec 2001, Eric S. Raymond wrote:
> > I'm not certain what you're objecting to, and I want to understand it.
> > There are rules that use architecture symbols to suppress things like
> > bus types.  I presume that's not a problem for you, but tell me if it is.
> 
> It _is_ a problem for me, because I want to do "diffstat" on a patch from
> a PPC maintainer, and if I see anything non-PPC, loud ringing
> noises go off in my head. I want that diffstat to say _only_
> 
> 	arch/ppc/...
> 	include/asm-ppc/...
> 
> and nothing else. That way I know that I don't have to worry.

Perhaps we're talking past each other.  I don't understand your objection
yet, and I want to so I can design (or redesign) to meet it.

When I talk about "rules that use architecture symbols to suppress
things like bus types" I have in mind things like this:

unless X86 suppress dependent MCA EISA
unless MIPS32 suppress dependent TC
unless (PCI and (X86 or SUPERH)) suppress pci_access
unless (ISA or PCI) suppress dependent IDE
unless PCI suppress dependent USB HOTPLUG_PCI
unless (X86 or ALPHA or MIPS32 or PPC) suppress usb
unless (X86 and PCI and EXPERIMENTAL) or PPC or ARM or SPARC suppress dependent IEEE1394
unless (M68K or ALL_PPC) suppress MACINTOSH_DRIVERS
unless SPARC suppress dependent FC4
unless ARCH_S390==n suppress buses

It seems to me *extremely* unlikely that a typical patch from a PPC maintainer
would mess with any of these!  They're rules that are likely to be written
once at the time a new port is added to the tree and seldom or ever changed
afterwards.

Thus I really don't think you have to worry about spurious spikes in
your diffstat.  The root rules.cml file will not change very often --
I know this is true, because I can look at the RCS history since I
broke it out in response to your request at the Kernel Summit and
*see* that changes have been few and sparse.

> In contrast, if it starts talking about Documentation/Configure.help and
> the main config file, I start worrying.

Rightly so in the latter case.  Configure.help patches shouldn't worry
you, I don't think.  It's not like they can actually break anything.
 
> For example, that MATHEMU thing is just ugly. It was perfectly fine in the
> per-architecture version, now it suddenly has magic dependencies just
> because different architectures call it different things, and different
> architectures have different rules on when it's needed.

It sounds to me like you're agreeing that it *shouldn't* be called
different things, and thus with my goal of cleaning this mess up the
rest of the way.  Yes?  No?

Guidance, please.  I am, as ever, willing to meet your concerns.  
But I have to understand clearly what they are in order to do that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"...The Bill of Rights is a literal and absolute document. The First
Amendment doesn't say you have a right to speak out unless the
government has a 'compelling interest' in censoring the Internet. The
Second Amendment doesn't say you have the right to keep and bear arms
until some madman plants a bomb. The Fourth Amendment doesn't say you
have the right to be secure from search and seizure unless some FBI
agent thinks you fit the profile of a terrorist. The government has no
right to interfere with any of these freedoms under any circumstances."
	-- Harry Browne, 1996 USA presidential candidate, Libertarian Party
