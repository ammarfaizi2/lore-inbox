Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbSAASzp>; Tue, 1 Jan 2002 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283016AbSAASz1>; Tue, 1 Jan 2002 13:55:27 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:8395 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S283012AbSAASzU>; Tue, 1 Jan 2002 13:55:20 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: george anzinger <george@mvista.com>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Date: Tue, 1 Jan 2002 19:55:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, Oleg Drokin <green@namesys.com>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200112291907.LAA25639@messenger.mvista.com> <20011230195500Z284765-18284+9610@vger.kernel.org> <3C306E9F.24BED14F@mvista.com>
In-Reply-To: <3C306E9F.24BED14F@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020101185523Z283012-18284+10404@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 31. December 2001 14:56, george anzinger wrote:
> Dieter Nützel wrote:
> > On Sunday, 29. December 2001 21:00, you wrote:
> > >Dieter Nützel wrote:
> > > > I ask because my MP3/Ogg-Vorbis hiccup during dbench isn't solved
> > > > anyway. Running 2.4.17 + preempt + lock-break + 10_vm-21 (AA).
> > > > Some wisdom?
> > >
> > > Please test this elevator patch.  I'll be putting it out more formally
> > > in a day or two.  Much more testing is needed yet, but for me, the
> > > time to read a 16 megabyte file whilst running dbench 160 falls from
> > > three minutes thirty seconds to seven seconds.  (This is a VM thing,
> > > not an elevator thing).
> >
> > Andrew or anybody else,
> >
> > can you please send me a copy directly?
> > The version I've extracted from the list is some what broken.
> > I am not on LKML 'cause it is to much traffic for such a poor little boy
> > like me...;-)
>
> Andrew,
>
> I think the problem is that the mailer(s) insert new lines.  Is this
> right Dieter?  It is certainly a problem for me.

Yes.

> Best to mail as an attachment.

Yes.

But I applied it by hand and got the best results I ever had!
GREAT work, Andrew!
This should be go in, soon.

2.4.17
preempt-kernel-rml-2.4.17-1.patch
lock-break-rml-2.4.17-2.patch
00_nanosleep-5
10_vm-21					(Andrea)
bootmem-2.4.17-pre6
elevator-fix					(Andrew)
O-inode-attrs.patch				(ReiserFS)
linux-2.4.17rc2-KLMN+exp_trunc+3fixes.patch	(ReiserFS)

Happy New Year and best wishes!

-Dieter

BTW Below are my first results. More to come (analysis of latency).

2.4.17-preempt + 10_vm-21 + elevator
dbench/dbench> time ./dbench 32
32 clients started
................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+.................................................................+...................+.......+....................+.........................................................................................................+.........+....................+................+..................+.....+...................................................................................................................................................................................................................................................................+..............++...........+.+.+..++++.+++.+.+++.++++********************************
Throughput 49.7707 MB/sec (NB=62.2133 MB/sec  497.707 MBit/sec)
13.800u 51.810s 1:25.89 76.3%   0+0k 0+0io 939pf+0w

2.4.17-preempt + 10_vm-21 + elevator + MP3 playback
dbench/dbench> time ./dbench 32
32 clients started
..............................................................................................................................................................................................................................................................................................................................................+.................................++....+.+.+.......+.............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+......................++.....+..+++.++..++.++++.+....++++.+++++********************************
Throughput 48.6323 MB/sec (NB=60.7904 MB/sec  486.323 MBit/sec)
14.690u 52.920s 1:27.87 76.9%   0+0k 0+0io 939pf+0w
