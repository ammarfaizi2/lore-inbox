Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVASTsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVASTsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVASTsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:48:53 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:14610 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261505AbVASTss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:48:48 -0500
Message-Id: <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: Your message of "Wed, 19 Jan 2005 13:50:23 EST."
             <41EEABEF.5000503@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <1106157152.6310.171.camel@laptopd505.fenrus.org>
            <41EEABEF.5000503@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106164061_1885P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jan 2005 14:47:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106164061_1885P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jan 2005 13:50:23 EST, John Richard Moser said:
> Arjan van de Ven wrote:
> >>Split-out portions of PaX (and of ES) don't make sense.  
> > they do. Somewhat. 

> They do to "break all existing exploits" until someone takes 5 minutes
> to make a slight alteration.  Only the reciprocating combinations of
> each protection can protect the others from being exploited and create a
> truly secure environment.

OK, for those who tuned in late to the telecast of "Kernel Development Process
for Newbies":

It *DOES NOT MATTER* that PaX and ES "don't make sense" split out into 5 or
6 pieces.  We merge in stuff *ALL THE TIME* in 20 or 30 chunks, where it
doesn't make any real sense unless all 20 or 30 go in.  Just today, there was
a 29-patch monster replacing kexec, and another 12-patcher replacing something
else.  And I don't think anybody claims that many of those 29 patches stand
totally by themselves. You install 25 of them, you probably don't have a working
kexec, which is the goal of the patch series.

The point is that *each* of those 29 patches is small and self-contained enough
to review for breakage of current stuff, elegance of coding, and so on.  Now
let's look at grsecurity:

% wc grsecurity-2.1.0-2.6.10-200501071049.patch 
 23539  89686 700414 grsecurity-2.1.0-2.6.10-200501071049.patch

700K. In one patch. If PAX is available for 2.6.10 by itself, it certainly
hasn't been posted to http://pax.grsecurity.net - that's still showing a 2.6.7
patch.  But even there, that's a single monolithic 280K patch.  That's never
going to get merged, simply because *nobody* can review a single patch that big.

Now look at http://www.kernel.org/pub/linux/kernel/people/arjan/execshield/.
4 separate hunks, the biggest is under 7K.  Other chunks of similar size
for non-exec stack and NX support are already merged.

And why were they merged?  Because they showed up in 4-8K chunks.
  
> Split-out portions of PaX (and of ES) don't make sense.  ASLR can be
> evaded pretty easily:  inject code, read %efp, find the GOT, read
> addresses.  The NX protections can be evaded by using ret2libc.  on x86,
> you need emulation to make an NX bit or the NX protections are useless.
> So every part prevents every other part from being pushed gently aside.

Right.  But if you *submit* them as "a chunk to add x86 emulation of an NX
bit", "a chunk to add ASLR", "a chunk to add NX", "a chunk to do FOO with the
vsyscall page", and so on, they might actually have a snowball's chance of
being included.

If nothing else, the fact they're posted as different patches means each can be
used as the anchor for a thread discussing the merits of *that* patch.  Adrian
Bunk has been submitting patches for the last several weeks which probably
total *well* over the size of the PAX patch.  And since they show up as
separate patches, the non-controversial ones can sail by, the ALSA crew can
comment when he hits an ALSA module, the filesystem people can comment when he
hits one of their files, and so on.

--==_Exmh_1106164061_1885P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7rldcC3lWbTT17ARAvp3AKCHyoFvseZ3xnyXP7iXiPD7fhrPrgCg5bWb
c07cz4SuEwQ4sCJnp7L+r4s=
=g2OS
-----END PGP SIGNATURE-----

--==_Exmh_1106164061_1885P--
