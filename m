Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAXKe1>; Wed, 24 Jan 2001 05:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRAXKeR>; Wed, 24 Jan 2001 05:34:17 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:47622 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129718AbRAXKeM>; Wed, 24 Jan 2001 05:34:12 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200101241034.CAA03629@cx518206-b.irvn1.occa.home.com>
Subject: Re: 2.4 disk speed 66% slowdown...
To: law@sgi.com (Linda Walsh)
Date: Wed, 24 Jan 2001 02:34:24 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (lkml)
Reply-To: barryn@pobox.com
In-Reply-To: <3A6E1C97.3B87EE00@sgi.com> from "Linda Walsh" at Jan 23, 2001 04:06:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:
> I think we're on to something.  I did gen's of the kernel with
[snip]
> The REAL problem was in disk performance.  The apm made no difference:
> 
> hdparm -t /dev/hda1 /dev/hda3 /dev/hda4 /dev/hda5 /dev/hda7
> 1) 2.2.17
> /dev/hda1: Timing buffered disk reads:  64 MB in  4.76 seconds = 13.45 MB/sec
> /dev/hda3: Timing buffered disk reads:  64 MB in  4.57 seconds = 14.00 MB/sec
> /dev/hda4: Timing buffered disk reads:  64 MB in  6.47 seconds =  9.89 MB/sec
> /dev/hda5: Timing buffered disk reads:  64 MB in  5.08 seconds = 12.60 MB/sec
> /dev/hda7: Timing buffered disk reads:  64 MB in  5.10 seconds = 12.55 MB/sec
> 
> 2) 2.4 w/apm
> /dev/hda1: Timing buffered disk reads:  64 MB in 16.03 seconds =  3.99 MB/sec
> /dev/hda3: Timing buffered disk reads:  64 MB in 15.87 seconds =  4.03 MB/sec
> /dev/hda4: Timing buffered disk reads:  64 MB in 15.67 seconds =  4.08 MB/sec
> /dev/hda5: Timing buffered disk reads:  64 MB in 15.82 seconds =  4.05 MB/sec
> /dev/hda7: Timing buffered disk reads:  64 MB in 15.85 seconds =  4.04 MB/sec
[snip]

Your slowdown's different from mine, then. hdparm gives me 16.5 MB/sec
(or so) for both 2.2 & 2.4 (with APM in both cases). I must stress that
I haven't tried 2.4.0 or 2.4.1pre on my Inspiron 5000e yet, so I don't
even know if the problem that caused my slowdown still exists.

(Just to clarify my case: 750MHz Pentium III, 256MB RAM, 32GB IBM HD,
Intel 440BX chipset. If you need more data, I'll collect it when I get a
chance, but I'd be surprised if 2.4.1 doesn't come out first.)

While I'm writing this email, I may as well mention that I have a problem
with booting my Inspiron 5000e under 2.4 (all of my actual 2.4test usage
on that machines has been with Slackware 7.1's Disc 2 and the
corresponding rootdisk). That machine has Red Hat 7.0 installed on an ext2
disk image file, stored on a vfat partition and loop mounted. (Actually,
/usr and a subdirectory of /home are each on different image files now,
for 3 total, but booting never gets far enough for that to be relevant.)

The RAM disk I use for booting off the hard drive is the default one set
up by the Red Hat 7 installer, except there are no modules on it (I
compile in everything that's needed for booting) and the last line of
linuxrc has an echo statement. After that echo statement runs, I get the
following error message under 2.4.0, but not 2.2.1[678]: (from memory, so
the exact message might be slightly different)

panic: I have no root and I must scream

If I comment out that panic, I get some rather interestng messages, but I
don't remember any of them. I wasn't planning on reporting this until I
got a chance to put together a self-contained package & instructions for
reproducing the problem, but since I'm writing an email to the list, here
it is...

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
