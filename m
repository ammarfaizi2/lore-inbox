Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSDHAt0>; Sun, 7 Apr 2002 20:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313514AbSDHAtZ>; Sun, 7 Apr 2002 20:49:25 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:11145 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S313512AbSDHAtY>; Sun, 7 Apr 2002 20:49:24 -0400
Message-Id: <200204080048.g380mt514749@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Pavel Machek <pavel@suse.cz>
Subject: Re: faster boots?
Date: Mon, 8 Apr 2002 03:48:42 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Morton <akpm@zip.com.au>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu> <200204060007.g3607I525699@lmail.actcom.co.il> <20020407144246.C46@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 April 2002 17:42 pm, Pavel Machek wrote:
> Hi!
>
> > I'm curios, how much work can you accomplish on your laptop
> > without any disk access (but you still need to save files - keeping
> > them in buffers until it's time to actually write them).
>
> Debugging session (emacs/gcc/gdb) for half an hour with disks stopped is
> easy to accomplish.
> 								Pavel

My suggestion was: there should _never_ be dirty blocks for disks that
are not spinning. Flush all dirty buffers before spinning down, and spin-up
on any operation that writes to the disk (and block that operation).

The opposite to that (which I do not like) processes create as many
dirty buffers as they want and disk spins up only on sync() or when
the system is starving for usable memory.

An aletrnate ides (more drastic) is that fle systems can mount internally
read-only when a disk is spinned-down. Means - you cannot spin
down when there is a file handle open for writing. Other than this there
are advantages.

I don't see how any of these will stop you from doing emacs/gcc/gdb
with the disk stopped, as long as you are not trying to write to the
disk or read from files that are not cached.

-- Itai
