Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315325AbSEGER2>; Tue, 7 May 2002 00:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315327AbSEGER1>; Tue, 7 May 2002 00:17:27 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:25040 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S315325AbSEGER1>;
	Tue, 7 May 2002 00:17:27 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "06 May 2002 08:40:07 GMT."
             <slrnadcgb7.8b3.kraxel@bytesex.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 May 2002 14:14:54 +1000
Message-ID: <22636.1020744894@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 May 2002 08:40:07 GMT, 
Gerd Knorr <kraxel@bytesex.org> wrote:
>Just curious:  If kbuild does all the work usually done by make (i.e.
>check timestamps, look what needs rebuilding, ...), why do you need make
>at all?

kbuild does not do all the work.  It is a wrapper around make to
overcome problems which have bitten kbuild in the past and will
continue to bite us as long as we do things that make was not designed
to handle.  Check out the replacements being written for make, you find
that almost all of them handle timestamps going backwards.

kbuild requires other processing that is not handled by make nor by any
of the proposed replacements.  In particular, the two level dependency
chain on configs as well as timestamps.

>IMHO this is bad designed:  People know what make is and how it
>works, but kbuild (ab)uses make in different ways.  Which is bad from
>the usability point of view because people simply don't expect that.

kbuild has abused make for years.  Look at all the code in the top
level Makefile, in Rules.make, the .depend and .hdepend files.  All of
it is special processing for kbuild to do things that make does not do
automatically.  Those requirements did not go away, I just handled it
in a cleaner method in kbuild 2.5.

>I think you should either use make the usual way, i.e. let make do all
>the timestamp checking (I know it is less strict, but I don't think it
>is a big issue because developers know how make works and what the
>pitfalls are).

You obviously believe in the "every kernel builder is an expert who
never makes mistakes" model.  I don't.  Everybody makes mistakes,
kernel build is too important to rely on fallible human actions.

>Or don't use make at all.

make does a very good job once it has been given a global makefile and
the timestamp skew has been handled.  If I did not use make, I would
have write my own program which did exactly the same, pointless.

