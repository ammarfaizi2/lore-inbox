Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRJUXRK>; Sun, 21 Oct 2001 19:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277161AbRJUXRA>; Sun, 21 Oct 2001 19:17:00 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:41151 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S277119AbRJUXQz>; Sun, 21 Oct 2001 19:16:55 -0400
Message-ID: <3BD357B2.12AE9A5E@kegel.com>
Date: Sun, 21 Oct 2001 16:18:10 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: connect() to localhost non-blocking.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patrick Mau <mau@oscar.prima.de> writes:
> 
> > I wrote a little test program to do some poll() benchmarks.
> > I changed the host address to localhost and observed that
> > connect() always returns EINPROGRESS when used with non-blocking
> > sockets.
> > 
> > >From the man page:
> > 
> > EINPROGRESS
> >  The socket is non-blocking and the connection cannot be completed
> >  immediately. It is possible to select(2) or poll(2) for completion by
> >  selecting the socket for writing.
> > 
> > So my question is:
> > 
> > What is meant by 'cannot be completed immediately' ?
> > I thought that connections to localhost would complete
> > without any delay when the application listens ?
> 
> Probably the accept()ing process hasn't been scheduled yet.
> EINPROGRESS is a perfectly reasonable response in such a case. 

You have to be prepared to handle both immediate and delayed
connection, especially if you want to be portable.  (Solaris behaves 
a bit differently than Linux in this regard.)  See
http://www.kegel.com/dkftpbench/dkftpbench-0.37/ftp_client_pipe.cc
for an example of how to handle nonblocking connects more or less portably.
(You have to wade through quite a bit of code, tabstops 4, to find
all the connect-handling stuff -- sorry.)
- Dan
