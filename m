Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbUBPUDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUBPUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:03:30 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:23478 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S265687AbUBPUDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:03:24 -0500
Date: Mon, 16 Feb 2004 21:03:21 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040216200321.GB17015@schmorp.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 10:49:48AM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > The problem is that the kernel does not use UTF-8, i.e. applications in
> > the current linux model have to deal with the fact that the kernel
> > happily breaks the assumed protocol of using UTF-8 by delivering illegal
> > byte sequences to applications.
> 
> You didn't read what I said.

I read it.

> READ MY POSTING. You even quoted it, but you didn't understand it.

You were able to explain it clearly enough for me, I think.

> I'm saying that "the kernel talks bytestreams".

And I am saying that this is not good, which is my sole point.

> I have never claimed that the kernel really talk s UTF-8, and indeed, I 
> would say that such a kernel would be terminally and horribly broken. 

And I'd say such a kernel would be highly useful, as it would standardize
the encoding of filenames, just as unix standardizes on "mostly ascii"
(i.e. the SuS).

However, just as POSIX is a nice but very limited base, (mostly) ASCII is a nice
and very limited base. UTF-8 would also be a good base.

8-bit bytes as filenames is not a good base, however, since they enforce
a difefrent layer of interrpetation between the user and the kernel, and
this interpretation cannot be based on the locale nor the filesystem
itself, as there is no way to find out what encoding the filename is in.

8-bit bytes is convinient, but not useful for i18n environments. in the
past, it was also convinient and nobody cared, since everything was
either 8-bit or double-byte, and nobody exchanged files.

This, however, is going to change, and the current methodology of "just
guess, you might be right" is a hindrance to this.

> The kernel is _agnostic_ in what it does.

No, it's not. If at all, the kernel specifies a specially-interpreted
(ascii sans / and \0) byte-stream, as you say yourself.

However, just as with URLs (which are byte-streams, too), byte-streams are
useless to store text. You need bytestreams + known encoding.

If filenames were not names, but just binary id's I would agree, but
this is not at all how filenames are used not how their use is applied.

Filenames are composed of text, but the kernel gives no indication
on how to interpret this text, and as a matter of fact, nothing else
gives this indication. glib etc. uses G_BROKEN_FILENAMES to force
locale-encoding. But as others have said, one mans locale is unlike other
mens locale.

> really care AT ALL what you feed it, as long as it is a byte-stream.
> 
> Now, that implies that if you want to have extended characters, then YOU 
> HAVE TO USE UTF-8.

You say so, but there is no logical connection between these two
statements. I can store latin1 easily in a bytestream, as I can store
iso-2022-jp or euc-jp. But they are incompatible to UTF-8.

You are yelling at me for no good reason. "YOU HAVE TO USE UTF-8". Why
should this be? The kernel certainly enforces this. Even you claim that
I don't have to, as the kernel doesn't care.

However, if you think so violently that it has to be UTF-8 that you even
yell it, then why doesn't the kernel comply to this rule? Why should an
applicaiton "HAVE TO" use utf-8 for input when the kernel doesn't even
try to comply and hands out illegal output?

This is just like mmap sometimes returning a page number and sometimes a
byte address... this would also not be useful unless you know the unit
that mmap returns (addreesses in multiples of 1).

> That's what I'm saying. I am _not_ saying that the kernel uses UTF-8. 

But you are saying that you have to feed UTF-8 into the kernel, which is
not the case either. I certainly don't have to..., and, what's worse,
you haven't given any indication of why one has to. Just because you say
so? Or is there actually a reason? If there is a reason, why doesn't the
kernel, in return, also follow this reasoning?

> kernel doesn't care one way or the other. As far as the kernel is 

It doesn't. But the point is that it should. If the kernel would do
everything we want it to do there would be no point in enhancing it.

> concerened, you could uuencode all the stuff, and the kernel wouldn't 

(Yes, because uuencode has the peculiar property of neither generting \0
nor /. It doesn't work in general with byte-streams).

> think you're crazy. The kernel _only_ cares about byte streams.

The kernel _interprets_ the byte-stream already. And some byte-streams are
no valid filenames _already_.

> > There is no way for applications to handle UTF-8 and illegal-utf8 in
> > a sane way, so most apps will either eat the illegal bytes, skip the
> > filename, or crash (the latter case is clearly a bug in the app, thr
> > former cases aren't).
> 
> What you're complaining about are bad user applications. It has _zero_ to 
> do with the kernel.

Could you elaborate on why these apps are bad? What I am interested in
is to know how to fix them? since there is simply no way to interpret
the names returned by the kernel as the corresponding meta-information
is missing.

Consider an OS that allows different characters for path-seperators (unix
only allows '/'). Without the knowledge of the path seperator it would be
impossible to interpret paths. And without knowledge about encoding it's
impossible (but slightly less dramatic) to correctly interpret filenames.

> > Fixing the VFS to actually enforce what linus claims (2filenames are
> > utf-8") is a very good idea, imho.
> 
> No. Read my claim again. You obviously do not understand it AT ALL. 

...

> What you suggest would be a horribly idiotic and bad idea.

Why?

> The kernel doesn't set policy. The kernel says "this is what I can do,
> you set policy".

Exactly. The kernel could specify the API to use UTF-8. This is not more
policy than it currently enforces.

Or do you suggest that the ability to change the source and replace all
occurences of '/' by '\\' means that '/' is not enforced as policy on
path seperators?

We basically seem to disagree on what, exactly, policy is. Policy (to
me) is something that differentiates between several incompatible
alternatives. Chosing policy means to rule out other (useful)
alternatives.

One could argue that '/' is a policy because it precludes the '/'
character from being used in filenames, sth. some filenames or operating
systems support.

I'd say (probably as much as you) that this policy is not a real policy,
it's just idiotic.

But enforcing other restrictions on filenames should magically be real
policy? This is obviously bot idiotic at all, and should be carefully
explored.

> And UTF-8 just happens to be the only sane policy for encoding complex 
> characters into a byte stream. But it is not the only policy.

Just as '/' is not the only possible path seperator. If that is your
point, you should explain why enforcing this is ok while supporting utf-8
(not enforcing, just supporting, meaning having the ability to rule out
non-utf-8 sequences when the admin wants this) is not.

> Another sane policy is to say "byte streams are latin1". It's not an
> acceptable policy for encoding _complex_ characters, but it is a policy.
> And it's a perfectly sane one.

I agree that it is sane. But it is not very useful for the future, as
people who want russian filenames are plainly unable to use the other
filenames in a sensible way. There is no way to know the encoding.

> In short: filenames are byte streams. Nothing more.

Right now, they aren't. Not all sequences of bytes are valid filenames
already, and I think this is perfectly o.k.

> And when I say that you have to talk to the kernel using UTF-8, I'm only 
> claiming that it is the only sane way to encode extended characters in a 
> byte stream. Nothing more.

And i fully agree.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
