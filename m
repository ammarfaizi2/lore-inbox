Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSDKPog>; Thu, 11 Apr 2002 11:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314097AbSDKPms>; Thu, 11 Apr 2002 11:42:48 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:48861 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S314096AbSDKPmn>; Thu, 11 Apr 2002 11:42:43 -0400
Date: Thu, 11 Apr 2002 17:42:15 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: esger@bumblebeast.com
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org
Subject: Re: Problem using mandatory locks (other apps can read/delete etc)
Message-ID: <20020411174215.A26554@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: esger@bumblebeast.com,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204101708.TAA01151@fikkie.vesc.nl> <200204110634.g3B6YPX08966@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 09:37:37AM -0200, Denis Vlasenko wrote:
> On 10 April 2002 15:08, E. Abbink wrote:
> > I'm trying to solve a problem using mandatory locks but am having some
> > difficulty in doing so. (if there's a more appropriate place for
> > discussing this please ignore the rest of this post. pointers to that
> > place would be appreciated ;) )
> >
> > my problem:
> >
> > when I lock a file with a mandatory write lock (ie. fcntl, +s-x bits and
> > mand mount option. for code see below) it is still possible:
> >
> > - for me to rm the file in question
> > - for the file to be read by an other process
> 
> [snip]
> 
> >     lock.l_type = F_WRLCK ;   <================
> >     lock.l_whence = SEEK_SET ;
> >     lock.l_start = 0 ;
> >     lock.l_len = 0 ;
> >     lock.l_pid = 0 ; // ignored
> >
> >     int err = fcntl (fd, F_SETLK, &lock) ;
> 
> I know nothing about file locking in Unix, but it looks like you
> requested write lock, i.e. forbid writing to a file. Why are you
> surprised that reads are allowed?

That's advisory write lock. Question is: why open call to read the file
succeeded?

> 
> Probably someone else would comment on why rm is working, though...

Why not? Apparently he has write permission on the directory which contain
the file, and is the owner of that file.

By the way, where are you changing file permissions to +s-x?

