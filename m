Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSHBP7Q>; Fri, 2 Aug 2002 11:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSHBP65>; Fri, 2 Aug 2002 11:58:57 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:18324 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316512AbSHBP62>;
	Fri, 2 Aug 2002 11:58:28 -0400
Date: Fri, 2 Aug 2002 09:59:37 -0600
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers
Message-ID: <20020802095937.B2300@hq.fsmlabs.com>
References: <11294.1028240971@redhat.com> <Pine.LNX.4.33.0208011538220.1277-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0208011538220.1277-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Aug 01, 2002 at 03:40:56PM -0700
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 03:40:56PM -0700, Linus Torvalds wrote:
> 
> On Thu, 1 Aug 2002, David Woodhouse wrote:
> > 
> > torvalds@transmeta.com said:
> > >  Any regular file IO is supposed to give you the full result. 
> > 
> > read(2) is permitted to return -EINTR.
> 
> It is _not_ allowed to do that for regular UNIX filesystems.
> 

SusV2 and POSIX seem to have changed the prior standard

     The value  returned  may be less than nbyte if the number of bytes
     left  in  the  file  is  less than nbyte, if the read() request was
     interrupted  by  a  signal,  or  if  the  file is a pipe or FIFO or
     special  file  and has fewer than nbyte bytes immediately available
     for  reading.


The rationale mentions that
	while( read(...) > 0) 
must work
but, I think Linus is correct that many programs rely on
	while( read(fd,&b,n) == n)

------------------susv2

     If a read() is interrupted by a signal before it reads any data, it
     will return -1 with errno set to [EINTR].

     If  a  read()  is interrupted by a signal after it has successfully
     read some data, it will return the number of bytes read.
----------------------



The grim effects of "cancel" spread through the system.


-------------------------------------
The transitive closure of a design error is limited only by the size of
the program.

