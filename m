Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288395AbSA0TXC>; Sun, 27 Jan 2002 14:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288402AbSA0TWw>; Sun, 27 Jan 2002 14:22:52 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:20484 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S288395AbSA0TWj>;
	Sun, 27 Jan 2002 14:22:39 -0500
Date: Sun, 27 Jan 2002 12:22:35 -0700
From: Val Henson <val@nmt.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
Message-ID: <20020127122235.D11111@boardwalk>
In-Reply-To: <20020125113443.C26874@boardwalk> <20020126002045.17802@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020126002045.17802@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sat, Jan 26, 2002 at 01:20:45AM +0100
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2002 at 01:20:45AM +0100, Benjamin Herrenschmidt wrote:
> >
> >Looking at bat_mapin_ram, it looks like we only map the first 512MB of
> >RAM with BATs, so we actually map the 512MB - 768MB range with PTEs
> >(and highmem starts at 768MB).  Two of the DBATs are used by I/O
> >mappings, so that only leaves two DBATs of 256MB each to map lowmem
> >anyway.  Am I missing something?
> 
> No, except maybe my last patch that actually limits lowmem to 512Mb ;)

:)

> I don't think we use the io mapping BATs any more, do we ? (well,
> maybe on PReP...) I don't on pmac.

Lots and lots of PPC platforms use BATs for io mappings:

val@evilcat </sys/linuxppc_2_4_devel_pristine/arch/ppc/platforms>$ grep -l ppc_md.setup_io_mappings *
grep: SCCS: Is a directory
adir_setup.c
apus_setup.c
chrp_setup.c
gemini_setup.c
k2_setup.c
lopec_setup.c
mcpn765_setup.c
menf1_setup.c
mvme5100_setup.c
pcore_setup.c
powerpmc250.c
pplus_setup.c
prep_setup.c
prpmc750_setup.c
prpmc800_setup.c
sandpoint_setup.c
spruce_setup.c
zx4500_setup.c

I'm trying to get highmem working on Gemini, hence my interest.

> >By the way, does the "nobats" option currently work on PowerMac?
> 
> No, nor on any other BAT-capable PPC (and that's the reason why I
> did the above). Basically, our exception return path and some of
> the hash manipulation functions aren't safe without BAT mapping,
> especially on SMP when you can get evicted from the hash table
> by the other CPU in places where taking hash faults isn't safe.

Hm, that's what I thought.  Thanks for confirming that.

-VAL
