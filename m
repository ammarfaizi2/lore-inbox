Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUBQWYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUBQWXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:23:41 -0500
Received: from mho.net ([64.58.22.195]:63711 "EHLO sm1420")
	by vger.kernel.org with ESMTP id S266569AbUBQWUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:20:42 -0500
Date: Tue, 17 Feb 2004 15:19:30 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@sm1420.belits.com
To: Jamie Lokier <jamie@shareable.org>
cc: Alex Belits <abelits@phobos.illtel.denver.co.us>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040217210919.GG24311@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402171444080.23115@sm1420.belits.com>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161603420.10177@sm1420.belits.com>
 <20040217210919.GG24311@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Jamie Lokier wrote:

> > This means, it's quite possible that this standard will be replaced
> > by something better in the future
>
> You mean like Unicode 4 will be replaced by Unicode 5 or something? :)
>
> Seriously, if there was another standard encompassing all languages
> and characters, why would they call it something different?

  Because the only way to do it right is to make it automatically
expandable. Unicode by its very design is monolithic with a single address
space that has to be controlled by one standard body, with no generalized
procedure for adding anything other than going through their "standard
process".

> > and this is why poor design of Unicode is tolerated by users, and
> > this is also why many people use non-Unicode-based charsets.
>
> You've said this many times before, without explanation.

  How am I supposed to explain it if most of people on the list live many
thousand of kilometers from the nearest place where non-iso8859-1 charsets
are used? I have seen what people use in Russia, and it's not Unicode. Am
I supposed to bring all of you there, so you can confirm that, or should I
just point at the percentage of web pages, messages in mailing list
archives and other readily available evidence? Or do you think that this
is all irrelevant because Martin Duerst says so?

> As far as I know, Unicode is a superset of all pre-existing computer
> charsets used anywhere - but do feel free to correct me.

  Unicode is not exactly a superset of all of them, but the issue is
deeper than that. There are two kinds of standards. Ones define rules of
what can be compliant, and allow different levels of implementation that
still can interoperate and be reasonably small in the minimal
implementation. Others are "this is it -- you have to implement all of
that, or you aren't compliant". Charsets are by definition the latter. But
every charset is something reasonably small, can be even _remembered_
by people who use it, and some additional things like matching input
methods, keyboard layouts, even some language-dependent processing is
within what can be written in a small piece of paper. Not so with Unicode.
No single person can even draw a Unicode font, leave alone remember what
is there. A terminal that implements Unicode has to support everything.
There is no editing/input procedure that can be applied based on the
knowledge that some text is in Unicode. It's a display-only thing, and
ridiculously bloated yet not even expandable. An example of a design made
not just by committee but by a committee of people who would never use
most of it.

> Unicode does have its problems - but what possible advantage does
> _any_ known non-Unicode charset have over Unicode, apart from space saving?

  Not known, one that will be developed in the future. At this point the
demand for multilingual processing is so miniscule compared to documents
that use a single charset, the decisions that are made for this small area
of application may be completely arbitrary, and no one would notice. Same
as the situation before non-ASCII symbols appeared -- an overwhelming
majority of computer-processed text was in English, so ASCII and its
trivial extensions were tolerated despite ther inadequacies. When the real
demand will appear, Unicode will quickly show its inadequacies, and the
current "Unicode crusade" is nothing but an attempt to freeze the standard
before this will happen. Then "unicoders" will claim that "it sucks, but
it's everywhere, so live with it. It worked for Windows, right?

> You mention that Unicode doesn't well support language identification.
> This is true - but the non-Unicode charsets (koi8-r etc.) don't
> support that either!  Or do they?

  Other charsets don't have language identification, this is true. However
if language identification IS done, the need for unified charset
immediately disappears -- what can identify a language, can identify a
charset, it's just metadata that can be passed in-band or out of band, in
a general case. If this will be done (and it has to be done for anything
meaningful), the use of Unicode is the answer to the question that never
was asked.

  Unicode is great for representation of multilingual fonts, or as an
intermediate format in conversions, but declaring it the actual format for
all data to be processed is far beyond its area of applicability. It's a
creeping functionality (closely related to creeping featurism) where
every problem looks like a nail for a standard body that standardizes on
hammers.

> >   And this is perfectly fine. Displaying and editing multilingual text is
> > a user interface issue, that kernel should not be involved in.
>
> Actually the kernel does have a line editor which needs to know a little.

  Kernel does not edit multilingual text unless a terminal discipline
supports it. Some limited support is possible on the text console, however
even if Unicode allows printing all characters, it's not multilingual
editing yet. Complex character-handling routines, bidirectional support
and input methods that know multiple languages still belong in userspace,
so it's at most a good reason to make a nice userspace-based support of
multilingual processing.

> >   I can point at the example of this "solution" that happened years ago
> > when UCS-2 was all the rage, and it got hardcoded and enforced by NTFS
> > and everything that handles it. Who is laughing about that decision now?
>
> We are all laughing ;)

  And this is why I think, it is very arrogant to claim now that UTF-8 is
not going the way of UCS-2 in the near future. Again, I am not against
letting people who want to use UCS-2, UTF-8 or UCS-4 Unicode with Klingon
in a private area, to use what they want. I am against hardcoding things
just for the purpose of making it difficult to use anything else. XML, for
example, is a great example of a standard where the model with
single charset/documenr + multiple languages/document artificially created
an unsolvable problem for non-Unicode charset users who wanted to remain
within the standard, and I see this decision as not technically justified
but arbitrary and ideologically based.

-- 
Alex
