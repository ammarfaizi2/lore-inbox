Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281093AbRKLWhD>; Mon, 12 Nov 2001 17:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281079AbRKLWgy>; Mon, 12 Nov 2001 17:36:54 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39440 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281093AbRKLWgn>; Mon, 12 Nov 2001 17:36:43 -0500
Message-ID: <3BF04ED8.8A9280B5@zip.com.au>
Date: Mon, 12 Nov 2001 14:36:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Lionel Bouton <Lionel.Bouton@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <3BF04926.2080009@free.fr> <Pine.LNX.4.33.0111121411410.7555-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 12 Nov 2001, Lionel Bouton wrote:
> >
> > Seems not the case with gnu tar : write isn't even called once on the fd
> > returned by open("/dev/null",...). In fact a "grep write" on the strace
> > output is empty in the "tar cf /dev/null" case. Every file in the tar-ed
> > tree is stat-ed but no-one is read-ed.
> 
> Wow. What a sleazy optimization - it can't be anything but a special case.
> 
> How do they do it anyway? By matching on the name Or by knowing what the
> minor/major numbers of /dev/null are supposed to be on that particular
> operating system?

  /* Detect if outputting to "/dev/null".  */
  {
    static char const dev_null[] = "/dev/null";
    struct stat dev_null_stat;

    dev_null_output =
      (strcmp (archive_name_array[0], dev_null) == 0
       || (! _isrmt (archive)
           && stat (dev_null, &dev_null_stat) == 0
           && S_ISCHR (archive_stat.st_mode)
           && archive_stat.st_rdev == dev_null_stat.st_rdev));
  }

> And what's the _point_ of the optimization? I've never heard of a "tar
> benchmark"..

Ask Al.  He understands those GNU folks.

It's actually a bug.  I may _want_ an ISREG /dev/null...

-
