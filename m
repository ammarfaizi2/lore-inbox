Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292522AbSB0WbN>; Wed, 27 Feb 2002 17:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293009AbSB0Was>; Wed, 27 Feb 2002 17:30:48 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:65158 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S293010AbSB0WaK>; Wed, 27 Feb 2002 17:30:10 -0500
Date: Wed, 27 Feb 2002 17:29:47 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Michael H. Warfield" <mhw@wittsend.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: crypto (was Re: Congrats Marcelo,)
Message-ID: <20020227172947.A18053@alcove.wittsend.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Andreas Dilger <adilger@turbolabs.com>,
	"Dennis, Jim" <jdennis@snapserver.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020227161519.A13912@alcove.wittsend.com> <Pine.LNX.4.33L.0202271855230.2801-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202271855230.2801-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 06:57:24PM -0300, Rik van Riel wrote:
> On Wed, 27 Feb 2002, Michael H. Warfield wrote:
> > On Tue, Feb 26, 2002 at 07:33:50PM -0300, Rik van Riel wrote:
> > > On Tue, 26 Feb 2002, Jeff Garzik wrote:
> >
> > > > IMO it's time to get a good IPsec implementation in the kernel...
> >
> > > Where would we get one of those ?
> >
> > > The freeswan folks seem quite determined to not let any
> > > americans touch their code, so inclusion of their stuff
> > > into the kernel is out.
> >
> > 	No...  That's patently not true.
> >
> > 	They won't accept contributions from us, but we touch
> > their code all the time.  If we didn't, how would we get any testing
> > done, which they do accept from us.
> 
> > 	They won't accept contributions from US developers to their code
> > base.  That does NOT mean that they will not accept contributing the IPSec
> > kernel code to the kernel and the incorporation of klips into the kernel
> > source tree.
> 
> Wouldn't that result in the following scenario:

> 1) freeswan gets merged into the kernel

	No...  Klips gets integrated into the kernel.  Pluto and the
supporting code and utilities are user space.

> 2) davem fixes a networking thing which
>    happens to touch freeswan

	FreeSWAN consists of two pieces, klips (Kernel Level IPSec) and
pluto plus a lot of user space glue.  Let's keep them separated into
the klips portion and the non-klips portion to cut down on the
confusion here.

	Dave, fixing a network thing, would only touch klips or one of
the interfaces.  He doesn't "touch" the non-klips code at all.  If there
is a user-space interface change, it's up to the FreeSWAN gang to
"touch" the user space code in the scripts and in pluto.  Dave doesn't
touch the user space stuff.

> 3) the freeswan developers don't take davem's
>    fix into their tree

	Once klips is in the kernel tree, it's no longer in their tree
other than code for legacy versions which lack integrated klips.
Changes or fixes to klips get submitted to the kernel sources for
the integrated versions and they become maintainers for that portion
of the kernel tree.  Their contribtutions come this way into the klips
sources in the kernel tree, not the other way around.

> 4) the next patch by the freeswan people doesn't
>    apply to what's in the kernel

	The subject on the FreeSWAN list has been targeted at getting
the klips code out of FreeSWAN and into the kernel so the only changes
or patches they make are changes against the code in the kernel outside
of the legacy kernel versions.

	Last I understood them to say, they agree that they have no
control over the incorporation of klips into the kernel and they
seem to have no problem contributing code which is used by and integrated
into software by US developers.  They just can't accept code FROM
US developers.  That implies that once klips, and only klips, is
integrated into the kernel, both parties contribute changes to that
module while the FreeSWAN developers manage their user space utilities
and code while accepting no contributions from the US developers.

> Somehow this scenario doesn't seem like it would make
> the ipsec implementation very maintainable.

	It should actually make it MORE maintainable and more installable.
If klips is in the kernel then they don't have to worry about patching
the kernel just to install FreeSWAN.  Then they can take pluto and all
the associated support stuff and roll it into a user space application
package or and rpm that can simply be agregated with the distributions.
They are even moving in that direction now by separating the builds
so that the kernel level code and pluto no longer share libraries or
common sources.  That's enabled some people to build freeswan rpms
for the user space stuff now as long as the kernel gets patched
for klips.

	The one major downside, right now, is that Henry and Richard
et al, keep talking about redesigning the klips structure to fit
in with the more recent kernels better (ala netfilter, maybe).  They've
announced some design specs and I suspect that they would rather
see the newer version of klips in the kernel tree than the crufty
version that we are hobbled with in FreeSWAN right now.  Search the
FreeSWAN archives for discussions over routing and multiple tunnels
and the ipsec{n} interfaces to see what I meam about being hobbled
by the crufty klips interface.  Even they don't like the state
it's in.

> Maybe it would be better to use what the usagi people
> are building, just to have an easier maintainable system?

> regards,
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
