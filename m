Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269997AbRHEUYF>; Sun, 5 Aug 2001 16:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270002AbRHEUXp>; Sun, 5 Aug 2001 16:23:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269997AbRHEUXg>; Sun, 5 Aug 2001 16:23:36 -0400
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 5 Aug 2001 21:23:57 +0100 (BST)
Cc: mblack@csihq.com (Mike Black), bcrl@redhat.com (Ben LaHaise),
        phillips@bonn-fries.net (Daniel Phillips),
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, andrewm@uow.edu.au (Andrew Morton)
In-Reply-To: <Pine.LNX.4.33.0108051249570.7988-100000@penguin.transmeta.com> from "Linus Torvalds" at Aug 05, 2001 01:04:29 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TURJ-0008Jy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 5 Aug 2001, Mike Black wrote:
> And quite frankly, if your disk can push 50MB/s through a 1kB
> non-contiguous filesystem, then my name is Bugs Bunny.

Hi Bugs 8), previously Frodo Rabbit, .. I think you watch too much kids tv
8)

[To be fair I can do this through a raid controller with write back caches
and the like ..]

> You're more likely to have a nice contiguous file, probably on a 4kB
> filesystem, and it should be able to do read-ahead of 127 pages in just a
> few requests.

One problem I saw with scsi was that non power of two readaheads were
causing lots of small I/O requests to actual hit the disk controller (which
hurt big time on hardware raid as it meant reading/rewriting chunks). I
ended up seeing 128/127/1 128/127/1 128/127/1 with a 255 block queue.

It might be worth logging the number of blocks in each request that hits
the disk layer and dumping them out in /proc. I'll see if I still have the
hack for that around.

Alan
