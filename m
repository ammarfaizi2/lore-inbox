Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289208AbSASMQt>; Sat, 19 Jan 2002 07:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289209AbSASMQk>; Sat, 19 Jan 2002 07:16:40 -0500
Received: from pdbn-3e36a8ec.pool.mediaWays.net ([62.54.168.236]:8199 "EHLO
	mail.citd.de") by vger.kernel.org with ESMTP id <S289208AbSASMQ3>;
	Sat, 19 Jan 2002 07:16:29 -0500
Date: Sat, 19 Jan 2002 13:16:00 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020119131600.A17356@citd.de>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net> <a2almg$vtl$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <a2almg$vtl$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Jan 18, 2002 at 06:29:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well no. new_fd will refer to a completely new, empty file
> > which has no relation to the old file at all.
> > 
> > There is no way to recreate a file with a nlink count of 0,
> > well that is until someone adds flink(fd, newpath) to the kernel.
> > 
> 
> This *might* work:
> 
> link("/proc/self/fd/40", newpath);

cat /proc/<id>/fd/<nr> > whatever
actually works.

"Even Better(tm)" would be if
ln /proc/<id>/fd/<nr> whatever
or
ln <Inode> whatever (lsof delivers the needed Inode-nr)
would work.

Otherwise you have a problem to recover files when you have insufficent
disc space. Imagine a file that is 1GB in size and you have 512MB left
on the hdd. Currently i don't see a chance to recover such a file
without problems.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

