Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272431AbRIMVuM>; Thu, 13 Sep 2001 17:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272464AbRIMVuD>; Thu, 13 Sep 2001 17:50:03 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:16355 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S272431AbRIMVts>; Thu, 13 Sep 2001 17:49:48 -0400
Date: Thu, 13 Sep 2001 14:53:59 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Otto Wyss <otto.wyss@bluewin.ch>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How errorproof is ext2 fs?
In-Reply-To: <3BA1258F.5CC18A2C@bluewin.ch>
Message-ID: <Pine.LNX.4.33.0109131441230.1089-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this will help a bit...

On Thu, 13 Sep 2001, Otto Wyss wrote:

> While reading the thread about "HFS Plus on Linux?" at
> "debian-powerpc@list.debian.org" I had the following experience:
>
> Within an hour I had to hard reset both of my computers, first my Linux-i386 due
> to a complete lockup of the system while using el3diag, second my MacOS-powermac
> due to an not responding USB-keyboard/-mouse (what a nice coincident). Now while
> the Mac restarted without any fuse I had to fix the ext2-fs manually for about
> 15 min. Luckily it seems I haven't lost anything on both system.
>
> This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
> worse in case of a crash? Okay Linux does not crash that often as MacOS does, so
> it does not need a good  error proof fs. Still can't ext2 be made a little more
> error proof?

If you mount you ext2 filesytem with synchronous i/o rather than async
they'll be signficantly less brittle at the expense of some speed. I do
this occasionaly when testing new hardware or radical changes
something like:

mount -o remount sync /fsname

> Okay, there are other fs for Linux which cope better with such a
> situation, but are they really more errorproof or are they just better
> in fixing up the mess afterwards?

both actually if your're refering to reiserfs/ext3/jfs

> Could there be more attention in not
> creating errors instead of fixing them afterwards?

The errors are the result of omitted data not incorrect data... the files
were open the data that was gonna be written was sitting in the buffer, it
just hadn't been comitted yet...

> O. Wyss
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


