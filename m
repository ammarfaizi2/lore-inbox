Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267680AbUBRUiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUBRUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:38:52 -0500
Received: from mho.net ([64.58.22.195]:65255 "EHLO sm1420")
	by vger.kernel.org with ESMTP id S267680AbUBRUiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:38:46 -0500
Date: Wed, 18 Feb 2004 13:37:36 -0700 (MST)
From: Alex Belits <abelits@belits.com>
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040218065636.GD1146@schmorp.de>
Message-ID: <Pine.LNX.4.58.0402181236230.17749@sm1420.belits.com>
References: <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
 <Pine.LNX.4.58.0402171407461.23115@sm1420.belits.com> <20040218065636.GD1146@schmorp.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Marc Lehmann wrote:

> As well as spreading misinformation e.g. with respect to language
> tagging (which unicode supports, mabe not well, but certainly better than
> koi8-r, iso-8859-1 etc.) :(

  No charset supports language tagging (nonstandard, unused and unusable
extensions to Unicode that contradict and negate the very design of it
nonwithstanding) because it's beyond the scope of a charset in the first
place. However any mechanism that can support language tagging
automatically can be used to support any possible set of charsets, thus
making Unicode unnecessary. The only reason why Unicode is not criticized
as much as it deserves, is that almost no one needs the functionality that
it provides, and ones who do (linguists) don't use it in the first place.
The whole movement of "Unicode crusaders/missionaries" is based on the
false premise that their solution to 1/1000th of the problem of handling
multilingual text is suppposed to matter when the whole problem will be
faced by the real-life users.

> > not have planned for multilingual environments like they should've done,
> > but they aren't stupid enough to require someone to "bless" them with a
> > variable-length encoding.
>
> The only other "encoding" that I know that supports (very limited)
> language tagging and works in a multilingual environment is iso-2022.
> (maybe emacs has something else, or is iso-2022 based, I don't know,
> correct me please). iso-2022, is horrible to use and didn't catch on in
> many places because of this.

  iso-2022 is inadequate, and precisely because it was written when
requirements for tagging were too low to warrant anything that will be
adequate for a multilingual environment. So far the requirements of the
overwhelming majority of users are _still_ too low and this is why an
adequate system never was developed. When it will be -- and it will be
inevitable because at some point in the near future -- some tagging format
will be created, and from that moment there will be no point in insisting
on only using Unicode. So far Unicode proponents are too wrapped in their
religious devotion to their creation to understand the limits on its
usefulness.

> So it seems that these are your only choices. If there is a problem with
> unicode, it can be fixed (just as problems have been fixed in the past),

  All "fixes" to Unicode will have to go through the "standard process"
that makes ITU look sane, and will result in yet another incompatible
version. Not to mention that some additions can never (and should not) be
adopted by Unicode because they represent fictional or dead languages that
weren't widely used even when they were alive, yet those languages can be
easily supported by an extensible mechanism as long as people agree on
_names_ for them.

> and the resulting standard will be called "Unicode" and will map to
> UTF-8, just as _every_ codeset maps to UTF-8 that is <21 bit (in a strict
> interpretation) or >64 bit (in a lax interpretation).

  But it will still require software to be updated to be supported.
Extensible standard just works, users will install extensions as they will
become necessary -- heck, even MSIE is now smart enough to auto-install
"language environment", can't be too difficult for things based on a
better design.

> I don't understand why you are arguing against unicode so vehemently
> without having any other option, and without the need for any other
> option.

  The option is to create a thing that does what users will definitely
need, and that no one does now. I hardly see an alternative, involving
Unicode or not. Multilingual text processing that is not crippled by some
ridiculous limitations still has to be implemented yet, and when it will
be, the demand of using Unicode/UTF-8 as the only "blessed"
charset/encoding would only reduce its flexibility. I am not against using
Unicode where it serves some purpose, I am against forcing into the areas
where it contributes nothing of value.

> Please note that the examples you make (koi8-r etc.) fail miserably in a
> multilingual environment. koi8-r even starts to fail in a place near you,
> where people use koi8-u, often tagges as koi8-r, because most software has
> no good means to tag their texts.

  koi8-r and iso8859-1 work _great_ in an environment that I use, it's
just I wouldn't call it truly multilingual. Still when language and
charset tagging is supported (per-message in email and HTTP) I have no
problem using it, along with seeing (and editing) text in other languages
that require other charsets. What I don't see supported is multiple
languages and multiple charsets per document, and this happens because
MIME tagging is per-document instead of per-substring. So if I needed to
deal with truly multilingual documents, my problem would be not what
charset to use (charsets that I use work great already) but how to tag
them -- otherwise I lose editing and processing functionality, that I
value higher than the ability to stare at pretty letters.

  One solution is to change XML to add CHARSET attribute everywhere where
LANG is valid -- something that should've been done from the very
beginning.  Another, likely a superior and more generalized solution, is
likely to be created soon, after all, it's just a serialization of
metadata. Then writing some texts from JRRT work would not require a
Mordor representative in Unicode Consortium (what would be, I guess, a
bad thing).

-- 
Alex
