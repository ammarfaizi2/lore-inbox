Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131100AbQKWKUE>; Thu, 23 Nov 2000 05:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131195AbQKWKTs>; Thu, 23 Nov 2000 05:19:48 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S131100AbQKWKT2>;
        Thu, 23 Nov 2000 05:19:28 -0500
Date: Wed, 22 Nov 2000 13:29:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org, Frank Ronny Larsen <frankrl@nhn.no>,
        Frank Ronny Larsen <gobo@gimle.nu>, Jannik Rasmussen <jannik@east.no>,
        Lars Christian Nygård <lars@snart.com>
Subject: Re: ext2 compression: How about using the Netware principle?
Message-ID: <20001122132922.A41@toy>
In-Reply-To: <3A193A12.9B384B61@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A193A12.9B384B61@karlsbakk.net>; from roy@karlsbakk.net on Mon, Nov 20, 2000 at 03:49:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - A file is saved to disk
> - If the file isn't touched (read or written to) within <n> days
> (default 14), the file is compressed.
> - If the file isn't compressed more than <n> percent (default 20), the
> file is flagged "can't compress".
> - All file compression is done on low traffic times (default between
> 00:00 and 06:00 hours)
> - The first time a file is read or written to within the <n> days
> interval mentioned above, the file is addressed using realtime
> compression. The second time, the file is decompressed and commited to
> disk (uncompressed).

Oops, that means that merely reading a file followed by powerfail can
lead to you loosing the file. Oops.

Besides: you can do this in userspace with existing e2compr. Should take
less than 2 days to implement.

> Results:
> A minimum of CPU time is wasted compressing/decompressing files.
> The average server I've been out working with have an effective
> compression of somewhere between 30 and 100 per cent.

Results: NOP at machines that are never on in that time, random corruption
after powerfail between 0:00-6:00, ..				Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
