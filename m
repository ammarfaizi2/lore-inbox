Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSEFIpF>; Mon, 6 May 2002 04:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314132AbSEFIpE>; Mon, 6 May 2002 04:45:04 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:23307 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S313421AbSEFIpE>; Mon, 6 May 2002 04:45:04 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Date: 6 May 2002 08:40:07 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnadcgb7.8b3.kraxel@bytesex.org>
In-Reply-To: <23739.1020512961@ocs3.intra.ocs.com.au>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1020674407 8834 127.0.0.1 (6 May 2002 08:40:07 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Surely the dependencies on the dates of source and header files are
> >handled by make itself?  The global makefile wouldn't change just
> >because I touch a source file would it?
>  
>  phase1 gathers timestamps to use for _all_ kbuild processing, not just
>  generating the global makefile.  NFS timestamp skew between edit and
>  build systems can make timestamps go backwards.  Edit a file, decide
>  you made a mistake, restore from a backup or a repository and the
>  timestamp goes backwards.

Ah, *that* is the point of rebuilding the Makefile every time.  Sounds
like you are tried to write a better make utility, not better Makefiles.

Just curious:  If kbuild does all the work usually done by make (i.e.
check timestamps, look what needs rebuilding, ...), why do you need make
at all?  IMHO this is bad designed:  People know what make is and how it
works, but kbuild (ab)uses make in different ways.  Which is bad from
the usability point of view because people simply don't expect that.
That is the reason why the question about the Makefile generation comes
up again and again.  And I'm pretty sure that will never stop if you
keep that design.

I think you should either use make the usual way, i.e. let make do all
the timestamp checking (I know it is less strict, but I don't think it
is a big issue because developers know how make works and what the
pitfalls are).  Or don't use make at all.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
