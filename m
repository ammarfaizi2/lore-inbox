Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287297AbRL3A2n>; Sat, 29 Dec 2001 19:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287292AbRL3A2e>; Sat, 29 Dec 2001 19:28:34 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:32743
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287301AbRL3A2U>; Sat, 29 Dec 2001 19:28:20 -0500
Date: Sat, 29 Dec 2001 19:11:01 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011229191101.A10380@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com> <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> <20011229174354.B8526@thyrsus.com> <20011230002203.E12535@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011230002203.E12535@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Dec 30, 2001 at 12:22:03AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk>:
> On Sat, Dec 29, 2001 at 05:43:54PM -0500, Eric S. Raymond wrote:
> > Tom Rini <trini@kernel.crashing.org>:
> > > > unless (ISA or PCI) suppress dependent IDE
> > > 
> > > Just a minor point, but what about non-PCI/ISA ide?
> > 
> > The CML1 rules seem to imply that this set is empty.
> 
> RiscPC:
>   CONFIG_PCI=n
>   CONFIG_ISA=n
>   CONFIG_ARCH_ACORN=y
> 
> Yet, we have in drivers/ide:
>       if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
>          dep_bool '    ICS IDE interface support' CONFIG_BLK_DEV_IDE_ICSIDE $CONFIG_ARCH_ACORN
>          dep_bool '      ICS DMA support' CONFIG_BLK_DEV_IDEDMA_ICS $CONFIG_BLK_DEV_IDE_ICSIDE
>          dep_bool '        Use ICS DMA by default' CONFIG_IDEDMA_ICS_AUTO $CONFIG_BLK_DEV_IDEDMA_ICS
>          define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_ICS
>          dep_bool '    RapIDE interface support' CONFIG_BLK_DEV_IDE_RAPIDE $CONFIG_ARCH_ACORN
>       fi
> 
> So I guess I've found a bug.

I have removed the constraint in question.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Let us hope our weapons are never needed --but do not forget what 
the common people knew when they demanded the Bill of Rights: An 
armed citizenry is the first defense, the best defense, and the 
final defense against tyranny.
   If guns are outlawed, only the government will have guns. Only 
the police, the secret police, the military, the hired servants of 
our rulers.  Only the government -- and a few outlaws.  I intend to 
be among the outlaws.
        -- Edward Abbey, "Abbey's Road", 1979
