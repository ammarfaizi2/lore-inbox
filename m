Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281094AbRKLWgx>; Mon, 12 Nov 2001 17:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281079AbRKLWgq>; Mon, 12 Nov 2001 17:36:46 -0500
Received: from mhub-w2.tc.umn.edu ([160.94.160.45]:40616 "EHLO
	mhub-w2.tc.umn.edu") by vger.kernel.org with ESMTP
	id <S281075AbRKLWgc>; Mon, 12 Nov 2001 17:36:32 -0500
Date: Mon, 12 Nov 2001 16:36:30 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Lionel Bouton <Lionel.Bouton@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-Id: <Pine.SOL.4.20.0111121635370.14228-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Linus Torvalds wrote:
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
  
>From src/buffer.c in tar-1.13.19 in open_archive():
  
        [ ... ]
  
        #if !MSDOS
  
          /* Detect if outputting to "/dev/null".  */
          {
            static char const dev_null[] = "/dev/null";
            struct stat dev_null_stat;
  
            dev_null_output =
              (strcmp (archive_name_array[0], dev_null) == 0
               || (! _isrmt (archive)
                   && S_ISCHR (archive_stat.st_mode)
                   && stat (dev_null, &dev_null_stat) == 0
                   && archive_stat.st_dev == dev_null_stat.st_dev
                   && archive_stat.st_ino == dev_null_stat.st_ino));
          }
  
        [ ... ]

Regards,

Grant


-- 
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE

