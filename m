Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVHKNWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVHKNWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 09:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVHKNWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 09:22:41 -0400
Received: from imap.gmx.net ([213.165.64.20]:49565 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030300AbVHKNWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 09:22:41 -0400
Date: Thu, 11 Aug 2005 15:22:39 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <1123764552.8251.43.camel@lade.trondhjem.org>
Subject: =?ISO-8859-1?Q?Re:_fcntl(F_GETLEASE)_semantics=3F=3F?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <994.1123766559@www9.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

> Von: Trond Myklebust <trond.myklebust@fys.uio.no>
>
> to den 11.08.2005 Klokka 14:27 (+0200) skreiv Michael Kerrisk:
> > And I pointed out that the existing behaviour (which is 
> > still current in 2.6.13-rc4) is inconsistent:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111511455406623&w=2
> > 
> >     Some further testing showed the following (both open() 
> >     and fcntl(F_SETLEASE) from same process):
> > 
> >      open()  |  lease requested
> >       flag   | F_RDLCK  | F_WRLCK
> >     ---------+----------+----------
> >     O_RDONLY | okay     |  okay
> >     O_WRONLY | EAGAIN   |  okay
> >     O_RDWR   | EAGAIN   |  okay
> > 
> > In other words, a process can open a file read-write, and
> > can't place a read lease, but can place a write lease!  
> > That does not seem to make any sense to me.
> 
> Then what do you think that leases are supposed to do, and why?

As noted already, I don't know much of CIFS and SAMBA.
But are you saying that it is sensible and consistent that
"a process can open a file read-write, and can't place a 
read lease, but can place a write lease"?  

> An exclusive (i.e. write) lease should mean that _nothing_ other than
> your process is accessing the file. A client may cache the file data,
> metadata and read/write locks because nobody else can change that
> information, and nobody else holds locks on the file. It may also cache
> file acl/access information, and hence cache new OPEN calls.
> 
> A shared (i.e. read) lease means that there are currently no processes
> that can change the data or metadata (including your own). 
                                        ^^^^^^^^^^^^^^^^^

This is precisely the point of the problem.  Stephen 
Rothwell, and Matthew Wilcox seem to be saying that
the last bit is not the case.  

Cheers,

Michael

-- 
GMX DSL = Maximale Leistung zum minimalen Preis!
2000 MB nur 2,99, Flatrate ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
