Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268967AbRG0UqG>; Fri, 27 Jul 2001 16:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRG0Up4>; Fri, 27 Jul 2001 16:45:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:269 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268962AbRG0Upl>; Fri, 27 Jul 2001 16:45:41 -0400
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
To: michal@harddata.com (Michal Jaegermann)
Date: Fri, 27 Jul 2001 21:46:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010727143952.A14248@mail.harddata.com> from "Michal Jaegermann" at Jul 27, 2001 02:39:52 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QEVd-0006UJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Regardless of possible weirdness in a "smart" behaviour of 'mount' what
> one exactly buys running a journaling file system on a _read only_
> partition?  fsck times will be the same (unless you crashed when
> installing new software :-).

Several things:

1.	The simple case of remounting an fs read-only is easy, since no
	writes means no journal

2.	The software suspend case is horrible. Right now mixing a
	journalling fs and swsuspend tends to cause disk corruption because
	journalling fs's write to disk when told to mount read only

3.	Failed drives. Here the journalling mount overrides the read only
	request and the machine locks up preventing data recovery except
	by copying the whole 80Gb disk image to another disk

	Been there, it sucks

4.	Snapshots. Making read only snapshots can be very useful, and there
	you want the replay of the log to be into the page cache but not
	written back to physical media until its marked read-write

Alan

