Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274747AbRIUDR7>; Thu, 20 Sep 2001 23:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274670AbRIUDRt>; Thu, 20 Sep 2001 23:17:49 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:47153 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274747AbRIUDRh> convert rfc822-to-8bit; Thu, 20 Sep 2001 23:17:37 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Oliver Xymoron <oxymoron@waste.org>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109202252.f8KMqLG17327@zero.tech9.net>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> 
	<200109202252.f8KMqLG17327@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.20.15.42 (Preview Release)
Date: 20 Sep 2001 23:17:28 -0400
Message-Id: <1001042255.7291.39.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 18:51, Dieter Nützel wrote:
> > Does your audio source depend on any files (eg mp3s) and if so, could they
> > be moved to a ramfs? Do the skips go away then?
> 
> Good point.
> 
> I've copied one video (MP2) and one Ogg-Vorbis file into /dev/shm.
> Little bit better but hiccup still there :-(

As I've been saying, the problem really shouldn't be disk I/O.  I would
think (and really hope) the readahead code can fit a little mp3 in
memory.  Even if not, its a quick read to load it.  The continued blips
you see are caused by something, well, continual :)

> dbench 16
> Throughput 25.7613 MB/sec (NB=32.2016 MB/sec  257.613 MBit/sec)
> 7.500u 29.870s 1:22.99 45.0%    0+0k 0+0io 511pf+0w
> 
> Worst 20 latency times of 3298 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>  11549  spin_lock        1   678/inode.c         c01566d7   704/inode.c

A single 11ms latency is not bad.  Again, this looks OK.

> *******************************************************
> 
> dbench 16 + renice artsd -20 works
> GREAT!
> 
> *******************************************************

Great :)

> dbench 32 and above + renice artsd -20 fail
> 
> Writing this during dbench 32 ...:-)))
> 
> dbench 32 + renice artsd -20
> Throughput 18.5102 MB/sec (NB=23.1378 MB/sec  185.102 MBit/sec)
> 15.240u 63.070s 3:49.21 34.1%   0+0k 0+0io 911pf+0w
> 
> Worst 20 latency times of 3679 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>  17625  spin_lock        1   678/inode.c         c01566d7   704/inode.c

What do you mean failed?

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

