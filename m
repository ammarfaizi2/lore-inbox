Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143587AbRAHOYy>; Mon, 8 Jan 2001 09:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143814AbRAHOYf>; Mon, 8 Jan 2001 09:24:35 -0500
Received: from laxmls02.socal.rr.com ([24.30.163.11]:19431 "EHLO
	laxmls02.socal.rr.com") by vger.kernel.org with ESMTP
	id <S143587AbRAHOYZ>; Mon, 8 Jan 2001 09:24:25 -0500
From: Shane Nay <shane@agendacomputing.com>
Reply-To: shane@agendacomputing.com
Organization: Agenda Computing
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
Date: Mon, 8 Jan 2001 13:17:12 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108141702.I10035@nightmaster.csn.tu-chemnitz.de> <0101081213390Z.02165@www.easysolutions.net> <20010108152904.K10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010108152904.K10035@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Message-Id: <01010813171211.02165@www.easysolutions.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

> You can use (GNU-)tar for this. It even keeps track of other bits like
> ext2fs attributes, AFAIK.

True..., but cramfs is acting like a mountable (tar czvf) because of the 
compressed pages.  Seems redundant to have a tar on top of what is basically 
a segmented tar with frontal indexing (read inodes).

> > On the other hand..., maybe I'm being "selfish", and this is the right
> > way to go. You never write to it, so why track the write bits?
>
> Yes, I would consider this "selfish" ;-)

Maybe :), that's why I mentioned it.

> > (One answer is maybe later we can create a writable cramfs, but
> > oh well)
>
> This could then be solved with union mount and cramfs mount over
> ramfs or any other writable Unix style fs.
>
> Then we might need W bits, but currently they disturb things like
> "test" and the perl equivalent, which is quite annoying and
> complexifies code.  (Yes, I'm selfish too ;-))

Simplifying code is a good objective..., but we've already got the bits 
there, and actually when you look at the patch it's adding complexity, not 
subtracting from it.  (Adding additional operations on the fetch of every 
inode..., plus wholesale stealing bits from operational mode of a filesystem, 
but the bits are useless in the "normal interpretation" of it, so I see your 
point)  I guess the part that bugs me is you make a filesystem out of a 
directory sub-structure expecting a 1-1 relationship of the data in the 
original directory sub-strucure, and the interpretation of your cramfs 
filesystem.  But then you pull out the write bits, and that 1-1 relationship 
is gone.  (I can only see my particular case, but there are probably others 
this disturbs)

Thanks,
Shane Nay
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
