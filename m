Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <157268-17165>; Sun, 6 Dec 1998 12:12:28 -0500
Received: from snowcrash.cymru.net ([163.164.160.3]:1358 "EHLO snowcrash.cymru.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157647-17165>; Sun, 6 Dec 1998 08:06:42 -0500
Message-Id: <m0zmhG5-0007U1C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: atomicity
To: tzs@tzs.net (Tim Smith)
Date: Sun, 6 Dec 1998 16:42:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.rutgers.edu
In-Reply-To: <Pine.LNX.3.96.981205215727.29256C-100000@52-a-usw.rb1.blv.nwnexus.net> from "Tim Smith" at Dec 5, 98 10:07:38 pm
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

> 	open target file for writing
> 	while target file not fully written
> 		write until error
> 		delete one of the small files at random
> 	close target file
> 	delete all of the small random files that remain
> 
> Are there any file systems around that will manage to resist fragmentation
> if subjected to that?

ext2fs will quite happily handle that situation (in fact its not an atypical
pattern of I/O on a big multiuser box - consider someone doing a download
as another user does an rm -r.

ext2fs tries to grab linear chunks of disk and divides the disk into cylinder
groups to also help to maintain locality. The BSD ffs papers [McKusik et al]
describe this sort of stuff well.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
