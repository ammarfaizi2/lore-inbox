Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288397AbSACXoV>; Thu, 3 Jan 2002 18:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288396AbSACXoL>; Thu, 3 Jan 2002 18:44:11 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:17145 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288398AbSACXoC>;
	Thu, 3 Jan 2002 18:44:02 -0500
Date: Thu, 3 Jan 2002 16:42:46 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andy Gaynor <silver@silver.unix-fu.org>, linux-kernel@vger.kernel.org
Subject: Re: losetuping files in tmpfs fails?
Message-ID: <20020103164246.G12868@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Andy Gaynor <silver@silver.unix-fu.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C2F0AEE.ACABAAFA@silver.unix-fu.org> <3C34E4DF.F439FD70@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C34E4DF.F439FD70@zip.com.au>; from akpm@zip.com.au on Thu, Jan 03, 2002 at 03:10:23PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 03, 2002  15:10 -0800, Andrew Morton wrote:
> Andy Gaynor wrote:
> > Whilst trying to figure out why my dang stripes won't persist (a separate
> > but worrisome issue), I wrote a dittie which creates a couple junk files in
> > /tmp (tmpfs), associates loop devices with them, whoops, losetup craps out.
> > 
> > ...
> >   /tmp# mount | grep tmp                # Filesystem is ...
> >   tmpfs on /tmp type tmpfs (rw)         #   tmpfs
> >   /tmp# echo foo > foo                  # Create file foo
> >   /tmp# losetup /dev/loop/5 foo         # Give foo to /dev/loop/5
> >   ioctl: LOOP_SET_FD: Invalid argument  # DISCO!!!          <o >  <o >
> 
> Yup, tmpfs doesn't provide some of the facilities which the
> loop driver requires.   Specifically, prepare_write() and 
> commit_write().  
> 
> Probably it's not too hard to change loop to use generic_file_write(),
> and it will then permit tmpfs file-backed loop mounts.
> 
> It's not obvious that there's a burning need to support loop-on-tmpfs
> though, is there?

Well, if you are using tmpfs as your /tmp filesystem (presumably not
such a strange situation given the name ;-), then any tool which creates
a loopback in /tmp will break.  Good examples would be mkinitrd, or
anything that is generating a floppy image (e.g. Linux Router Project
floppy, boot floppy tools, etc).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

