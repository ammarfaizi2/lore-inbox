Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154048AbQBFNdL>; Sun, 6 Feb 2000 08:33:11 -0500
Received: by vger.rutgers.edu id <S154082AbQBFNaW>; Sun, 6 Feb 2000 08:30:22 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:1927 "EHLO alcove.wittsend.com") by vger.rutgers.edu with ESMTP id <S154121AbQBFN1k>; Sun, 6 Feb 2000 08:27:40 -0500
Date: Sun, 6 Feb 2000 12:42:32 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Robert de Bath <rd104005@home-box.demon.co.uk>
Cc: fejed <fejed@hackersclub.com>, linux-kernel@vger.rutgers.edu
Subject: Re: Encrypted File systems implementation into the kernel?
Message-ID: <20000206124232.H20611@alcove.wittsend.com>
References: <3896746B.86861D7F@hackersclub.com> <68198940cfcc6b22@home-box.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.2i
In-Reply-To: <68198940cfcc6b22@home-box.demon.co.uk>; from rd104005@home-box.demon.co.uk on Tue, Feb 01, 2000 at 09:14:25PM +0000
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Feb 01, 2000 at 09:14:25PM +0000, Robert de Bath wrote:
> Yes it could be done quite easily.

	I would question the "easily" part.  There are other issues.

> But first you'll have to get rid of all the idiots in the American and
> French governments.

	I think you are a little out of date with current events.

	As of January 14, the US export restrictions on cryptopgraphy
were relaxed (outside of one minor reporting irritation which does NOT
affect Open Source Software - only commercial software).  We are in a 120
day "comment period" but the changes in the regulations themselves are in
effect, NOW.  The regulations on Open Source Software SOURCES was almost
totally relaxed with no real restrictions on download sites and no reporting
requirements (please note emphasis on SOURCES - binaries are still
restricted somewhat).  The policy at kernel.org has now changed to
allow cryptography and they are in the process of making crypto available
from their sites and mirrors.  One gotcha was the loss of one or more
mirror sites that reside in the T-7 countries (7 countries listed as
restricted due to Terrorist activities) because the kernel.org gang do
want to include some binaries on the sites.  I know we lost at least one.

	The French relaxed their restrictions on possession of cryptography
last year some time and even the crypto law survey site has that updated.
There are still restrictions in Russia, China, and a few other countries,
but we can't be playing to everyone elses' lowest common denominator (plus
we want to provide strong encouragement and incentive to lower those
regulations as well).

	I spoke directly with Linus a couple of days ago at LinuxWorld Expo
in New York.  I specifically wanted to get his views on where he saw crypto
in the kernel proceeding, both from an implimentation standpoint and from
a time-frame standpoint.  I don't want to "speak for the man" but he told
me that he wants to move forward on crypto in the kernel but he wants to
move slowly as things play out.

	That gave me the impression that it is unlikely that we will
see hardened crypto integrated into the kernel sources in the early
2.4 releases.  I do hope that something does make it into the 2.4 release,
though.  I would personally prefer KLIPS (The kernel component of
Free/Swan IPSec) but I realize that some people are going to differ with
me on that.

	We have technical crypto issues that have to be examined carefully,
and that's why I held a BOF on "Cryptography in the Linux Kernel" last
Thursday at LinuxWorld.  We have cryptographic file systems (several) and
cryptography protocols (CIPE, FreeSwan/IPSec) to consider.  We DON'T need
5 copies of 3DES, four copies of Blowfish, three copies of Idea, two
copies of Twofish, and a partridge in a pear tree in the kernel.  And
let's not forget AES, SkipJack (Yuck), GOST, Lucifer, Loki, and what
ever else someone is going to dream up an idea for.

	IF we consider the regulatory issues resolved (distribution makers
still have to install crypto from sources - they can't export the binaries
as freely as they export sources) or at least managable, then we have to
consider the logistical and technical issues.  We may need a "cryptographic
service provider" in the kernel to provide algorithms to various
cryptographic consumers in the kernel and to provide a framework for
integrating new algorithms and access.

	Distro makers could build everything initially and delete the
crypto object modules for their distributions.  Then the crypto modules
could be recompiled from the sources at installation time.  So we may
need a separate "crypto" area in the /lib/modules/*/ directories.  That
may impact some other utilities (I haven't looked that far ahead yet).

	One gentleman at my BOF was very concerned about hardware
accelerators.  He's very worried about performance with all of this
cryptography churning cycles in the kernel.  We may need to be able to
plug in a crypto accelerator card that the kernel can use and then
all of the consumers of crypto services just magically get faster.
So now we not only have crypto algorithms, but we have crypto hardware
drivers.

	Then there are smartcards, certainly not accelerators but
providing a whole different facility...

	Some people want to see cryptographically signed modules for
the kernel.  That opens up a whole NEW can a worms (Arrakis, here we
come) with public key cryptography.  I'm not totally sure about the
feasibility of that, but I'm willing to be convinced either way.  Would
you be willing to type in a passphrase at boot-up to unlock all of your
cryptographically signed loadable kernel modules?  Some people feel
they would be.  I would love to see THAT coupled with smartcards doing
the PK stuff.  That would deal with the password on bootup issues.
The PK issues and smartcard issues may forever stay on the user level.

	Merely taking all the crypto pieces we have laying around at
kerneli.org and plugging them into the main kernel source tree is
IMNSHO the WRONG way to go.  That's the easy way but it would end
up with redundant code, poor optimization, inflexibility, and too
much bloat.  I personally don't think Linus would accept that (at
least I hope he wouldn't).

	We are now at the leading edge of integrating cryptography into
the kernel.  We need to do it right and not turn it into a cesspool.
Linus is right...  We need to go slow on this, even though the regulations
have now been relaxed.  The regulations forced us into a situation where
we have a plethora of implimentations that now have to be resolved so that
they are properly integrated into the kernel, not merely hacked in on
top of everything else.

	A few of the issues I see...

	What existing add-on packages do we want integrated into the kernel?

	What form should a cryptographic service provider take?

	What algorithms do we need?
		DES, 3DES, Idea, BlowFish...

	Do we need public key algorithms?

	What are the initial cryptograhic service consumers?
		CIPE, IPSec, loopback crypto...

	Do we provide access from user level programs to kernel level
		algorithms?

	How to we coordinate with the different projects to get them
		to use the integrated crypto?


	A couple of other issues to remember are these...

	1) Some of these groups will not accept US contributions to their
code bases so they have to do the adaptations to what ever crypto services
end up in the kernel.

	2) The existing packages and groups may still have to deal with
kernels which do not have integrated cryptography.  We are not simplifying
their efforts in that regard, we are making their jobs worse.  They may
simply decide to say that they will only work with a crypto enabled kernel
(I doubt it) or they may ignore the kernel integrated crypto and only use
their own (I hope this would rapidly become unacceptable).

	I believe the floor is open for discussion...

	If there is sufficient interest and discussion, we may want to set
up a separate mailing list just for common crypto issues and development.
I would be willing to host such a list, but I want to be sure there is
sufficient interest and agreement before going to that trouble.  If the
threads remain managable and well identified, we may keep it here on
linux-kernel unless we get too many complaints.

> I wish you luck.

> -- 
> Rob.                          (Robert de Bath <http://poboxes.com/rdebath>)
>                     <rdebath @ poboxes.com> <http://www.cix.co.uk/~mayday>
> 
> On Tue, 1 Feb 2000, fejed wrote:
> 
> > Encrypted File systems implementation into the kernel?
> > I think its a great idea, here's the site with the source/libraries and
> > 3DES and RC5 modules:
> > Currently only supports 2.0.x kernels I think , so a port to 2.2.x or
> > 2.3.x or when 2.4.x comes out.
> > http://tcfs.dia.unisa.it/
> > Mirrors:
> > http://www.wwti.com/
> > http://vales.uni.net
> > http://zaphod.ethz.ch
> > 
> > --
> > "In the begginning ARPA created the ARPANET.
> > "And the ARPANET was without form and void.
> > "And darkness was upon the deep.
> > "And the spirit of ARPA moved upon the face of the network and ARPA said,
> > 'Let there be a protocol,'and there was a protocol. And ARPA saw that it
> > was good.
> > "And ARPA said,'Let there be more protocols,'and it was so.And ARPA saw
> > that it was good.
> > "And ARPA said,'Let there be more networks,'and it was so."

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (770) 331-2437   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
