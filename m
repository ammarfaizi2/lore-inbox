Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313749AbSDPQI1>; Tue, 16 Apr 2002 12:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313744AbSDPQGg>; Tue, 16 Apr 2002 12:06:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46597 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313737AbSDPQFu>; Tue, 16 Apr 2002 12:05:50 -0400
Subject: Re: [PATCH] 2.5.8 IDE 36
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 16 Apr 2002 17:23:11 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        david.lang@digitalinsight.com (David Lang),
        dalecki@evision-ventures.com (Martin Dalecki),
        vojtech@suse.cz (Vojtech Pavlik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0204160849540.1244-100000@home.transmeta.com> from "Linus Torvalds" at Apr 16, 2002 08:56:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVjb-0000I7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, you just need to do the loopback over nbd - you need something to do
> the byte swapping anyway (ie you can't really use the normal "loop"
> device: I really just meant the more generic "loop the data back"
> approach).

nbd goes via the networking layer and deadlocks if looped. The loop driver
is also much faster. Partitioned loop doesnt seem hard.

> nbd devices already do partitioning, I'm fairly certain.

Not when I checked.

> > the Tivo are examples of that. Interworking requires byteswapping and the
> > ability to handle byteswapped partition tables.
> 
> Note that THAT case is an architecture issue, and should probably be
> handled by just making the IDE "insw" macro do the byteswapping natively.
> That way you don't get the current "it can actually corrupt your
> filesystem on SMP" behaviour.

Thats still not enough. If you have the ide insw macro then control 
transfers come out wrong. And to maximise the pain - some Amiga controllers
are backwards some are not. 
	"The use of excessive force has been authorised in the ..."

And then people stick TiVo disks in their PC's in order to prep them for
various TiVo hackery.
