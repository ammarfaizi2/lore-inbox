Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVFVJVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVFVJVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVFVJTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:19:39 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:18188 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262871AbVFVJI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:08:57 -0400
Message-ID: <42B92AA1.3010107@slaphack.com>
Date: Wed, 22 Jun 2005 04:08:49 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com> <42B8F4BC.5060100@pobox.com>
In-Reply-To: <42B8F4BC.5060100@pobox.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
> David Masover wrote:
> 
>> There's been sloppy code in the kernel before.  I remember one bit in
>> particular which was commented "Fuck me gently with a chainsaw."  If I
>> remember correctly, this had all of the PCI ids and the names and
>> manufacturers of the corresponding devices -- in a data structure -- in
>> C source code.  It was something like one massive array definition, or
>> maybe it was a structure.  I don't remember exactly, but...
>>
>> The point is, this was in the kernel for quite awhile, and it was so
>> ugly that someone would rather be fucked with a chainsaw.  If something
>> that bad can make it in the kernel and stay for awhile because it
>> worked, and no one wanted to replace it -- nowdays, that database is
>> kept in userland as some nice text format -- then I vote for putting
>> Reiser4 in the kernel now, and ironing the sloppiness ("violation") out
>> later.  It runs now.
> 
> 
> Existence of ugly code is not an excuse to add more.

Maybe not, but I'm making a point.  I'm sure that, at the time, people
wanted something that ran.  They wanted lspci to work.  It was generally
assumed that it would be cleaned up later, and it was.  Too much later,
but it happened, eventually.

I've been reading a bit of history, and the reason Linux got so popular
in the first place was the tendency to include stuff that worked and
provided a feature people wanted, even if it was ugly.  The philosophy
would be:  choose a good implementation over an ugly one, but choose an
ugly one over nothing at all.

> We have to maintain said ugly code for decades.  Maintainability is a
> big deal when you deal with the timeframes we deal with.

Maintainability is like optimization.  The maintainability of a
non-working program is irrelevant.  You'd be right if we already had
plugins-in-the-VFS.  We don't.  The most maintainable solution for
plugins-in-the-FS that actually exists is Reiser4, exactly as it is now
- -- because it is the _only_ one that actually exists right now.

>> So, Reiser4 may eventually take over VFS and be the only Linux
>> filesystem, but if so, it will have to do it much more slowly.  Take the
>> good ideas -- things like plugins -- and make them at least look like
>> incremental updates to the current VFS, and make them available to all
>> filesystems.
> 
> 
> This is how all Linux development is done.
> 
> The code evolves over time.
> 
> You have just described the path ReiserFS needs to take, in order to get
> this stuff into the kernel, in fact.

This is the path it needs to take, long term, for the sanity of
everyone.  But I don't think it can get there without being included,
short term.  People will stomp all over any attempts to change the VFS
as "unproven" and "unneccesary".  Do you think it will be any easier to
get this stuff into the kernel that way?

Better, I think, to drop it in, as-is, and move stuff incrementally from
the FS to the VFS.  That way, there's at least something intermediate
for people to use, test, and hammer/beat down, and for maintainers to
get more comfortable with the idea and the logistics of this beast in
their kernel.

>> And here is the crucial point.  Reiser4 is usable and useful NOW, not
>> after it has undergone massive surgery, and Namesys is bankrupt, and
>> users have given up and moved on to XFS.  But the massive surgery should
>> happen eventually, partly to make all filesystems better (see below),
>> and partly to make the transition easier and more palatable for those
>> who don't work for Namesys.
> 
> 
> We care about technical merit, not some random company's financial
> solvancy.  Reiser4 has layering violations, and doesn't work with the
> current security layer.  Those are two biggies.

Ah, so you mean to say, you care about how well something fits the
current model.  That has little to do with technical merit.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrkqoHgHNmZLgCUhAQIKixAAnTJTJJpuCLatFp8syccjNnE7WdHlO/zx
G1bWuSthCnb7uaVb8buDeAlpArzttoguKKum0NE0khz/FjKw4YUXH4AEsVYGlZaO
nBYpw0MVyypNP+hZhEuo1T826frEOb6Z40Y1WZCpYwAZCs9EQQm7TeYSMjhD17Ew
PehYwUFUmnv1S7CpYNQvuboKh/1wuUQb6R2thjuCGJVkif8Mn2U20Fhk1/HIgnIr
OHoCD8ZgwoqBDPKQ6V26dUX+ZHzQVJX1j/IgLnnitJ9E4quIHNs33lq4S99DWta6
uDS4hkHgFMRemh37sA0FUMeitFsrwNb2b2f0o/X8MpDJmwbdrdg9kxvwfHqqgaz+
Enj0rBXO8E+5a4STTk4L2LaSR2+knSEFdj53MYYq4ABL07hEbJp2cNFKh5AFXvg0
wg5WoHt4HhhOeuftIG9Twv5tHIC5qoM57ae9yZzj783G9ZnXy0xBefUmH+pWVQsp
H1IpKIR4a0l8gV1AkJa6BUyAyzDDObFzmqcZ61W15Y2relD9Ow2qzVqMxroB78uJ
O+on741BecGtohB5xdfth9rwDY6JPkDug3C6zHzxSAkGGEnWIn6O8CzcGrGqS0Ta
EmB4LGw/fZqGcEYOOErqMC6GuImv2JbjtBOx8nAxM2OhGXFoDiD9FQaDaxWw9zjj
ROODOhm0aTA=
=ivqd
-----END PGP SIGNATURE-----
