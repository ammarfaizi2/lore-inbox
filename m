Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129064AbQJ3Pcy>; Mon, 30 Oct 2000 10:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129201AbQJ3Pco>; Mon, 30 Oct 2000 10:32:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:55347 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129064AbQJ3Pci>; Mon, 30 Oct 2000 10:32:38 -0500
Date: Mon, 30 Oct 2000 16:28:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>, kumon@flab.fujitsu.co.jp,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was:
Message-ID: <20001030162815.B21935@athlon.random>
In-Reply-To: <E13pYis-0005Q0-00@the-village.bc.nu> <Pine.LNX.4.21.0010291135570.11954-100000@twinlark.arctic.org> <20001030072950.A31668@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001030072950.A31668@gruyere.muc.suse.de>; from ak@suse.de on Mon, Oct 30, 2000 at 07:29:51AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 07:29:51AM +0100, Andi Kleen wrote:
> It should not be needed anymore for 2.4, because the accept() wakeup has been
> fixed.

Certainly sleeping in accept will be just way better than file any locking.

OTOH accept() is still _wrong_ as it wake-one FIFO while it should wake-one
LIFO (so that we optimize the cache usage skip TLB flushes and allow the
redundand tasks to be paged out). I can only see cons in doing FIFO wake-one.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
