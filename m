Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281039AbRKLWRN>; Mon, 12 Nov 2001 17:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281045AbRKLWQx>; Mon, 12 Nov 2001 17:16:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:65287 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281039AbRKLWQw>; Mon, 12 Nov 2001 17:16:52 -0500
Message-ID: <3BF04A37.29E19B1A@zip.com.au>
Date: Mon, 12 Nov 2001 14:16:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <3BF03402.87D44589@zip.com.au> <3BF03402.87D44589@zip.com.au> <1005600431.13303.10.camel@jen.americas.sgi.com> <3BF04289.8FC8B7B7@zip.com.au> <9spg3c$7bb$1@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3BF04289.8FC8B7B7@zip.com.au>,
> Andrew Morton  <akpm@zip.com.au> wrote:
> >
> >It's tar.  It cheats.  It somehow detects that the
> >output is /dev/null, and so it doesn't read the input files.
> 
> Probably the kernel.
> 
> If you do a mmap()+write(), the write() to /dev/null won't even read the
> mmap contents, which in turn will cause the pages to never be brought
> in.
> 
> Anything which uses mmap+write will show this.

Actually, tar _is_ doing funnies with /dev/null.  Changelog says:

1995-12-21  François Pinard  <pinard@iro.umontreal.ca>

        * buffer.c: Rename a few err variables to status.
        * extract.c: Rename a few check variables to status.

        Corrections to speed-up the sizeing pass in Amanda:
        * tar.h: Declare dev_null_output.
        * buffer.c (open_archive): Detect when archive is /dev/null.
        (flush_write): Avoid writing to /dev/null.
        * create.c (dump_file): Do not open file if archive is being
        written to /dev/null, nor read file nor restore times.
        Reported by Greg Maples and Tor Lillqvist.

One wonders why.

-
