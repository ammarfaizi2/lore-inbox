Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266637AbUBQWAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266639AbUBQWAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:00:12 -0500
Received: from [212.28.208.94] ([212.28.208.94]:60938 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266637AbUBQV4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:56:32 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
Date: Tue, 17 Feb 2004 22:56:30 +0100
User-Agent: KMail/1.6.1
Cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       linux-kernel@vger.kernel.org
References: <1077021379.6605.42.camel@ulysse.olympe.o2t> <Pine.LNX.4.58.0402171135180.10406@es1840.belits.com>
In-Reply-To: <Pine.LNX.4.58.0402171135180.10406@es1840.belits.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402172256.30397.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 19.55, Alex Belits wrote:
> On Tue, 17 Feb 2004, Nicolas Mailhot wrote:
> > Quite the contrary. The current UTF-8 migration shows the major showstopper
> > when changing filename encodings is right know you don't know what damned
> > encoding to convert from.

In most environments you do know, because you have a legacy encoding and a new 
UTF-8 encoding. There is no medicine that solves all compatibility problems, but the worst
symptoms can be alleviated while getting medicine to fix the disease.

> > With a clear policy (for *current* encodings) one can change.
> >
> > Without one you're reduced to expensive guesswork (ie *humans* have to spend
> >  *days* checking the conversion worked as expected.)
> 
>   Solution: don't convert. It's the user who made the filename, it's also
> the user who will read it. If he wants to change the encoding, he
> definitely knows which one is he using.

User's are clueless and you know that :-) They see garbage and blame the 
administrator or creator of the apps or whomever comes in handy.

>   When I see filenames in a language that I don't understand, they look
> like garbage to me anyway. And so does Unicode.
When I see I languages I don't understand, I understand that that's it. It doesn't
mean it actual IS garbage. The problem is when I see garbage simply because
the OS thinks it's unimporant.

> > Let me repeat my point :
> > 1. filenames have a meaning
> > 2. the meanings are important
> > 3. they can not be reliably decoded without encoding info
> 
>   This is great -- but this is a matter of _applications_ and _users_
> interpreting them. If users wanted to use Unicode for everything, they
> would already willingly adopt it.

Again users want characters, not bytes. Here up in the north we are among the
lucky ones that can still read a partially unlegible file name, because enough many
characters are usually just ascii. If a name was encoded in SJIS and you see them
interpreted as UTF-8 you'll a a string of pure garbage and you need to ask a bit
twiddler for help in decoding it simply becase ASCII characters are not likely to be
among the characters.

Note that I assume that the cases where there is a temporary working fix is the
two-locale (legacy+new) situation. And the only reason for the fix is to support 
migration from "old" charset to new charset without requiring martial arts.

For those application where it doesn't matter the point is moot. For most
users everything they see matters and the application cannot know what encoding
is used because there often is no relation between the application that creates and
the one that uses a file, and hence its name. The only place that can reliably store
the encoding of a filename is the file system, either as metdata, standard encoding on
disk or as a convention. It could be =?iso-8859-1?Q?=E5rsfest?=.rtf, fine with me. Not
adding a convention is that application can just work. A convention needs agreeing
upon between all apps. The kernel can just make it work.

-- robin





> > Therefore encoding info needs to be added, using either FS metadata or a clear standard.
> > And I don't care if the standard is UTF-8, UCS-foo, egyptian hieroglyphs or whatever.
> > I want a f* standard. Every single person that had to work on the mess that results now
> > from many users using different incompatible locales on a single FS want a f* standard.
> 
>   And some people don't want either of those standards forced on them.
> What are you going to do, beat them all up?
That's why there are locales, unfortunately these are volatile parameters that get lost. And it
doesn't have to be a a particular character encoding. It can be something per file system although
a fixed standard has the advantage that the filename can be read by anyone. 

> > Sorry, we won't do it is not a valid answer.
Agree.
>   It's a very valid answer -- recruiting kernel for the Unicode crusade is
> subverting its nature. I really don't care if it's supposed to be good or
> bad, it's just something that it never was supposed to do.
I thought the kernel was there to support user space. Ok, I know its' Just For Fun, but still
some usability is nice. Wh

> > App writers have solved what they could - file contents (which are encoding-aware now
> > thanks to xml and friends).
> 
>   No, they are not. XML is heavily unicode-biased because it allows to
> supply multiple languages per document yet only one charset per document.
> This is wrong, and it is the most common cause for the use of Unicode in
> any file format -- they are based on XML, and can't use multiple charsets,
> so they have to use Unicode. This is precisely an example of subversion
> of a standard to serve the biases of Unicode supporters, there never was a
> technical reason why charset should be one per document yet language is
> one per tag.
There's no need for multiple charsets when one can do all. So they added a
compromise that a charset could be specified to simplify creation of XML files
for legacy eight bit apps. I don't thing you understand XML at all. Enforcing
Unicode is helluvalot better than the "enforce" ASCII attitude of the past.

> > What they can not solve without kernel help is filename encoding -
> > because filenames are shared unlike files, and it requires a
> > system-level decision.
> 
>   If everyone loved Unicode, there would be no such problem -- there would
> be never files in anything else to begin with.

No matter what I think of unicode, I simply cannot have it yet everywhere.

-- robin

(Sorry for the suboptimal quotation here).
