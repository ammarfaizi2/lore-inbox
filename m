Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRDKXSn>; Wed, 11 Apr 2001 19:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbRDKXSe>; Wed, 11 Apr 2001 19:18:34 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:16433 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S132607AbRDKXSU>; Wed, 11 Apr 2001 19:18:20 -0400
Date: Wed, 11 Apr 2001 19:19:40 -0400
From: esr@thyrsus.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@caldera.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Re: CML2 1.0.0 release announcement
Message-ID: <20010411191940.A9081@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@caldera.de>, Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
	"Eric S. Raymond" <esr@snark.thyrsus.com>
In-Reply-To: <20010411222722.A31359@caldera.de> <E14nT13-0007g6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14nT13-0007g6-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 11, 2001 at 11:23:06PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Multiple layers of Config.in is a feature

I disagree, because I've seen what happens when we go to a single-apex tree.
But you could persuade me otherwise.  What's your reason for believing this?

The problem with having multiple apices of the configuration tree (as I see
it) is that we often ended up duplicating configuration code for things that
aren't actually port-dependent but rather depend on other things such as
supported bus types (ISA, PCA, PCMCIA, etc.).  This is a particularly big
issue with network cards and disk controllers.

The duplicated code then starts to skew.  You end up with lots of features
(especially drivers) that could be supported across architectures but aren't,
simply because port maintainers are focused on their own trees and don't look
at what's going on in the others.

A multiple-apex tree also tends to pull the configuration questions downwards
from policy (e.g "Parallel-port support?") towards hardware-specific,
platform-specific questions ("Atari parallel-port hardware?")  By designing
the configuration rules for CML2 as a single-apex tree, I'm trying to
move the questions upwards and have derivations in the rules file handle
distributing that information to a lower level.

For example, instead of a bunch of parallel questions like this in a 
multiple-apex tree:

PARPORT			'Parallel port support'
PARPORT_PC		'PC-style hardware'
PARPORT_PC_PCMCIA	'Support for PCMCIA management for PC-style ports'
PARPORT_ARC		'Archimedes hardware'
PARPORT_AMIGA		'Amiga builtin port'
PARPORT_MFC3		'Multiface III parallel port'
PARPORT_ATARI		'Atari hardware'
PARPORT_SUNBPP		'Sparc hardware'

I'm trying to move us towards having *one* question and a bunch of
well-hidden intelligence about what it implies:

PARPORT			'Parallel port support'
derive PARPORT_PC from PARPORT and X86
derive PARPORT_ARC from PARPORT and ARC
derive PARPORT_AMIGA from PARPORT and AMIGA
derive PARPORT_SUNBPP from PARPORT and SUN
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Government is actually the worst failure of civilized man. There has
never been a really good one, and even those that are most tolerable
are arbitrary, cruel, grasping and unintelligent.
	-- H. L. Mencken 
