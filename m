Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbRBBUlu>; Fri, 2 Feb 2001 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRBBUll>; Fri, 2 Feb 2001 15:41:41 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:43694 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129549AbRBBUl1>; Fri, 2 Feb 2001 15:41:27 -0500
Date: Fri, 2 Feb 2001 21:41:22 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: RAMFS
Message-ID: <20010202214122.C753@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010202185709.A753@nightmaster.csn.tu-chemnitz.de> <Pine.Linu.4.10.10102022022300.623-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.Linu.4.10.10102022022300.623-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Fri, Feb 02, 2001 at 08:24:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 08:24:19PM +0100, Mike Galbraith wrote:
> On Fri, 2 Feb 2001, Ingo Oeser wrote:
> > No, so have to unlock it also, if you return -ENOSPC.
> > 
> > So the correct fix seems to be:
[...]
> > This currently works for me (but using 2.4.0 + dwg-ramfs.patch + this patch)
>
> Have you stressed it?  (I see leakiness)

I do reads and writes to it every 5 seconds and sometimes more (
mounted on /tmp, /var/run and the like ) and had an uptime of
about a week (I use it in an embedded-like system and we
sometimes change the system image).

There might be a dentry or inode leak, but that doesn't bite me,
because I only create the files I need once and extend or shrink
them.

But I couldn't stress it too much.

Where exactly do you see the leaks?

PS: For reference, I put the diff to 2.4.0 that I use to
   http://www.tu-chemnitz.de/~ioe/dwg-ramfs.patch

   The original patch has _not_ been done by me, but by
   David Gibson, Linuxcare Australia.

PPS: It would be surprising anyway, if I used the right patch all
   the time, while the wrong one was in acX. That's why I didn't
   submit anything ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
