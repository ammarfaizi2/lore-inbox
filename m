Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287289AbRL3AWx>; Sat, 29 Dec 2001 19:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287288AbRL3AWg>; Sat, 29 Dec 2001 19:22:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4879 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S287286AbRL3AWa>; Sat, 29 Dec 2001 19:22:30 -0500
Date: Sun, 30 Dec 2001 00:22:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011230002203.E12535@flint.arm.linux.org.uk>
In-Reply-To: <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com> <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> <20011229174354.B8526@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011229174354.B8526@thyrsus.com>; from esr@thyrsus.com on Sat, Dec 29, 2001 at 05:43:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 05:43:54PM -0500, Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
> > > unless (ISA or PCI) suppress dependent IDE
> > 
> > Just a minor point, but what about non-PCI/ISA ide?
> 
> The CML1 rules seem to imply that this set is empty.

RiscPC:
  CONFIG_PCI=n
  CONFIG_ISA=n
  CONFIG_ARCH_ACORN=y

Yet, we have in drivers/ide:
      if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
         dep_bool '    ICS IDE interface support' CONFIG_BLK_DEV_IDE_ICSIDE $CONFIG_ARCH_ACORN
         dep_bool '      ICS DMA support' CONFIG_BLK_DEV_IDEDMA_ICS $CONFIG_BLK_DEV_IDE_ICSIDE
         dep_bool '        Use ICS DMA by default' CONFIG_IDEDMA_ICS_AUTO $CONFIG_BLK_DEV_IDEDMA_ICS
         define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_ICS
         dep_bool '    RapIDE interface support' CONFIG_BLK_DEV_IDE_RAPIDE $CONFIG_ARCH_ACORN
      fi

So I guess I've found a bug.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

