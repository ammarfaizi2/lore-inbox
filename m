Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132431AbQKWNTJ>; Thu, 23 Nov 2000 08:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132430AbQKWNS7>; Thu, 23 Nov 2000 08:18:59 -0500
Received: from www.heime.net ([194.234.65.222]:41478 "EHLO mustard.heime.net")
        by vger.kernel.org with ESMTP id <S132280AbQKWNSz>;
        Thu, 23 Nov 2000 08:18:55 -0500
Message-ID: <3A1D12B5.D0AF250C@karlsbakk.net>
Date: Thu, 23 Nov 2000 13:51:01 +0100
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org, Frank Ronny Larsen <frankrl@nhn.no>,
        Frank Ronny Larsen <gobo@gimle.nu>, Jannik Rasmussen <jannik@east.no>,
        "Lars Christian Nygård" <lars@snart.com>
Subject: Re: ext2 compression: How about using the Netware principle?
In-Reply-To: <3A193A12.9B384B61@karlsbakk.net> <20001122132922.A41@toy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - A file is saved to disk
> > - If the file isn't touched (read or written to) within <n> days
> > (default 14), the file is compressed.
> > - If the file isn't compressed more than <n> percent (default 20), the
> > file is flagged "can't compress".
> > - All file compression is done on low traffic times (default between
> > 00:00 and 06:00 hours)
> > - The first time a file is read or written to within the <n> days
> > interval mentioned above, the file is addressed using realtime
> > compression. The second time, the file is decompressed and commited to
> > disk (uncompressed).
>
> Oops, that means that merely reading a file followed by powerfail can
> lead to you loosing the file. Oops.

eh.. don't think so.
READ
DECOMPRESS
WRITE
SYNC
DELETE OLD COMPRESSED FILE
or something

> Besides: you can do this in userspace with existing e2compr. Should take
> less than 2 days to implement.

ok
never seen that...

> > Results:
> > A minimum of CPU time is wasted compressing/decompressing files.
> > The average server I've been out working with have an effective
> > compression of somewhere between 30 and 100 per cent.
>
> Results: NOP at machines that are never on in that time, random corruption
> after powerfail between 0:00-6:00, ..                           Pavel

I'm talking about file servers. Not merely a bloody PC. On a PC, hard disk
space doesn't really cost anything and you can manually compress what you're
not using.

roy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
