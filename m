Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312113AbSCQUUy>; Sun, 17 Mar 2002 15:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312112AbSCQUUp>; Sun, 17 Mar 2002 15:20:45 -0500
Received: from mail020.mail.bellsouth.net ([205.152.58.60]:13212 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S312110AbSCQUUZ>; Sun, 17 Mar 2002 15:20:25 -0500
Message-ID: <00c101c1cdf1$1c031120$0100a8c0@DELLXP1>
From: "Ken Hirsch" <kenhirsch@myself.com>
To: "Anton Altaparmakov" <aia21@cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020317190303.03289ec0@pop.cus.cam.ac.uk>
Subject: Re: fadvise syscall?
Date: Sun, 17 Mar 2002 15:19:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov writes:
> Last time I heard serious databases use their own memmory
> management/caching in combination with O_DIRECT, i.e. they bypass the
> kernel's buffering system completely. Hence I would deem them irrelevant
to
> the problem at hand...
>
> If a database were not to use O_DIRECT I would think it would be using
mmap
> so it would have madvise already... but I am not a database expert so take
> this with a pinch of salt...
>

I don't think that either MySQL or PostgreSQL use O_DIRECT; I just grepped
the source and didn't find it.  They can't use mmap() because it uses up too
much process address space.

It's true that commercial databases mostly do their own scheduling and
caching, and if they are the only thing running on your system and you tune
them right, that works.  But it's not necessarily a good thing.  If there
are other processes on your system, there would be a benefit if the DBMS
could inform the operating system of its intentions.

A posix_fadvise() call would be a start, but you could potentially go beyond
that.   For some interesting ideas, see
Seltzer, M., Small, C., Smith, K., "The Case for Extensible Operating
Systems",
Harvard University Center for Research in Computing Technology TR16 -95
(July 1995).
http://citeseer.nj.nec.com/article/seltzer95case.html

Ken Hirsch


