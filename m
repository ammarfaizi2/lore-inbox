Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313459AbSDLIpv>; Fri, 12 Apr 2002 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313461AbSDLIpu>; Fri, 12 Apr 2002 04:45:50 -0400
Received: from eowyn.iae.nl ([212.61.25.227]:2066 "HELO eowyn.vianetworks.nl")
	by vger.kernel.org with SMTP id <S313459AbSDLIpt>;
	Fri, 12 Apr 2002 04:45:49 -0400
Date: Fri, 12 Apr 2002 11:22:53 +0200
Message-Id: <200204120922.LAA08450@fikkie.vesc.nl>
From: "E. Abbink" <esger@bumblebeast.com>
To: Alexander.Riesen@synopsys.com
Cc: linux-kernel@vger.kernel.org
Reply-To: esger@bumblebeast.com
Subject: Re: Problem using mandatory locks (other apps can read/delete etc)
X-Mailer: NeoMail 1.25
X-IPAddress: 192.0.0.12
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, Apr 11, 2002 at 09:37:37AM -0200, Denis Vlasenko wrote:
> > On 10 April 2002 15:08, E. Abbink wrote:
> > > I'm trying to solve a problem using mandatory locks but am having some
> > > difficulty in doing so. (if there's a more appropriate place for
> > > discussing this please ignore the rest of this post. pointers to that
> > > place would be appreciated ;) )
> > >
> > > my problem:
> > >
> > > when I lock a file with a mandatory write lock (ie. fcntl, +s-x
bits and
> > > mand mount option. for code see below) it is still possible:
> > >
> > > - for me to rm the file in question
> > > - for the file to be read by an other process
> > 
> > [snip]
> > 
> > >     lock.l_type = F_WRLCK ;   <================
> > >     lock.l_whence = SEEK_SET ;
> > >     lock.l_start = 0 ;
> > >     lock.l_len = 0 ;
> > >     lock.l_pid = 0 ; // ignored
> > >
> > >     int err = fcntl (fd, F_SETLK, &lock) ;
> > 
> > I know nothing about file locking in Unix, but it looks like you
> > requested write lock, i.e. forbid writing to a file. Why are you
> > surprised that reads are allowed?
> 
> That's advisory write lock. Question is: why open call to read the file
> succeeded?

Normally it's an advisory lock, but if you do the appropriate actions
(mounting the fs with mand and setting the +s-x modebits, see
Documentation/mandatory.txt) the file becomes a mandatory lock candidate 
and fcntl will/should mandatory lock it.

> 
> > 
> > Probably someone else would comment on why rm is working, though...
> 
> Why not? Apparently he has write permission on the directory which contain
> the file, and is the owner of that file.
> 
> By the way, where are you changing file permissions to +s-x?
> 

by hand before the program is run.

> 
> 
> 

-- 
NeoMail - Webmail that doesn't suck... as much.
http://neomail.sourceforge.net
