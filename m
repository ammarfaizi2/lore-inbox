Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWHVQAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWHVQAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWHVQAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:00:40 -0400
Received: from bender.bawue.de ([193.7.176.20]:3047 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1751402AbWHVQAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:00:40 -0400
Date: Tue, 22 Aug 2006 17:59:50 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: FUSE unmount breaks serial terminal line
Message-ID: <20060822155949.GA4268@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
References: <20060820180505.GA18283@sommrey.de> <E1GEuMZ-0004uq-00@dorka.pomaz.szeredi.hu> <20060820212840.GA29855@sommrey.de> <E1GFS4R-0007wJ-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GFS4R-0007wJ-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 10:57:15AM +0200, Miklos Szeredi wrote:
> > > > something in FUSE breaks serial devices.  I found this issue 
> > > > using gphotofs, don't know if any other FUSE impementation has similar
> > > > effects.  The problem is: from the moment the FUSE filesystem is unmounted,
> > > > a process that read()s on a serial device /dev/ttyS? gets an EOF
> > > > returncode.  
> > > > 
> > > > Here is the tail of the output from "strace -tt cat /dev/ttyS0" when the
> > > > FUSE fs was unmounted:
> > > > 
> > > > 19:41:46.513143 open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
> > > > 19:41:46.513373 fstat64(3, {st_mode=S_IFCHR|0660, st_rdev=makedev(4, 64), ...}) = 0
> > > > 19:41:46.513552 read(3, "", 4096)       = 0
> > > > 19:42:49.854367 close(3)                = 0
> > > > 19:42:49.860663 close(1)                = 0
> > > > 19:42:49.860793 exit_group(0)           = ?
> > > > 
> > > > Found this on x86 with kernels 2.6.16 and 2.6.17.
> > > > 
> > > > Any ideas?
> > > 
> > > Likely a userspace issue.  Can you please attach a strace (strace -f
> > > -p `pidof gphotofs`) to the gphotofs process just before doing the
> > > unmount?
> > 
> > Here it is together with the "cat" strace.  cat receives EOF *after*
> > fusermount has exited - if it matters.
> 
> Yes, I think it matters.  I think one of those USBDEVFS ioctls might
> be responsible.  These are probably invoked by the libgphoto2 cleanup
> routines called when the filesystem exits.
> 
> Can you verify with a non-FUSE application (gphoto2, gtkam) that the
> same thing happens on exit?
> 

Tested both gphoto2 and gtkam without any problems. There is no impact
on the serial lines.

NB: The *real* trouble I have is with ntpd and a reference clock
attached to /dev/ttyS1.  ntpd enters a busy loop reading ttyS1, stops
working and eats up 100% CPU.  

Thanks for your investigations.  Any other idea?

-jo

-- 
-rw-r--r-- 1 jo users 62 2006-08-22 17:50 /home/jo/.signature
