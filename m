Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUBQTAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266470AbUBQTAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:00:44 -0500
Received: from mho.net ([64.58.22.200]:47034 "EHLO es1036.belits.com")
	by vger.kernel.org with ESMTP id S266461AbUBQTA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:00:26 -0500
Date: Tue, 17 Feb 2004 11:55:50 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@es1840.belits.com
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
cc: linux-kernel@vger.kernel.org,
       Alex Belits <abelits@phobos.illtel.denver.co.us>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
In-Reply-To: <1077021379.6605.42.camel@ulysse.olympe.o2t>
Message-ID: <Pine.LNX.4.58.0402171135180.10406@es1840.belits.com>
References: <1077021379.6605.42.camel@ulysse.olympe.o2t>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Nicolas Mailhot wrote:

> |  UTF-8 is dependent on Unicode, that is cumbersome [...] Enforcing UTF-8
> | will burn the bridges to any other language support infrastructure or
> | encoding, right at the time when such infrastructure is likely to be created.
>
> Quite the contrary. The current UTF-8 migration shows the major showstopper
> when changing filename encodings is right know you don't know what damned
> encoding to convert from.
>
> With a clear policy (for *current* encodings) one can change.
>
> Without one you're reduced to expensive guesswork (ie *humans* have to spend
>  *days* checking the conversion worked as expected.)

  Solution: don't convert. It's the user who made the filename, it's also
the user who will read it. If he wants to change the encoding, he
definitely knows which one is he using.


> I happen to hate imperial units. *My* country switched to full metric more than
>  two hundred years ago. However I'll take a value in imperial units any day over
> some number without explicit unit any day.

  Metric system is a real standard, proven by time. Unicode is at most
what Esperanto is to languages -- something that some people invented,
and it still didn't catch on.

> Implicit unit/encoding is a damn stupid thing to do. There are numerous examples
>  of big expensive projects that failed because of this kind of misunderstanding.
> Many apps and humans need to interpret filenames to perform their job.

  This is why people always mention units and charsets.

> (BTW if anyone cares I was raised next to a computer which primary
> purpose was translating to a non-latin language. So I know quite a lot
> of the recipes for "getting by" and having worthless archives after a
> few years)

  And I am Russian, and I have used non-latin language for my whole life.
So?

> |> 8-bit bytes as filenames is not a good base, however, since they enforce
> |> a difefrent layer of interrpetation between the user and the kernel, and
> |> this interpretation cannot be based on the locale nor the filesystem
> |> itself, as there is no way to find out what encoding the filename is in.
> |
> |  This is a matter of GUI implementation. If someone cared about this, he
> |would store language metadata with filename, too, however this is clearly
> |contrary to the Unix filesystem design.
>
> If you think filename interpretation is GUI-only stuff you're sadly mistaken.
> Filename-based processing is widespread.

  Filename-based processing is not simplified by Unicode because
pattern-matching works on byte sequences regardless of the charset.

> |Duerst. The reality is, everything can pass UTF-8 already, yet people use
> |other encodings for everything, too, and as long as they don't break,
> |things work.
>
> Till a certain point.
> Past this point all the heuristics in the world won't help you and people
> suddenly revise their "work" definition.

  There is no NEED for heuristics. It's just when charsets matter, their
names are already available off-band, and when they don't matter, there is
no point doing charset-specific operations.

> | Breaking byte-value transparency in any place in the system
> |is counterproductive
>
> There is nothing transparent in the system for filename users.
> Generalised guesswork is not transparency.

  Byte-value transparency, not "transparency" as a marketing buzzword.
Again, guesswork is unnecessary unless some piece of software does it.
There is absolutely no need to know the charset until the point when the
filename is presented to the user -- and this is beyond the filesystem
functionality.

> [...]
>
> |> However, just as with URLs (which are byte-streams, too), byte-streams are
> |> useless to store text. You need bytestreams + known encoding.
> |
> |  MIME has a perfectly usable standard for declaring encodings, and huge
> |amounts of text (that may include filenames) are distributed by
> |MIME-compliant or MIME-like protocols (mail and HTTP, to name two).
>
> Fine. Just convert all your filenames to garbage at see how great it is their
> contents are still readable because the file formats have encoding info. I'm
> pretty sure you'll still miss your nice filenames.

  When I see filenames in a language that I don't understand, they look
like garbage to me anyway. And so does Unicode.

> Let me repeat my point :
> 1. filenames have a meaning
> 2. the meanings are important
> 3. they can not be reliably decoded without encoding info


  This is great -- but this is a matter of _applications_ and _users_
interpreting them. If users wanted to use Unicode for everything, they
would already willingly adopt it.

> Therefore encoding info needs to be added, using either FS metadata or a clear standard.
> And I don't care if the standard is UTF-8, UCS-foo, egyptian hieroglyphs or whatever.
> I want a f* standard. Every single person that had to work on the mess that results now
> from many users using different incompatible locales on a single FS want a f* standard.

  And some people don't want either of those standards forced on them.
What are you going to do, beat them all up?

> Someone wrote about it being akin to changing read() write() to do encoding conversion
> on the fly. This is blatantly false - filename contents are userspace-level and an app
> isn't expected to read other app files. And an app can use formats that declare file
> encoding. But any app *will* need to read files it didn't generate because they happen to
> reside in the same directory. And it *won't* be able to specify filename encoding because
> the filename format belongs to the kernel so it's the *kernel* job to provide encoding
> info somewhere so app authors can interpret it correctly.

  All that an application does is in userspace. If any encoding-definition
system will be applied to filenames, it will be in userspace as well.

> Sorry, we won't do it is not a valid answer.

  It's a very valid answer -- recruiting kernel for the Unicode crusade is
subverting its nature. I really don't care if it's supposed to be good or
bad, it's just something that it never was supposed to do.

> App writers have solved what they could - file contents (which are encoding-aware now
> thanks to xml and friends).

  No, they are not. XML is heavily unicode-biased because it allows to
supply multiple languages per document yet only one charset per document.
This is wrong, and it is the most common cause for the use of Unicode in
any file format -- they are based on XML, and can't use multiple charsets,
so they have to use Unicode. This is precisely an example of subversion
of a standard to serve the biases of Unicode supporters, there never was a
technical reason why charset should be one per document yet language is
one per tag.

> What they can not solve without kernel help is filename encoding -
> because filenames are shared unlike files, and it requires a
> system-level decision.

  If everyone loved Unicode, there would be no such problem -- there would
be never files in anything else to begin with.

-- 
Alex
