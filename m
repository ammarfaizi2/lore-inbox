Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRGNQdr>; Sat, 14 Jul 2001 12:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbRGNQdh>; Sat, 14 Jul 2001 12:33:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52236 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262568AbRGNQdT>; Sat, 14 Jul 2001 12:33:19 -0400
Subject: Re: raid5d, page_launder and scheduling latency
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 14 Jul 2001 17:34:03 +0100 (BST)
Cc: neilb@cse.unsw.edu.au (Neil Brown), mblack@csihq.com (Mike Black),
        linux-kernel@vger.kernel.org (lkml), ext2-devel@lists.sourceforge.net
In-Reply-To: <3B507380.79381536@uow.edu.au> from "Andrew Morton" at Jul 15, 2001 02:29:52 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LSMl-0001Pk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Happily, we've just fixed the four most gross sources of poor
> interactivity in the kernel, so let's knock over some of the others as
> well - a few /proc functions.  That mainly leaves zap_page_range() and
> exit() with a lot of open files.

Nowhere near it. We have to fix copy_*_user and strlen_user (there are reasons
2.2 uses strnlen_user). Map the same page into 2Gig of address space filled with
non zero bytes. Map a zero terminator on the end of it. Pass pointers to this
for all your args and do an exec().


Alan

